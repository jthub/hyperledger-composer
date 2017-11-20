import { Component, ViewEncapsulation, OnInit, OnDestroy } from '@angular/core';
import { ActivatedRoute, Router, NavigationEnd } from '@angular/router';

import { NgbModal } from '@ng-bootstrap/ng-bootstrap';

import { ClientService } from './services/client.service';
import { AlertService } from './basic-modals/alert.service';
import { IdentityService } from './services/identity.service';
import { IdentityCardService } from './services/identity-card.service';
import { InitializationService } from './services/initialization.service';
import { BusyComponent } from './basic-modals/busy';
import { ErrorComponent } from './basic-modals/error';
import { WelcomeComponent } from './welcome';
import { VersionCheckComponent } from './version-check/version-check.component';
import { LocalStorageService } from 'angular-2-local-storage';
import { AboutService } from './services/about.service';
import { ConfigService } from './services/config.service';
import { ViewTransactionComponent } from './test/view-transaction';
import { FileService } from './services/file.service';

import { IdCard } from 'composer-common';

/* tslint:disable-next-line:no-var-requires */
const LZString = require('lz-string');

declare var ga: Function;

/*
 * App Component
 * Top Level Component
 */
@Component({
    selector: 'app',
    encapsulation: ViewEncapsulation.None,
    styles: [
        require('../assets/styles/composer.scss').toString(),
        require('codemirror/lib/codemirror.css'),
        require('codemirror/addon/scroll/simplescrollbars.css'),
        require('./app.component.scss').toString()
    ],
    templateUrl: './app.component.html'
})
export class AppComponent implements OnInit, OnDestroy {
    private subs: any = null;

    private usingLocally = false;
    private showHeaderLinks = false;
    private showWelcome = true;
    private dropListActive = false;

    private composerBanner = ['Hyperledger', 'Composer Playground'];

    private busyModalRef = null;

    constructor(private route: ActivatedRoute,
                private router: Router,
                private clientService: ClientService,
                private identityService: IdentityService,
                private identityCardService: IdentityCardService,
                private initializationService: InitializationService,
                private alertService: AlertService,
                private modalService: NgbModal,
                private localStorageService: LocalStorageService,
                private aboutService: AboutService,
                private configService: ConfigService,
                private fileService: FileService) {
    }

    ngOnInit(): Promise<void> {
        // Grab GA ID from config service
        ga('create', 'UA-91314349-3', 'auto');

        // Set page/send pageview should be part of routing: issue 2779
        ga('set', 'page', 'composer-playground.mybluemix.net');
        ga('send', 'pageview');

        this.subs = [
            this.alertService.busyStatus$.subscribe((busyStatus) => {
                this.onBusyStatus(busyStatus);
            }),
            this.alertService.errorStatus$.subscribe((errorStatus) => {
                this.onErrorStatus(errorStatus);
            }),
            this.route.queryParams.subscribe((queryParams) => {
                this.queryParamsUpdated(queryParams);
            }),
            this.alertService.transactionEvent$.subscribe((eventStatus) => {
                this.onTransactionEvent(eventStatus);
            }),
            this.router.events.filter((e) => e instanceof NavigationEnd).subscribe((e) => {
                this.processRouteEvent(e);
            })
        ];

        return this.checkVersion().then((success) => {
            if (!success) {
                this.openVersionModal();
            }
        });
    }

    ngOnDestroy() {
        this.subs.forEach((sub) => {
            sub.unsubscribe();
        });
    }

    logout() {
        this.clientService.disconnect();
        this.identityService.setLoggedIn(false);
        this.fileService.deleteAllFiles();
        this.composerBanner = ['Hyperledger', 'Composer Playground'];
        this.showWelcome = false;

        return this.router.navigate(['/login']);
    }

    processRouteEvent(event): Promise<void> {
        let welcomePromise;
        if (event['url'] === '/login' && this.showWelcome) {
            welcomePromise = this.openWelcomeModal();
        }

        if (event['url'] === '/login' || event['urlAfterRedirects'] === '/login') {
            this.showHeaderLinks = false;
        } else {
            this.showHeaderLinks = true;
            this.clientService.ensureConnected()
                .then(() => {
                    let card: IdCard = this.identityCardService.getCurrentIdentityCard();
                    let connectionProfile = card.getConnectionProfile();
                    let profileName = 'web' === connectionProfile.type ? 'Web' : connectionProfile.name;
                    let busNetName = this.clientService.getBusinessNetwork().getName();
                    this.composerBanner = [profileName, busNetName];
                });
        }

        return welcomePromise;
    }

    queryParamsUpdated(queryParams: Object): Promise<any> {
        // Initialise playground
        return this.initializationService.initialize()
            .then(() => {
                this.usingLocally = !this.configService.isWebOnly();
            });
    }

    onBusyStatus(busyStatus) {

        // if we pass in null we must close regardless
        if (this.busyModalRef && !busyStatus) {
            this.busyModalRef.close();
            this.busyModalRef = null;
            return;
        }

        // if no busy status do nothing
        if (!busyStatus) {
            return;
        }

        if (busyStatus && !busyStatus.force) {
            let card: IdCard = this.identityCardService.getCurrentIdentityCard();
            if (!card || (card && card.getConnectionProfile().type === 'web')) {
                // Don't show the modal for the web runtime, as it's too fast to care.
                return;
            }
        }

        if (!this.busyModalRef) {
            this.busyModalRef = this.modalService.open(BusyComponent);
            this.busyModalRef.componentInstance.busy = busyStatus;
        } else {
            this.busyModalRef.componentInstance.busy = busyStatus;
        }
    }

    onErrorStatus(errorStatus) {
        if (errorStatus) {
            const modalRef = this.modalService.open(ErrorComponent);
            modalRef.componentInstance.error = errorStatus;
        }
    }

    onTransactionEvent(eventStatus) {
        if (eventStatus) {
            let transactionModalRef = this.modalService.open(ViewTransactionComponent);
            transactionModalRef.componentInstance.transaction = eventStatus.transaction;
            transactionModalRef.componentInstance.events = eventStatus.events;

            transactionModalRef.result.catch((error) => {
                this.alertService.errorStatus$.next(error);
            });
        }
    }

    onToggle(open) {
        if (open) {
            this.dropListActive = true;
        } else {
            this.dropListActive = false;
        }
    }

    openWelcomeModal() {
        return this.checkVersion().then((success) => {
            if (success) {
                this.modalService.open(WelcomeComponent);
            } else {
                this.modalService.open(VersionCheckComponent);
            }
        });
    }

    openVersionModal() {
        this.modalService.open(VersionCheckComponent);
    }

    checkVersion(): Promise<boolean> {
        let currentPlaygroundVersion = this.getPlaygroundDetails();

        if (currentPlaygroundVersion === null) {
            return this.setPlaygroundDetails().then(() => {
                return true;
            });
        } else {
            return this.aboutService.getVersions().then((versions) => {
                let latestPlaygroundVersion = versions.playground.version;
                if (currentPlaygroundVersion !== latestPlaygroundVersion) {
                    return false;
                } else {
                    return true;
                }
            });
        }
    }

    setPlaygroundDetails(): Promise<any> {
        let key = `playgroundVersion`;
        return this.aboutService.getVersions().then((versions) => {
            this.localStorageService.set(key, versions.playground.version);
        });
    }

    getPlaygroundDetails(): string {
        let key = `playgroundVersion`;
        return this.localStorageService.get<string>(key);
    }
}
