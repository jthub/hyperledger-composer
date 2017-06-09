ME=`basename "$0"`
if [ "${ME}" = "install-hlfv1-unstable.sh" ]; then
  echo "Please re-run as >   cat install-hlfv1-unstable.sh | bash"
  exit 1
fi
(cat > composer.sh; chmod +x composer.sh; exec bash composer.sh)
#!/bin/bash
set -ev

# Get the current directory.
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Get the full path to this script.
SOURCE="${DIR}/composer.sh"

# Create a work directory for extracting files into.
WORKDIR="$(pwd)/composer-data-unstable"
rm -rf "${WORKDIR}" && mkdir -p "${WORKDIR}"
cd "${WORKDIR}"

# Find the PAYLOAD: marker in this script.
PAYLOAD_LINE=$(grep -a -n '^PAYLOAD:$' "${SOURCE}" | cut -d ':' -f 1)
echo PAYLOAD_LINE=${PAYLOAD_LINE}

# Find and extract the payload in this script.
PAYLOAD_START=$((PAYLOAD_LINE + 1))
echo PAYLOAD_START=${PAYLOAD_START}
tail -n +${PAYLOAD_START} "${SOURCE}" | tar -xzf -

# Kill and remove any running Docker containers.
docker-compose -p composer kill
docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
docker ps -aq | xargs docker rm -f || echo 'All removed'

# run the fabric-dev-scripts to get a running fabric
./fabric-dev-servers/downloadFabric.sh
./fabric-dev-servers/startFabric.sh

# Start all Docker containers.
docker-compose -p composer -f docker-compose-playground-unstable.yml up -d

# Wait for playground to start
sleep 5

# Kill and remove any running Docker containers.
##docker-compose -p composer kill
##docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
##docker ps -aq | xargs docker rm -f

# Open the playground in a web browser.
case "$(uname)" in
"Darwin") open http://localhost:8080
          ;;
"Linux")  if [ -n "$BROWSER" ] ; then
	       	        $BROWSER http://localhost:8080
	        elif    which xdg-open > /dev/null ; then
	                xdg-open http://localhost:8080
          elif  	which gnome-open > /dev/null ; then
	                gnome-open http://localhost:8080
          #elif other types blah blah
	        else
    	            echo "Could not detect web browser to use - please launch Composer Playground URL using your chosen browser ie: <browser executable name> http://localhost:8080 or set your BROWSER variable to the browser launcher in your PATH"
	        fi
          ;;
*)        echo "Playground not launched - this OS is currently not supported "
          ;;
esac

# Exit; this is required as the payload immediately follows.
exit 0
PAYLOAD:
�  >:Y �]Ys�Jγ~5/����o�Jմ6 ����)�v6!!~��/ql[7��/�����}�s:�n�O��/�i� h�<^Q�D^���Q�"p
G�/�c�F~Nwc����V��N��4{��k��P����~�MC{9=��i��>dF\.�&�J�e�5�ߖ��2.�?�8^ɿ�Y���T��%I���P�wo{�{�l�\�Z��r�K���l��+�r�SǢJ�%����Ӊ�ag���3��
��N�O�����EI��R�|R�N�i����(>f���b�"��y8eS.a�4M�4�:$a��"�#��>M��ڎG�.�">��d�5�*�e����)�E����#���+�?R� �����Nl�jM�>��t��Xk�֩R�.4Q�e$�e���$X`�{+X�R\�ʦ�m�0R�?����_5�
�B ��@���c%�&�'pG���&�OQ4�!
�\gu���=���p:�JH�w��L�	k[�ˋY�E�[�~dK��B]��:uVT�����=п)~i��^4]�~���c������R�Q򿫸:��N���3^��(�cO�?�T��<�����$�ڼ����7�n7�́P֔��'���e�ϚKq�"Zhsa���gݞ�	`ƅ����Y��i1o���h(Ń :yNik�����֍��2ġ�i�:n��L���xYCrf�ԙsu0�O�m�w���q'�ǅ������b<j����)1�C�Aɕ��`!��C.��z�/�-A�(`~��D�MSى�C�;�?W'Nc9xkcŝ4�s�kfQ7�n$m,lq�0�W�����\�O�"��$ͽ������Nip�3m�P<Q(tzSP(@d���*F����͡]_�w#�L	��0{�nq��V�����Mm@;a���K�*nG(�JK�2qs��3���58O���{B.rp��G�'3�;�A�_�� \�_�[ix⹱� ����"ב.�ˢ�N�rІobd��<�� �-��hӁ����H���Jy`2��E��#�ס��L�Il�@�0�"�l�Qs^?���߰����!���-���&���>d�b��F<g�x��r]�a���l���+����Ϧ���=����������6����>�%�����k�/�
�w�;�ׁzd�7�;u��%�-��=q��%��|�!G�8*�#F��P�1��	���#;� � WS�.�
�{e�ޗ)����u~�e��i(��C�ل��<��.G�މE�r	��b�֐�ek�Dj�b���:w��-��uy�H�\̭���.�� 
@s�e�Rw���=s�mu�4@.�'���	s�0��ax�@����4���Y�@��
�9�W ����&3��r9!��Y��g���n���P��{��oi&�MI!%i㧓F�s��@[�!jCꃙm3�i|����$�E�|����Ś����`�~�n3�'0 ������\ג�p5E�̪9�8L�!����S���w�7��{��$�*��|����y����Z���������?���������@J������?-������+U�O�����):�I#������8E��_�!h��Ew�e
���E� �h��H�����P��_��~�CՕ�W.����=q�w4)h��Hc=A]f��\�������F��/���ec�m+��qCN���o�|�-[ʰ�l��a��%ǜ�L7�t;��=�csc����
p;�nX@�$�m��=�������g��T��������?d���@��W��U���߻��g��T�_
>H���?$����J������ߛ9	�G(L���.@^����`���W�%��wkp��L̇0�н4��>�
��*@�tb�I�7���txs�;��H��H�\u:w��f�z3�7l�k���AS�(^��b�.u�A��U;Ǝ�Y�{�u�9Ҷxd\�ǈ�#}/8���sr��8m�<V	�Ti��� =����4�+qz��	'��>Cm��LBDy�Z|g����haڳ'�&Te p�� j��a���ЬG����l�]wZ����Ҟ)-K�z��͎���#JH;#)ɜ�H^�n�@B�<�+���z�Z��|����?3�����|��?#����RP����_���=�f����Nv9��Z�)�D��������1%*�/�W�_������C�J=���
��_������=�&�p�Q��Ѐ�	�`h׷4�0�u=7pqaX%a	�gQ�%Iʮ��~?�!������+��\��2aW�W���X�plNl����{���6[�A�z�^��+����q�N+)54$wm'���ǫ{���(ǌ��v��7pD���������=n2�L?�SJN�v�*���x������O����D��_� ����������].����˔����	�Z����Px��e�p��i'+������K�A/�?�bHu����?�>?�IW�?e�S�?K#t�������6�26�R��Q��,��x4B��x���o���FQi(C������1�S�����`�����x�����	���m,� �r�+�5�D�|����j@.�l�uw�9��+>��z*�F��Qc&�:e^3�Z������p�i�a��3���}m�`�`f���ϻ����������J��`��$���������'��՗FU(e���%ȧ���U��P
^��j�<�{��΁X�qе
�%,�!?��<�}t�gI �����7����*-û���֍��{�.���@7�Gy���D���=�Z�a��=
'���N1��+݅��ΈA??$��}�؄q��1r-��f��Ex�p�LNp�ɬ'��x��bs5�9jo�EsI�٠��`�uF9��z��2<�Q&�3b��Cb����k�Cba΅�x|�s�[SW�m��Dk�
?o@���P�r<����T���xl�A�Z�n�yP�:#���6\�����|t{@�	NSΦ�4o���7�ڊlt��H�,�e�S����Ӷ7���{@��p��f�	zR.�do��l��-�U].��x�4������������q���K�oa�Sxe��M��������-Q��_�����$P���^
�v���c��_��n�$��T�wxv�#�����2?yf(?��G�tw��@�O΁@�q[z-PS �]��'n����I>�AB���Nu7%�},mQI�����z�6�}�VzjJ���[3�c�҄�!��fL�9M���Tnx@A����㤯&���A@OB�=��܇.���� ��Y>h��@�Dk�<�w�u7��+e0��j.uq�?%s9��V{f��!Wk����=h�t�0B��G�P��a�?������/�����Gh���+���O>��������X����?e��=���������G��_��W����������\l�cV��s9�\��[w�?F!T�Y
*������?�����z��S��[)���	��i�P��"Y�eh��(�	�	� �]�}�pȀ�� �}�r]�q����V(C���?��B���O)���PZ�d��a�2�f�����9��6ض��"o䑶hQ����hN�m�`]	otw�K��#`����;VaDI�1�ַ����0�k�d=�(G��b(���:�b��W��/v�~Z��(�3�z->�?_�(�ԓ�/�a��/[?�
-����e~���~���\9^j�id����d������b9��N�+���c���B��k��^$������2���Mj���8]�oxp��*�7�_���zu쇟�>���:�~��I|=��SY1q#{�}�e�ڕ[���=jG�kWE��q�"�.�ګO~���F��Fs�}> s^�ʩ�X|=���ծ��l��&���5|IV��o���\�ӥ��,����}sw3�hpk+�Μ���j_�V��.�[]]uQ�i�����MG��
A��o���ϋ��׾�WD���e�ZSI��`�j���y�av}�U��E�g_�l��ߓ�o���7��d�y�,�3�^�����c�u��ڋ��/{lyˤ�>�zqoOW�O����������O�w������[������W�����@.j�=l��SW�8�O��7M���8Y�a���	��.Nד�s]��,�GR��j�h�B"GE��H	����}7A5���~�ȇ3�x�i��NU��c������	d��
�8��!�"v�7�h�<n��#��:����M�X3B�+�Ʒ�r��
��$����N�t���-�q�ı�뻱=�Q����]�����^��]����h��Hm���$J�!��b� -�|�k�m����j��@џ6_EM?ZE_A��i�%)�=�̬g[�c�"Ͻ��s�9��s_2azR�ڤ�9S,�[����M��&3Y����y�ܔ����&b���P4�br����A,�Nf��ԣd&|�2Pۖ�12�fKB	$�y�f́ͺ3-7L�0�=Zl���������y��L�6LΊ�6�*�����H�҃��]7�#�D��:T^�c��pE62iP1�R�@,�,�����f��Ȇ��z[��	�Q۵D��'��=1'��d �Ifs�A]���Xj�=��QE�rI?����s���x0��Л���	�����H�4zC/����ޙV���S^���^"GEhrE{=t�r�eYSr�5%?��t���Z�emҜ�g1�K3m��Ɯ�͜z�̩�W��R�2����vM�ؾ��.3���;m��T�#Wq����s�An�$QnN|�9�*J'��Lw O%�Y4E�~�f�c�	�����#N�T�5ǝ)S�L����!���c��g!*�ƫb�@��1���®h>������gh��E�!((�-�nb�^�w Ȏq@�"�ڒ2(p���
�N��(w��043��f���z*_G��5��Csc�Q��α ϓ�w��J[�(�5�����"����9���B�PLЈ�́�x�J��qG�����D��#�9,vF�E{I6z!�uz�ȳ�E.�k����S5p�P��Dh�O��F��gE���ӳ�Roҧ���&����}����V��R����
����E�e�?���sg$R��Af��l|�ɴ�a�og�a���ar���iX��.�2'��̴}�����R:�
V��5�����M����5��H����I�_8���dF��V�~.F����?��h��i�C�-�o���Bҵw��(eN�p�3�^�Ȇ���uNǛ�$�\�U��t#H�vd�\�V`g��I��m��y��-s���5|��6���q�q�|��߹�;�û�H_��+�#�9�v��oP�q
,!w$	s�A�Q2��95����N-ŞA��_���*��q1d3P���%k(��`6�L�g�1�4����y��x3�ID���	��B�jT���� �M�-Y��T|�ۋ�$`���V�$t�c3R����`��-pj�4��D.��,��p�2��U�KwD�Ȅh�(�q��!�L����)I�4�	��^]��b���}��G��-C@���l�aq]�����6�
ȸ(�f�
x���'���sT�P^7`lWe�mC���xY��ݻc��6�ɚ��� ��u뽠q<�(��9up6�Ĵ��GBd��y;~+����h�/��ݔۋ?�!ȹY�!i��ה���V�����"�h4���e��� ��	M~ہ߸��{�D<2L/�7f�W*-��QO��l�����ڜ�~1i��_�t�����k3������/vZ��s��4 ���&�����Mo��"���pmL:C!���n�"�#�$�dQ�be�>q��m�7�s��@�yU�taų���c	N��S�s3��������i�����)�X���������f�1ɜ#	
]AR�h��93c.o«��fy��i4�*��5<�res�����h5^W�8�'��D����L4���-h�+���-kV'c�޼�x��MD�1Q�3į?�Nȳ�l4���?O�Y^S ���Y��qN�:-��\���h�>�឵��^�ee��T���ӟ �h�r��l���Y���S=��vҍ���X��\�r�#�fМ�*ܻ���;{���� �����"��m��*���t�1����;xB�q�;���:��7��Ɣnl_@<YQ�Y�NXl��D�ę"��Y�� �i)r|q:���_��q��?^�����I��߰p璂U��������$7�!i��?Ϥ��wy�3�O�ݛ��.$ͬ�bQ/�ȰV5TUQ��۪�:sA���T����'����=AX~��э�=���I�*��X��x�&����]`ജ{����|�:C��f���<y���y&�W��:�q��4������OU�ϥ����P�jF���W����o��|�ܧ8�bE��'ݭ��r��N8�lF���+�E9������I�U�����i�ss����Ϯ����Ql�8�c��BG�A[��_г��!k#��˓%�� ��������ص�A�w%m��n����?�=��H騣:�.+=��N~JN�����'�W�=�����n��^L�����U������g��i�#Wa�{�h��g}]1�܁`�l,�W�&#5�Wd{OrgT���C��:1�oJ��0�q��f$|q��	�$Ah/�
�ӼfÙ[kQ�[Pm/J����<RhhN�;
>����ko�El]~@����5��h!G� j%-�s�<Fl����@����F�$��&�ˮ�X�)�ɕēk�~w�����ǚ��[/΀���?��rn��N�����&��w-;���I�l��(�{��_D?? �A��sW/]���~��^p�d��{��*�u���=�=n�#�n�[�zi�Wvs�ǹ]eO��t�]>O�t�^�w�43�ϣ���7����[���;��f5�G�=����<��G�����~����İ�t�����?u`�� ��bc?���?{|=~�6��oc?x{���<��R3?���h^jփ�ks��ws�z��\�����E�|"��{�F��5{��+�j��La�~2dfn�Kq<��f05־<ݝ�8��?��v!a{u�T[��a �$�M��zg�] "�~6DQ��V�˙a�/��V�����a�����|5t�6��yڗm��Q=+l���t4��K�LV3m\������P �5;�c�g���}�����	�L<���B���Q��1#�E� >qA�q�������@4hk�l&7跳��T��%���Kl��X��y��+0,��r-ZK��6҈ZB�?�nV���Aa�펩�6�t�G�$���.��~xis��&��Mx�܄��p��-����ha�!��3�����������J%k��M���@�p˺_�D���HFl���1w�q$��I����%�q�}�t{��t�O�CtM���^-��ճl(פ�|B
28�e���t�̔RDZ&� ��Y�'��1gYg��`-�
�,+�	o����/2A�PCZ�.��rQ,��!o�nq>Qs3"ˀv6���N�/��]��i%��x9qP()�M3T#����a��
���%����S���� T��<ǼS�p�M�Ȥ�����tћ����w�2G��J0���)�ފ�����Ȟp��TA�;��0i)�׊R,g�*���qO:�de)5',3�S�K�%�����ا3�a(�u�h\.p�ޡ���N8��\�A+^gHCX�j��}i�}�>�Wcɰ�%[�R�W�&)O4Q���v��=[a�.��a�,,�5�%BG{B:F2�>O�B���D�> �ĐJ�:C�uX.�܄���)5ߞ�2�HQ�?>��J��4�c�bɨԤ@IP����� ̸iu����;�N93��&�ex
v����ۄ{��	�}N��ڑZ#�A.�+z�f��ݹ?$a�]ia�)�Ǟ@���T^Hy���p��\�Ε�� A���N3}��86>��g��l��lW/1�<�A�������޾�e�*v��?w�KW_��:9��3���������y��W&�l}yUF@[	N���;�~N���xJ��c�a/�(���� �W��5:�S�D~����^ex^h�$�/�~�0c
A�Uј{Ӱ��^�7��u�ܠ-`[�%�H�� /�dš��v�2�����o|�!nW�a3���_�����s6�{�U?
��9I��c_�^��/��1Q��6�z1	3j�e�`?��0�6䅉����0X1N��~�]%!�����a� �F�}���3���^�!�y͌��r���[��6��͠`�A�G+������N��P���V���?�����k?7����m�k�����������!"$Q<��BW(����>ʱ��?mv��x�
u�li �
�WL4����mq��[�͙�dh.�Kvw�wA0���`�$�?<r��J1���wQ�m���pOc��QOc��	�`{�ުq�R���`[�x,@t��m��/�ܪ��}aN����=6\��M�0 �� �`���ݵ���-�>$���t:��F<��G�Fq���!�AS��L��A$9d��Z=3Vk��'g�.�)N �F���T?�"�� ��Ά���i�0�nF;i_ȓ���B�NP9�n�M��c]�L8yg���<�|s{�hC��'�c�h�/���P�T�$�n�����'�Cw��)M�D���D�D�pl�c��X��:�^һدC��k���Y��d��ϴf���nboA�7'2��]�3�}ޑ�E�����_�=�[�s�d��kI��D���D���y�V�d�ɨ|2i����7'@�*?��ȸ���ʃ�V��`��3�D�Y�"#���$kB����a����B�t0$���	_=�>>�C~i�'SY�S���=2��;4�O��3櫁�R�"�A-F�:��t��`��D��QJ"c�)LCfc!���q,$P���u�������G\�<ѡc1�!q&
]���v�n�x"v,6#I􊥺N�k�X�_uK�
��4;�\:A�����H�N$^�W
��1��zb_b�C'������G��n��d�b�(Tc����Q��r|є�T�5�[�)�N�M�X#��VHn�0����r:�4tdxVW;��Q�h������	�-+��T*��i���*xyj��~lY�2RM�U��0�.e#��<��Z\yw.��H���<��%����ʮ����׾��o���|����;���_?��7��4�&s�Ə�z��&M�S���{��ִ]K����'�X�������!����I�q�я��/ƻ����?����^������������g�Zz�W�2#�82�O�	}���|����pl'q�t�G������v�$G�+�,����X���B� b	h$6H��vn�tҗ��������u����qU=��Uo=�����c��~��� �]��DC��ŏ���_V�����Zm'��?�އ�o�/~�'�����o����i����w~����/��+���B;���ïC;��v��N�	�@� ���q���`@�v��N�	l6`��!���x��A�>#��%a�4�c>z8�-*C�����B�~����6���C���ÿ=���|��^h�| q��q`*L��8�8@�,��1���#�ag|�ro��c�X3F[���, , kf@� �#�53�X���%0a����sÝ1��Ұͷ�����+�t����~c� �8;��X��<���D_�S8N�#��!!(�5�J|�}AA�j�s%��\���[m�q��]1V���f]�J^m����湻lI?�C���9l��>	�c�쫄�	d��zx��w��2�Wt��e�^�q�S�a��|.���������B���h��`�I�J0�f(&j��j�fj8�0,���0*��i�(͒$��9�@%Z	��j�s�}���`f�Cc�]��փo�����d���^���W/����ـ�.�o��k���f�ޑ���d���g����<Z�JUA��ջ�X�\� ��b���X�}B.W�M��I5Y�gK§�l�K��
'j�N��d���[⹂o�H§���gS��GO0t��&�GoP/���w�*��wUV;�>��\���)�[ǹ�g��7���<y�=���m�ۓw��Ju��}��ӷRv�����*��'rVjl?��W��Yv߷����}��������v`���o*N�`G�����v������$<Ek8n��
z��-6Y��At�����#z"���g�zͧ�au�nxl��G��/U�;>�IE�$�w��7��vK6�@�ś�'�N77e���T�����+�;���3ņ��hc]:�}ueY��ߴ���)���jm�a�&�3_�;`��;t"��/�R��ճ��!x�ĥ�R�&��J�LA�����slIu]�~D���.�j�+�^ݓ=NL�i|.�;M�A}HD�����G�sx��r���='ln��jK�,/���1\w�;0M��j��f����F�z�#�o�����%12܀f��J��]����n��ѹ�Tɀp6�:����>��B����3[���u�o��R5/�-�����S����w�<��c�������j���j�1��U�����q��^6��O�O[�=G�g0�_iVy����Νo���Ίڰ)�8�������ĖM#�}:E_C��^�����:�S�@�����큵���LH8{��x^����?$�������,���y"���G0��>{����>����Q�x��_w�A�?�S (�0p	_�Z�F�Bw�˫�7��*���������፞� ��-�}*�s��x��h�G�m"�����?Ă�i��Q��a \��ǵltq���Q�?F���O��?�����麎S
�
J�4JS�J
�k,BQB�j��`�����(bƝ�V���!,�<�Ap=���
�VM��P��p�D^lm�Ne5����$!���$M����eNnl�b�*(k�t�3mjT໼m�-���%?V�"Tڜx�U[��Ԧ;pA������F�a����$���_�6K_w;�4����	j��h�Y�&�dR�Ԡh�4E����|�[���׈�E�q��Q;��q����p��U�z�qr� | ��}��q�=��H��"����UQ�����(�c��O�/ ���T3N�fD�2�A�?�F���a \�/���q��߷�����`�7D����@d�������	������1�OS���:����yq1����Xe��>��9��i�s듯�C��B��<����}O�Z��K���
\E�͖C�N�?�-���˕bW�p��^���@V<�����`"p�s����ȝ�U���}���9�˯��{)��I����˅�!$S���Y��p*ixٛ�J��tI��������U����Q�a���Sfل$w�[k�4��~��.Q�d^ʰ#K癖.0���S]���I�ʸ{=�yfR�TJ��m������N�`�'�k�i
������o�/���G�H� ���0�����������0��~��`��������?v �����b��@�#2���@�#n ��?j���!"�'�6q�ݤ����8E���!hJ1	�EL�LcU
�SCI��
��:���L���/���g�����X�*i3�o*�.GNAo	�T��q��õ��_,��p�����[f���f�q�Y�g�7�G9�:9�^#���H�;�d�:m�nZЂ�c�z͍�	��n>gb&u3F��t$)�6��x-������n��?������?��?�Cd�B�b�� �'B����@��� ����@�#n ��������@�#:D����@d����?"���?�;���S)|(�0��s5�������}f�{
K���F��=ѻ�s�T[ۼ4)u��T�+�WC:%���q'Y���n_oryx��֟�ԐT�	I4��*��zy:e���וj�����e�Y��o��*����$oa�<WZ��&p����N)\�H����9�V
JU�����N�ׂ!��	���Ŝ�uۼ��弧�;��|��eY���,�� ���~9e�oM���Ҵ�'��\W䆙^�+��Lh�i���-��t^)����kUJ7�j����f�T1����0��H���֝|�ʥ�>O�2��'��M޽��q����Gt���q��߷����!���qA,�0���?�����w<���_S�n���?��$���@���޴�3?���_a�S��0 �`������q��0�D�/�0����(��k������A�Ck�b���ᬦk����(���������,IR
P�xs�Q�����?p�4��B��E�]��dR�[��m��T�כ*������9|YY,�Ҁ��@	���=���e�������c)#�vr����Tn����gr^�5�rC�RY@��!�dx�l�k=չћF�O�5����ǫ�=ۿe����q��B�`�/�E��\+��_�8�#���@�����kDx����B�b�0��|�'�`�/���G,���@�wD���n>�� b ������9��?BA��������G��8z4��?CB<����E#LSUE!5F�X
�0
�5�e1E�L�F\�47q�`LS5�aL�a��y�>����Pp��o	���n�h{,�☚7��<f9ƚ{��%�\$������A<�'��$��ժl�l�jt�S�a�',�$?t��PZVL��2 1l	Ϋ�9"̊IG�+BQ���S=�
�_�8��z�E�`��Pi������{��,�'��cD�����BD�?� �����?������_:�]�U�
Kb"Yf�Ř&K���\d��X�u+-{H�pȻ��Ԋ�sTA��W['��<�.n3������'����ܙ6��as�WVqF�C��%����-cE!��������v��Lk�/��:�V�ͺ\�=q��M��к��o��B:r�她չ����5Ѯ�ruXkXq�=Z~���O&6䔴zG�\.�����Ҷ�F$��Hd�XS�Ӷ��q����$��%�=&��1e�S�z?{C�^ѩ��<�ŗ{���ug���Ғ��	��Pƻ��5"�}�HNi����D"�^���Ϝ�^��u�H%�|?�V��+��*�FZ7]U
��uɴr�_*g���%Ӆ����)ǳ�|iO�Df9!%rݔB�i^�'e��.(47T�Ya��u��:rxJ��3���'��gB���\��v�,��4M�'|O1���5IV�N�v gҍ��,������`;�����m�ł����?dĄ�O�� a �������`��P�2���N��6�a��u�ޜ����L6R�#���g��9�|��Q������Ku`���@�������lM|0l��O��m1��:ˤf�酕��iqNdf͌Svf^%Sk)r�hye��^1ź�CU��1cG�VJNyu��Q7M�j��q�8�<��pC����v��s��Cw�C�V�kdoT�8[SW�^�ݒ]S&r��dƓ~���.�I�_��{�В
�ĭ&�|�-�B&��6QZ ��,,��T�ޟ����������P���������_,�?�����X�?��������d ��`����������`����Dq`���8��(}��BB�X�1F����S4��C�������k�������WT��'tB�iCI�bT�d	���H� p�DM��p7PB%M֠L�0J�0Ue0�������N����������N�5ӊ4^.r�nӂ�����fW���,�^�V9���G�1��V^ΛX)�gJs�.�]*U&`�$y}Z���ަ��LT������d��#�U�H6�2囚�DY�[F=���Z���ۆ���ʶevƥ�yIό��A�� �]B��C�� ���*N��L�󮛰F	�k;n°m��&1��#7�	�*#ݹ��M|4fdm3���嶋����}���lk��{�;���o,>���r_W�����*q���Vа�w����˲�4�M���	��N������eϱFзP�ǅ�W��U��o�����������6q1�	?m�kW0<�4eб��FH�"��*��7�Д�m]w�0)��&�U� �ķ�O��1��ۨ.�v�ȻK��1z��b���o^�/un��^��ɯ-MeP�Kp�~�-��wj���i�/�A�p����97tƒ�	L�V�׍���?��-���:۱�u�ƶ�F�k%v6B|I]I\.ߺ����M�%>DJ�/n���r��.��nR��E�i��0��W�-����h��pM�@ۏ�3���I�"�F�sq��Ι�3g�9s��ٙQ��2�����f&'��c�$@&r� �B�%b�I�!�4X����4�kQ2Vg����%Li1��T\ӽX�p�1N �I���s�ZR�ob��Ǵ^x��C��>{��:҅�_W�n��������H�}�M�˵q���?o�����Ho"7�0�o�2�������]s�gE�%�7�J�� 5��p��ӓ-|}��!`=��o���|�}�j�ũ`��@�'Mx�o"�\!�	D�,��z��H����9�R�K�q��{�D`V��|a��u$������<�vc�;���?j��d|�V'�����n� �P;Q�{��`��	���ݡ��z�لZ<h>:H�>�K��>Ő'�?z����/=���������>������_{���y��i�4r�����蟭#O�u���:���!�����ϭ����'��;/���2�������s65�t;!����9 ����f�mٛ&{s��9G�-:�-Ӄl;5Ȗ;���O{�N�k�U��$%gv��o~���=*�b;-w ivÝ�H~3��qO*W���fOF����C�	q�^�R�V��QM�wB�"=�4�G}���+�7TjW�a���e�,y7�"dtӼ�=|�G*TG�!����M<9�dfX̖�a�F�Ԡp�S�	�9���-ˣa����;`��X�q�re�f3��JKl ��^S`Sl�7r��qgs��$�i��D��?-�����>���(.����~�n��;��섣�<W�֣Pæ�԰�q��%C��Mщ�6���+�ʘ>�6Q�5@jՋh��f��#4�%�\���a$�o��L~����Jd�^�����mza�~%�e����YWyo�U���O����Q�\L��c�P$��=� �a$U%*$��>�Yg��`Ŋ�iVRMl��w��{@F	\�˪�֋���A-����.�d?��H�W*�tC�߸O7��\����2ՈX哥�iG�P!�h�%vE�R^�Yv=����(��k���-�Ed<
zr/*c��4�A�@�X%�F�u���h%:�Z�t��I��TC$���ި�t��1Y���O'���^Ig��@�B�~o�Yf��`Oe���#������#r�Ie�*%��ˡ�VI��e��Ih�27��Gɞw�%�R:����~�P��ͼ'�ʵ�t�!ُ�YR��e��Y�g3K{	fIzS��&��]��� ���tkDxscO�U�rw�^��`��0Yˡ)F����Ѿ�7jM*ӡ�����;�"�<c�X+��Q��{��������X��b�Yf��`Oe�Bt��!f�KI�0�J,�����A��D���/�<�}L�,R`6;�t��rW��_	��m߸�(�[T-A�r_�@��b�u�f�m6�f[�f[�A�ö�u/�tU�F�Q'�������� �Xyl�Y��֥���1�л(`?k)��>k-�����"C5.����O�)�n�M6QU��ѧ��<~wW����<�{h�(�<G�����H�fz
���˵�!/Dt�B����vtet���3��dU.�z���@��E^���#75lJܘA?��ZAV�z�������&�\��6���'P������.�\��N�⹆�9�i� |s2��&d��/�0�(�V��;�-����|��=:V47,�t�  ��=������y
:Eݫ_	����'�����'��W�[=��^؋��o�;u���'�e�x��.5��j8�Sb�]�ny��1����c����#<t,V�'�бd��L�a���c�3���r��L��Ұ�e�ؠ58o݃L	D��ź�l:����&�����J�B	���{;�������!C$�DFۃ�8�gsa�@D�P8�x+��ͷ�y�>���F��i����p�M�!�ab��Q2f��4F��x�Ԧ�A��H*��q��Iz��Rr|j��Bn���x��R�x��T*Gg�"�H#��B��I*�#�M����W:���H{�f��ذВv�iB�^�u�Ր�CB�4��be��'�)?S8�mᰅ��s�X����
�`T~�b\ނ��a�XK�6Ӓ%��e�@_�/Z
<�ޚ8�yM�s���Y���w�?_=���\��e{���xҖ�DJ��9�5�D�CJt��l���(4�@P+_�s�d���ʣS�r�d��"�S�� �u��X!�SĊ�E����0��xWd�R���\���;ʴ��0?
'�{$�R�dZ�;D!v�S�xx�UI����dj�~�D�ǧ����F�a ��x"�bcɪ�2�A.�9�D��zG��>bu�e����Uo:��'��\��^�7��~�+����R<	6���~~�A�1\��n�\��a9�`�6v��~䉍�Vn�'�}7�ݤ�\k�'�j?O���a�=�hץ-,[8l���&�~<����2υ���K���r�-�f[�F^��vQJ�������H*����-\������M�ѐYfd@��g�hJ�:9�����<+�.��(�� 7JI��\�Cp)��2�G�(��x}}lb�n#�Ȯ|�o?����D�{���7������{���O~�	�w�4R�<~��nv�N���T�(���`jWJ�Ym��靍�x|v��$d}�ַ��Of�������/���z-��k��¿���_-�A�O�<��^�F��D^\y�����bEo��q�Eq�@���?����_��Η;����}�5�3��o���������?����v~w�`:��vh��i�v�av���i��~�wqm��퐶C;��N;�Ӷ�l����y�x�k��{���e�@���t=Lǂ�.#��Yj����+�^q`�Ic��g�?����%4�]Ԏ3��:;���J��R�8[8l����.#y����f�_�[>�9�Ҳ������73�g�g�73�p��q��\�{�K|s_�ܽj7�\kˆm~���W�yU�� ������O���l���m�^"$���O����~;��:~��b�f�i`� �^;���Q4�c�la���ˍ9!�����qV1U�K�0AT0Uf@��i�3C��0NЮu�9x�=6 jSkǨ��84��
��==�i�(�Bh����`�4d]���&�T$�+Ŷ�F�}�j���r�l}�Q�I��SL�0�������p@moa��T���j�4����L�@�� �b����%,UZ��d)Uڂ�TS�d~��U�b�̕S��/b�|.�*��9�+���C,��E�0P��{pb�hr��LC#[�a�P0/�{�59tM`U�e0V.�a=F�r2Q ؀��\�S�+������V�3s�G���p<�����; O��Fْ�yMٚӔ�{��`-���;>,��+�n5�ҺʢI�l ""�
��k @��E�]tv	a)`��g�1��bZ97�?C8.3��۶"���G���"�<���q��7����Ì�;1�K���ls�\�a�����cr��ǋ,�a�c�2JF{�tX��	� ݲF|gOi��.F�J��r�T����-x���_�C��/86�{X��eT�51�^�q�@�E5�$�8P2N�Y.����#�Ox�HjV�h��V ANy��XV�"`���  �ӄ@�~v�c N� c�=]��h��(O�=�9��(�q� ��Ք�'@2�	���w5��u����%Q]�MJ-����{	p����=Iz�9�4�o��NX��u�E7�h 0�NG��y]� �A�*Z.���_�ק�<�"�X1���q5���t� #Z+��i� XKh�I f ��4F�`u��� �P���9�x��TQyO�opl&�À�DS��(��T�X ��}i@(�z1X�79��ix%����l��`�����"��������A�3��s�:H��0MuL���9�7�����1]�=��R�,����ܼ;��&�k0������a��ׇ���s�O�٘�2H�g[$w!Y���"�1�e�>:�p^�g�9�i�\�谂��?�r�I��E��� ����	
nl�� �]����&�@� �����=l��Xk�('N�} ����Vƴ&?��3����5tv�T�5ϝf����!`�iݼ�a1s�i1�	p��3%��`:ON�^F����܍�9Ft��9�����)�_�?ӭ��:�J�>YiS!h#�4)�W���`*�]�<A2���%�Ws�y�B�S�b��L����e%`u��Ӹ(�f��Kj��
�^���,�池��dV;����pj#o�1�$�<\�@���V��vR���6�p��v9��9[�ap�z��r|�,Q�Li�A*�Ԫٚ46S�c�A%��c��=�a^l�a�qOGc>Sk���g����	�9c�f�-�	���S�/�ј��2Z&�K�� �7xt�
Ew�|�|>��$4���?���,4�T�z�/������]h��ĊX+a{Xˁ�1��+m�fV;����e��~�ݹ���C��x�S^�>)��͊��y�t�< (j��fEgZ!����j�N��j~�V|��U���,j���`�(A���7A9t&2h�S��F����u��eڊ,��uR��Y=&)�Tgx5�͍�61�� '�-�'k0��H����e����N�K���K����������c��{-�����ߟ��{�63rt!/.`�PL�f�΁RV?�~yn��h�R�BO��|��B�n׮�P�N����E=pk�4\�~��(�2s8��ڪFhx���<C� @��@���\#14XZ����$�NA��Z��b��@��W�=:u5O`�/�љ�Ԗ-С���p}>�R,�<�@^��&�x� |�DZa� ��80w�+�� �e�IsԜsMn��A�x�Tsh��$bR&���<�����cl�� ;Ň�Fu����)o 1�C��߆����4Ӕ������ZT�ѯn6��8 F�URM�&��7�k=��t��t�*��^i�� GF��m/�8ˋu��.{����K5 �Mh*齛���_���7qd[ߟ�WX�ҝ�Iw�6��'=�8`���'o��`t��Ue̒�N�c<J��(����s�Su<5��j."�!������g���\�E��=��_�ӷd����~R�:�~��#��3�� ��x፿�N�j�h�=�
��~���DS(�A~.�E�& �i	!S��� ��^��!!Uyڐ�5d�6j�ԟ.bz�L��Y����@�	1�+��>��R�>s;rŰ6`$���dp�ΈpVfDO�d�O�����雠��y�����v�ƛ�8^}�"�y���y8�30����'������'/���b�����=)GQX�/�b|!C�(�!:Yu��L������	����{���_GZ@p����t�������976����W��tmB�����zX��/�R�i��P^6槶j��2-�8��p�u�&P:/����%�|�����% +3�-}Ͷ ��9u�N��n��v���%"u(��y��n��~	>_n2���"�n?.SӇg[�2��L��6�#�w^�h(?�cB5c?y���S���oN8�#�����u�}��H�:D�s��/�&���
�E,AhF]+\&A.����3�/�ϥ��o��s/pH�|��.�`��Sا3^Ku�rƊ�O2�4��:e��٪`�)��P9���@e ����4��4@�i��1��~/���֯�Ɉ��V_��B�!��:�	���\#jT�e����L�:m~�G"*��\f����L���p��s�ם���HS��o4~P,؎`��=b!���z�Ce�.�GE�z���v�����@uB?�����w$�uF�A������rs�U�������P�)���8���!�|��_,��j0��|k�
Th�%R�_G2l`;_L�+�8uSՇ_MƼ�Z� ���8��u��;|�}��"�l"� ��c�&�i��T�Dho�]�{�>�ڒ6��W�G�´=���_!��N�_��#������{w�_�o?@�$�HL�;�<���7�9�^�N�5�Z�^�����GPr�n���'N\���~hE=9*��H,Gh�s�M�(5.��%���
�=ܾ���1�N���'��Z�	�аn�TZu2���`�H`����$ݡ��`=��� ��[��o/m�g��`����uG���i���ox���ya�}"�q-."΢�4��A�����!�^��W�����bfN�9T�(�G�=���tGB��d�#Q��u�?
���I�B�m��M�-0@-_��j]�>���sH엍�C��"���T"hº`�G_'��#�aU}��bj�� �<�"�!��P�$C^�5&Hg�=�=�qQ>�c��.�#��\wi�L:5�S�������[ݶR�-0e�Z<0��IMR����ʩ��O��v��������#�0O#���c%_(����Ή�{R��`{�9�p���L8��q"iNG��:[�y+��eu��TY<]o=�C;<�,��-��+g��ޑL�;����F�M�ܒ�C�%�?�4������xK^HK��u���n��]�{�h�WT�zrE�ޝ'	��PY֒b�\�O ����>.|A%���+�R��n�%r���q>Eo�Xt�����>�eTW<��@ݱ��9 ?Fs���Z�{��5{�6��vC~W؀�l�=I+4䂩,3�O�#��^��}��(��d�v!����Q�v����/�B��
GDV:�+�+���xe�+�����������}��~ke`_z�{?�K*���{�����aw��r���o5 ery8��L�I�qvLH�
�}.�
ݓG{2 ���0.����/�	~��Bj�'���m�\�7]RuL�7��7���m��'�o�� ?����>,�a�|%����eD������R���>�˰p�
�r�����:
a��Jj�]�N4�5�!�r�3���H�2v����l,PTu *�Dsu=��C�(��E^ݐ��.H��/��nF�ʺ�Dv��m�V 
H.H-H����	�>,�m~V�������j�)R�NmԪ�L =�tF�T�8�P���Y����s9R�GKWGL/�*|R����//)���)<	w��)�0�H� � G����c"�%rTl��C{�+{h�͐��E*p~�Er�;�.��S���!|���h���a����x7�P���6���r�:O��cu1�����/G�@D��PYK}MA�  �(��r����l	���aa�]����x�--��cR��c�	�G�xV 5��Ƴ
y��y�)�^���v��]�?%o��?������$�����Af޽���������s��,�W�?K�i�������<^���p����������,�N���CnS����ڳAu4��G�B"��P_���h�>Ms���N�9�����o=���Sy���r�̏��Xb�8�����i��qH"�g�����č��K/��������9��r5��)^g4V��0XN���J�<O�\NˤU��sǙTF3i��2YFW5���4M�i�����J������Q�������E"_͒
bK �M�+�%�"��og���А$Y��;��v�9�[����'�m��:��O�n-�p�jaTp��'���'��Azi�y{���TU�<O��֡i�N)��ҽ��d�:9�q4\���`ӑ��SKf���i��]�F����fZj��gS�i�w��G/T���PI��O����?���8$��fG1�������^����}�����X����
�y;7�k��G��t�e����_���������|��מ��H�?�������_�����O�`��c�I��9����9��q�����:� �$�����?���8�{��4��f��S����+W6��b3_�Ӕ]�&^aГ+���S�pD5qɢ~�AM\��ܠL��Q��N�)��*LM,������2��ה��)�{?�^[�v�JS�ɧ0dɛ�������m5k:T�=�(�{eɣ۽���9�jVm�3�ux���E�ՅE��Jq�I^�4ZAh�P��[N��]~�-'���jm��O S�.4ʩ����� 2Ь�o4�"wK�����%xQ����W�P"�|��ɶ0`*���[J�}m����&�"t��m
��n�1ʈ�Ӽ��>ڧ�Flz����=��J�IMa���]��yv�>��U�sT͛��Vk�L�� �r[��W�=C�
6;ɏ��v,�4��ň�d-B���r�|x{�T�������?��␸�������O�`��c�I��>;������Z����ɐD����5���������$A���?�'��4��&�����_"�����č�8�G��?��k�?��q=��gL���I}Ń�Z��29�M��OS9�ϳz��s�pf_�3}��ٜ�1p��_"	�q��+�+�*u��}�6��{o���bm�V���ʷ:�P��Tk�L���,��ZXWz�qz�\���n���z3cv�<��W��n�2�ZwbfKl�w�O=b+L�I{B��؅�ߘ��}��sOs��Y�du4��?�*IX�q���I��?���,����^����8������� %@`���?W����������q�8�G���[�K���ד����u�\Ia���W���1�����Ʊ�XM��(��Rh`���������}K|:��>��Ƕ���������|ޫ�E�";��G�Io41�B%�+�>�h�����L��|l�f�W��1�m����X}��E�"�i���Y3U���b30<�����F����� #�@�}�<?:����F�o�����Ȟ 
��(ҽ(��7��Os+P�,�.����S�$O��BuRϛ��iW��AM�|QI�Uj�ն�(L�7�vJL����^V��jӨ�Աr�k<<u���\�vk��IE�2����$�{J�p+��P�&�4��|��;��o�J�?��z����$K������$�?��q=��c�2$�?��_M�������������y����4���X$	�?��r=y������K�������`���X�����?&}a�/���"��Y5�����Z�������Y^7�>�76�z_gi*�K�*Ge�է2f��s���(�,q��w��K�?���+�Բ���X,jJ�x|��F�A��gC+.��쮱���iF|1���Z����7��p����d���:�OL��ƳnyL{�T�uG�w4�x��Twg	T���w�G#?|2��`�)�ٌq��7�O��1L���x=�GS���"�����0�����e�r��?I��Og.����_c�����o��/�G���Q�/���/I���N�?�c��Eb�����'����?����?}��7���\��� �,�1�_�Y������"I��O�9*�c���i��ѳ*��h��(CO�r�j0}��Ҭ��}�����~_3�\6g��Q�6��_������x����i>o�NO�s� ͹M�RaK��/c+K�L���E��ç�Ԭr��y-�l*fޡ���W�R~b���N�)X�Q��]��5{&��LGNU�҆׵WbbMk��ΜQ;c����o�$��}��+���?�"W^��� �,�����"�����$����m|Z,6I��G�3g�8��E�w������WS�����?���~.��vw[��`����S����<��ĥU�9PEET�����.0��s��=�jx� <T�\�Vs�[�-៬̢Gmj;a����05���k[pm����5���v½�Q�M�n[i*��e�%o.�7�g+�լ�Pi�����%�n�Ӄ��~�Y�����D�h�h���I%/�66J��T)<چbD�٬���j`{�T/�������X�-���|j,�Y��]k�^ǘ����Ws�yn�ZK��+�ǝ�&��ړ�3��Īr�ɦ��SۏID�D
j�?���D���'�߂�w+7��6��(��¤D�Se��(_��Z3}Tl����ܷ���^��E�X}�d��U���U�!�D�1/	���M����Q�By����J�����嵙[�ą�6G�c���
}��{�(vש��E��g��X5�ͬ��i>N���T);�<X"�?��jre��ʂ�����%�a�c��*���p� �/�����p���8��⿴��_�+�l�K���n��jY�t��/�/���7��3C9�(G� ���80�'q`���Qւ(��M:�-����� ��!���pw�;���.�颴I��ݒ[w�^���J��+�2{�Z>�,����qv�j��C�弶!(���ɷf��Vm^��� ��B��� |s�x��l��{��֯YRo�������.���-���k�����m�n��l6:�Чd��֪'+{ڢ�e[=�D���e�E�n�lG���D�"5$e��p��s�/X @��"��C��9涗��S�+~���/w�ڙaʹ%�^�zU�>��U���;���GWb�|��֬=���]���@L�;��]�e�R���Z��_�?�����y�'��q-���u�8�����{�?��;8�k-���`���G����,��������������-����� =ƴ��@���� �_Cz�{j�Wp�ߚ�Z��?ڴ.��b��ɤ��)����?��������d���>UZ���n����d2�Idw���nZ�٦;�l&Nө�v��ږR�M����.ͶS�Ƴ��l6w���������w�O&���%�p�O���|_,��޽8�ϵ���P�Iw��t��ya(��`�{���vg��S?�]okG��v���:��f�O�f�p����黣�m������ׅĳ���_��۾}Q�<�\��l�eYO&vN_	�g�ݤ|���<4=D�5U�
:weh��:�������C�����.D �ͻ>�H��px�z��܀�o�L��oၮ`��ޗr���I���3����6�=�|cc�DV�i�'��J��0o���t���Y�8��ա�A��΁M�n=���
5����5�;O?�N������
�(�k1�ۖ� e�#:}#uE=��;燝�3���ѭ����+�݅(�u��jJ��N���h�ԛ����}�-�/����m�J�+F[�tMu�{}͠�]O�c��O$3�I�����?����8X��$#���,Q#����rO��邉���;f��$�nw��l:���\<�x���ꍬkjc��~Q��/���F1���^��R��͊�`_�Mc�#���2�p^OT[9btIT"�I��$Qx���C[V(YX��喣U(���|�kPI�I�iI9��?��h�u���z��G�JWt�m��ߪ)�*�����Ć�, ��`s�$�����l��x����i�Q�����(���Z�*��{-�tF��Z�������Ǎ���1��p3��B�?ɗJ5^���o&4~
e�����=�E���c�������CM�;gw��z6��b�<�ri�j����� �'����~,4�o
�<�UT�ٍEH;N�0m�6Sqg�h����<S��9�<[�Z����7�Q��nؚ��Z�7�t����:��kY�4Z��#1�o�:Z_4�1C�b���(Da5WgzN�Y��#�b,%3�8���ŧ��r�So��A�.�ɜ.ņ���B='i��j��sN�"�i��鹧Hՙ�#j��]����~8��mr��P�L��[t�X��
�6�[���������)+�[J��������IY5��%Jd��C�U��k�3�;��	c�0�����;f%�X���a�|R�����/���z��W��{��\�4=�~P>9hX:���Ʊ���{�>���+��J���I}o�ʷ��0��݈zL�1���f%OyP+�yG0�h�5�}�T�t�nL�� ���'���|��_{#1��UA(�6�5�yP���pl�5�s�F}��N��n��-4�n�À�h��G��I;1^-Ĝ�Sva�4�0�T���)�ʶ�(�%נ��>�/5D�2�y��D�  �X� �q���@-D�&Z"�R`
Ɂ���\ȍg�$�;<�م������#g ���C ��j����g�|-��9^�� 

u0���R��/�~��Es��ճ�a�`�h�rx�U��a,�i��v����I�n%'N��8+��Y�e2]m�Ws���}�)��S:�>"�3g�%�ƎQբ}���D�n;Ǽx|��;�eL8�3l��m�����>��>����f%�#+�01v{b��L|
S9�Q�����p�-�Z��C,��B�%,��%L<VK����;��&h	�i	ǽ|�ԅ�zʃ�PѤQ{���Z8)�`�w;�JL��&����ZR�����'��E*p4ӧ��(����Eέ����d�vVx�9�@w�'ށ1ɀ�Z�A�,9��h�D�	��"�*8PCPN��8.mZ�?�@~���D�ˈ�����!'2b9M��̈�����G�83�
��
5�����m�p���2qMĎN!\@�`��h�����͡�SDӒS��s����^ �1Q%�@�B��-([��\?׋\�k��I���Z�pR*�����O�'��|R�"z���ױ@��=I[��J�H@W�Y�>��,A��� |I��@�U4���z��#j �-D��=ٴt�t���X(����If�y(�P�t��s:u�]��T3��0h��@���kc�|�2L\�7ܛ���k����z$��L2�)���"�\��B6�]L��z�����%]�:�ڪ�C�c�d#2�<Y���l�uM�A����K���M�g��1��6oD�D}�$9�L4`��g�B�i�j@�5�r@��!r �"��<��ml�=�aqcNl����Po�rW��n4����e���X֚3YWkjd0�
tͦD���85�wT�5Ƶ���Xh��n��ڎ �X�^-Us��V =���c�����!v�D���ol�g$2�q#b��ݛ q�m8�c1d�t��nl�e@�����Ɇ]|�w�YA��i�qj����N�ܰO\y�·DS����𷰓�;U��h�M{�b�9H���Cq75r{a�nam]�m �M��P/0>6~���(n�>"v��CLcm���X_�"�DrU[����D�K �b?DQ�BB����o"�z)��y3�����ɾ16���dS�-�Vd182,�&X��@w���LJ��v(�o�aՇC�sY9toQŁ����&����a6/�
�Pظ,@{t-� j�ɰ�j"��IB�����"@'j�c�;;��\d:�{]um��0h��2�O,z@���3ƛ�(�l�W		�j{�(��Q��V���D�VيLASE�9#���㫤��p��W�@��z�3o#���o��y��e��^v/���#PS��[���ڐI�뚎f���2�]�w���%�xjG�����ӹ9�_ܬ����pz}F�[Be���եv}�U����nRpǠ��j�ː98���j�cvp����u��i9۹�!����*�����2Z��?wa8��(�=0Y�Y��Bdsbtf���-�'�y��O ���F�A���`d��`��J猅]|��aD��%�
q��&�=��܁�+]�S7��[�k����
��.ӥEt(ʦ��1:eD8L:gt���{��ԁm��J+������\��._Ǣ�?�۩���>
�֐��,֔�XS4���S���&�Y�e�1Eճ������8��D��9����D]�X��4���p;Y��"�~؞|W���zV+����܇�fMQ؂o�_� �6�������]�$=��5I�%ݍ��S\���(�[�߶L��	�{�	
�wCí$�8���j:`��oO���L���kIU��K�O�!a�)vzt�������� ��Z-�l�&},�����b�;�� �y@�9���8{�Č�_I�M*�>��'&��H�R�@�ב��/2��*ǝ�7$��l��~-CK���"�H�N{ڍ��qQݤ��z�D�6��g�boV�S�Ѿ�ἂ-p4�Q�}�5\j�i�lBEI����O���/�����O$SS�6��������W�嘖5�����U5�B�ܩfdP�� F뚩{����Kp���=(|�{GL�/�A����k��ビ�(� &�zAZ�5��Tub �;���m��0�m��M�<����Ξ��\�Љ:�5��u�J]�|���>�&�f��΢�m#�c���>�a�݈�{ZI�۳��:��bK�H�gә��?��`��Z�{��U�p^F�>n�=/�w���*Ի�����~�$�䫯_�'_/I��'�U��xg�Af�����bL.c��X�_��pVdtl�����7�j�;ብ�'f|�_#���ge kY�1�Ў�t��tE�4)�dgu�	`|��D�J4�1-�r�?�e���E�|���$X�tp��:�����ş��*9�%��?֔}�7Ga e�Q����̺�����şϖ���O���2�@�ג������l��=a;��5W�і��z}�^��s��9����͇��}��[^�����2���	�ג��?t�g=zc�
�SR����������:d��aq4�aϨ�N���g���fWF�tڂA�E� ���_��/qԟoZt�k:;9���%�@�אz���F��Zg�80��� %�D�H��J�X�3	�h����P;g�����BB7��|���>YgWE<O����O��$�}b��#�����Y�Z��|�sPcf����h����G���<t�)��Q_��j���2�_<����'8LԪ���Tڍ�&M@��_߫/�=�v5�7� ���;�c�6y ��4�y>��;��؛鞷�=C��{�����U��������	����Zң���ם�c^!;�bП1s���ǖ�I4��J��h��Yl�11�,�s�a���U"��;�|~�ML���9�Y�P��tf��Ê����ߜ�py����R��z��yl���O���LdR�@�ב��H���^`4A&|��?�V�N������?>[��#55��I$�_K���e�����2N�j�D&�_�a��y`�*]�/�G���1��c���Ί�As�)���}�G�$>�	PI��!��N>��/J׸Ʊ��NK�E����eS�L"p�'���%��
c(�;�L���%!�7X:���"�9�T)��IÍ�f
/���}N(�P%���m1����l �� ���{$̮���GX��`�g�bMZ���m���vD���M�3�p���x�U%�bQ[��nɰ�!ao���j�S�fB��a�_@�p�-��.l{b��Y�u�+�0���l?�*�,v���.��os�U��vGT��h�le%�4˂�sv'r�2il,�?�V�&�93������2��Z����T6O~�A"��[K
���Ջ��'?����/��wÿ�ė�L����t�����+f&����N%w���v�L��m����d[������RJ��i���~�Ǎ=��?6��O��7���������{�7o������WO~{��QhT�O~u��_¡߳Ͻz�O�'���Phts͓���O�������_���>������.�/HW�b�&[��!�Yg���+���á{7{Ⱥ�=?<�J'��4�\�������^�g��gW�����R~��R�u�P9(�Y��;�{y*ޝ�������Ƴ�v�p}V�>+Ś�d��u�;�{v;,�
�ɤ�}q��h�޾�.̗���ѷ�����N�&ݞ����	]���Wo�S;���U�ig����e����K܋���̗��j�p������ͷ�[^:��_Vڱ��Nנ��J�R�aH�×����w��`C���Z�x'_�ϊ��ޫNI���n�����W����r�:-_�χG������
�}}�V;�N5}���ҝ/.u];����d���~���\]���v9�r�'��LS<�Ӵ���k�q�*���n�g���^�n�ڑ��U��\*=�'��8q��@�q���I�Ď�V UH�  �7�
���3T<!�<@�J*�B�x)8�$�����jح�������������;>�4f*3~d����J��LF*T��:�j�����@ՒhM�<ևyʔ��H*ݕ[5����%��:����P-��M���q�J��+��1��t�U:���f4sF��6�ƺ@�����!O��/1l�)�e�Ӄ}�`�L��}_�h��'�� Z�*�%�UGO���A����zVK�W\.�X�P+����[��<0��lTMܬڲf��I�h[[D*Te�V���))�2��m��\��0/tub�� �D�F%.���i�x'A�ԀBbܒ[�b�+�cIWv�Tl�OYK���\�(d؞��n����eRO�e�H�ef�� %1vY��2�"8��2��Ya�ې��������j�Gp���` ���)��A���L����v�b�ٜ�7��e���47�w4��(�~.���� ��mJ�u���I-�bD���̄�:.U�;t�֦��X/�0e6f�	��I�6�4s��ţ�!��q�_��K�#T-��w����5f�Êw�aY��K0��aS�-�78e���]^��m�rA�t��5�d�6���oT>) F�0��&Y�6������ظ�d�h|�G*Y�8���]ה|b�\��rj7�j��B�O׳r�?Q�D��Õ>N��=я4d�X�z����~�
���p���܌���2d|�9�:��Z�]�fx.���==�v���B0((��Q�t�Fğ�|O�:RMΔh�d	�;L,�Px����=#��' K:\�+Ng��U+����6�g��5��&�5]�,��/�5���N��:���r���T)#�Bz���bu0k�^M<X�bI�S�D^bK�&%I�),���1�q>�{[��dbe���|�v����/�v��$xh��a3=��Xf~�\���Qi��Y�'�=����f6K�-�hhh>X��n�`����	�"�)���L���p\�,�f)��9�^�VJD�� �h�a�w�B�N�cٯW�z�k�0K��.)[�,l+۶R3F�Q�j�l�Wr�|�j(�1�q>�{[�(��c����GmO2+#�ܙ*��x�K�Y��rX*��m��׵F������Ӗ��:�ūٖ^剙�d˓�r'�좜�l(g;Yζs�� ���Ҩ=n��K���a;�v>�|x록K�����B������|?�Qf��Yf�����~�S�<��毵�?D�'c�
�x4��������ܜm��v�.Cc�����Ν/���/��7�K�i]lk�T���n���Qg�����8�e�]v����~{���o�|��v��s럹�n�kإ��``����k���j�t�]_�{
�8?���[7��gǦ��*��8�[���\�bq�7�c�asbe1���C}�e��k�8�.v ��b����W������y�ʒy�d�x������M�)8�M��w����mdWC�"�9z�)ԧ�E'�>;MG��A/��d;�))���xǳnZ+��*'�#��$Q	s�^�CYtPQْD)�aޓ�b�����TJю^�;�8�-i�`|�Xu9h��e��s*R�ʒ#�>�JH��2���}�`�^� �fn�h��d��ƪV`�ilVk# X�����
�!���$������W梣���n%���d�rڑ�q��g�!x�17�QS��i����T4R��lG�:F%�)�T]����e<��jЁ�E����Sf~����*x8	.�lW\�bSr�r#
Lh!��h�:}�OHJ��)��DIp�|Cӆw�"C����h@�l���������81_�������I��nʤ��Q���F���J	g �ȏVY��&�q���|���18vQp��@�q�<6t�%��=$�Om$����~b�Yb�3����쾈=8>�Q�"va]� �]eX�fX��_Zm���|��V��dX�I��a�N:�6��[a�Y�څ##��DT�%�h�+�-9r0X�g��;�NN��C�Ȋ�J��j���f�6"��S2�(�!ʨ7���`�i1e�(>��Dk�s�Q?�$v8��8�kiB5$&L����e1�@۞��l��<_�Y��2Y��I��B�iɐ.�.Mk���H�|[��c!24�	)��"!���tL���Gv�d"k.$���q�7c��5�V���*U}>���L��*�q%D�z�.y�a���-9mA���5�j�R䧓i�ڝ
g�3ɰPp����Se?�Ì߉��𩓲C%N@}���;Ͷ�"xzA�1�Xtg��Ra<���h�n�;������&���+�6���.�������������A�e��Oh�0��GcgM��U^8ƣΫ\�G�����i�`��z���~�����������x������O��=�;�h����wCv�Ʈm�Lg�\f�:���w���#��H,��������so���_|]���ᅟ��[ؕ/g�����{�������#�O3���I���[����֯Z�s��B>߮c;ص3�<��/�����'����,���?��k�_D����I���!�|{�谴�}$�D�N$�D2$@�N����҈�F�N$�D�N������ �<���>�Ao�BTyh\����a-����̭���g =3������6��pD�����҄w0�3@i��G��Q*���@���t�������3���6���.�Bsfۊ�̠ihZ �3���}�3s�}�a
����s�i�SPk'�m�wţg(�<+}麁��C�?dȐ!C�2dȐ!C�2dȐ!C���?�A϶   