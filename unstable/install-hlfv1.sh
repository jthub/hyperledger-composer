(cat > composer.sh; chmod +x composer.sh; exec bash composer.sh)
#!/bin/bash
set -ev

# Get the current directory.
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Get the full path to this script.
SOURCE="${DIR}/composer.sh"

# Create a work directory for extracting files into.
WORKDIR="$(pwd)/composer-data"
rm -rf "${WORKDIR}" && mkdir -p "${WORKDIR}"
cd "${WORKDIR}"

# Find the PAYLOAD: marker in this script.
PAYLOAD_LINE=$(grep -a -n '^PAYLOAD:$' "${SOURCE}" | cut -d ':' -f 1)
echo PAYLOAD_LINE=${PAYLOAD_LINE}

# Find and extract the payload in this script.
PAYLOAD_START=$((PAYLOAD_LINE + 1))
echo PAYLOAD_START=${PAYLOAD_START}
tail -n +${PAYLOAD_START} "${SOURCE}" | tar -xzf -

# Pull the latest Docker images from Docker Hub.
docker-compose pull
docker pull hyperledger/fabric-ccenv:x86_64-1.0.0-alpha

# Kill and remove any running Docker containers.
docker-compose -p composer kill
docker-compose -p composer down --remove-orphans

# Kill any other Docker containers.
docker ps -aq | xargs docker rm -f

# Start all Docker containers.
docker-compose -p composer up -d

# Wait for the Docker containers to start and initialize.
sleep 10

# Create the channel on peer0.
docker exec peer0 peer channel create -o orderer0:7050 -c mychannel -f /etc/hyperledger/configtx/mychannel.tx

# Join peer0 to the channel.
docker exec peer0 peer channel join -b mychannel.block

# Fetch the channel block on peer1.
docker exec peer1 peer channel fetch -o orderer0:7050 -c mychannel

# Join peer1 to the channel.
docker exec peer1 peer channel join -b mychannel.block

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
� ��*Y �]Ys�:�g�
j^��xߺ��F���6�`��R�ٌ���c Ig�tB:��[�/�$!�:���Q	7�'��ʍ��4��|
�4M�(M"�w���(��$��E9��K����<�&[�i��e���i�r�����p�?������rz���x�}Ȉ�\��1��	xM��)����!NT�/o����;����G�7��������+��[G���'�j���_����g�8�_�˟*JT�/��5��N�;�����q0Ew�~z-�=�h, (J�ԗZ���w�O�x��r���C�1�Fhsp�<��)�r	�i�)�!	�\�(!�i�d0�v<�tQ�	�&���W��(C���O/��D�����������:��Zy�j=]6�!�ڢuʃ���Me�w٤�0	���
V�ׂ���ikA�*̄Բ�O�4q��W��B���f<�-�x�X��I�	ܑ�㹉�S�z�B4�Y��|��,=�N�R7��@��4}������@�e����E/�P׾}�N�U����;�7�/�ۋ�K�O�?w�a�aT��W
>J�wWǏ׉=��+�%p��'�J�����uC�d�P���_������� �9ʚ���d���̐�Ys)n[D� m.W�����4̸PѲ�5K05�!�-sp��@"�)m�2{8޺�X�8T8���u�IY�!kH��:s�� ���"�s����� �D��P59�|�[�G���;�#F�`��"(�r�,D1�`�E��W�i�%���-�(�i*;� t�\sh�su�4���6�P�I308繆`yS��F���c�[q ~�,]̅��/��O����xk��X��?�&��B��D��bD(m����|7�Ȕ�	Ӱ��X�1je�>�����f9+�d�r�v���,7Gq�;S��kQ�с�@��r��sM<�<��ީ������B���J�υ%(��}��t9^eu�Ș��6|#;��a��l�E�$m.o4F�t�4W���%�(‗5����e�Ob`���1f��:���a�����w�\��$mIm45Q�u�!�%�H�X4�9����l���̆g������6�@������|���?�^��)��x��e�5�g�;���@=2̛흺_���@�8��В��X>̐#q���^B�Џ��
|Hʑ�z E�����di���2s��I���:��2��4]�!�l��b��p��#v�D���[�NyM1GkH���5q"5q1u{����~o�yl��W�y.�V��
������2t����[���˶:U �U��ք9P�m�0<Z GZoi�rf�m qy���+ ���TɌ�\�A����}� ����堛��>�u�^��[��kSR�G�D������:��u�E��`f����d_��8�#�f5�7�~�&��� 7ؽߤی�	��97�~&׵d:\M�6��C%�u���|����]����'I���("��9�_���#4�U�_*����+��ϵ~A��9&�r�'P������?3����JA�S�����'}�p�/�l��:N�l��a��a���]sY��(?pQ2@1g=ҫ��.�!�W����PER������vO��M
Zy8�XOP�Yǳ�>Wx�qpa��Q��Ë�?k�؂m�
f�dܐ����[&_z˖2�'�!rXm|�1�>��:ݎ,h��ܘ��%���_�[P�	v��lO�*��������?U�)�(�x�U��2P��U���_���.����?������������R����=��f�GB��
Sz��Ђ���?�}0���C�f	����>�.to;M�w��q���G&]���dR�M��5�{&h�����Ρ"�1�+�0�C����ٰ�L�[��(�cД(�𸘠KnP�dՎ�cx�h]c��-���1"�H������ N4�Y8e�!9H϶�"�0y�J�^;w�	�)��P�&+����Q^p�ߙ�8>Z���ɠ	U��"�}�c�+~>4��~-&!oם�6;���gJ�Һ���r�c�����N�H�G2g)���:��9O�
�$+��V<�?�/��O��!�������3�*�/��_�������o�����#�.��(P��D��������1%*�/�W�_������C�J=��HA���2p	�{�M:x�������Юoh�a8�zn��(°J",�8, �Ϣ4K��]E��~(C����!4IT�_� �Oe®ȯV+U���؜����=�i�m����?��)���H�	�S����;����^����=��n�c�Vi�ہ�8"��	�y� ���`�ʇ7y��)%�v�Y��n<��q�������D��_� ���<��?Tu�w9�P���/S
��'�j������A��ۗ����q���_>R�/m�X�8�!���R�;��`8�|�']����O��,�Ѕ��bD�b�cۤ��K�.F!�K�,f{X�������L8��2��VE���_���#�������?]D��� �D4L^L�ݠ�nci�x�s�X鮑&����V�p�e���+�au]��S��0"7�3�`��(�|�G�|F�T��Nc�[����&���k��3[��ލ���/m}��GP��W
~�%���u��+����I��A���B�D���C	�i�7�`��?�������/��~�s�@��8�Z���� sߐ���<�}��ϒ ���?c�~�0�߃��\�[7�nd���|t�zt4tw�{ρ�4���i疉��O}vJ��y�Hw�m�=b��7��j�66a�'�E�\�n�Y=�c�1<�j2�:�޼9��\�t���[q�\R|o6h&*�n�Q�z���b��G�y��p���s��i�X�s�%����ԕsY�Hњ����)�,Ԧϩ��;�t�3r�¼�kԥΈ$������>��nk�����9�ۻ����=��"�v6�8�9g��r����b ��P�0�)��v���K4�[�3ۧwKkUׇ��9^(i��Ń}��i;�;����R�[��^��>g�� �r~K�!�W��g�?	���/o��ѿ��1nۯ�x7w��i*�;<��}���{C��<3���#� ����} �'�@���-��) ��i����1~r��@���Nu7%�},mQI�����z�6�}�VzjJ���[3�c�҄�!��fL�9M���Tnx@A����㤯&��΃����� ��>t�����d��As�j$Z���ټK��i�^)�y�HVs��{�)��a���3[���Z����A{��h؄�=����O�y��S|���8��������R�[�����j�OI���_-��sP��߳�������|T������_���Q������ê�.���r��b��(���?KA���W�����o��CQ����+��?�6Mc�#�)ơH�p�g0�D|g4�iGp%2`}*�}�\sëS`~+�!�W���B���O)�`�PZ�d��a�2�f�����9��6ض��"o䑶hQ����hN�m�`]	otw�K��#`����;VaDI�1�ַ����0�k�d=�(G��b(���:�b��W��/v�~Z��(�3�z->�?��h1۟��B@5����O�B�����A��n���}�j5�F��Zm١��6�'~�𽰘����S�ʵ���"��k�����>}�_n�i�����\I�vU� ���n�]E��k�a�W�v���I����u��FH����_��b�F���Z�&�+����:jG�kWE��q�"�.�ګw~r����sEsY=pr^�ʩ�6X|=�&�_�+���x���}t_r��׷>�m/��t�7K;*F�k��Unm�ۑ��]�+���Ec���.�7Quй��}CT� �b���>��X�x��}E4�]��Q�����F��;x��qf׷�r�,
=�rc�<�(��,|랿P|x�� ��[eɝ��bF�S���g���{,yˤ�>��zqowg�O�z�T���������n��A��^�}?{��|�K~�i������;55���t�x��k��5Ɖ���Y���t=�8ׅ���t{$�{��0�&,t rT�ȏ��Y<��w�Q���?��|8"�۞�������n8��H1�]]��@V�� ވ#��!+bw`|c��㲪82��Ӎ�8�T�9#���j|�,���0O�lo�N7K�lI]g'��=������x�o�jc]'�8\.��s�r(A.��.�/]׽t�H׭�N�m������u��n�i�NLPb��/Ac�&A#�DL����Q�(�@B�Q���m��g;���9.�}nrO����>��Ͽ���白��Lg̃�M�Wn�͠��LCĮ�~�H&�X$�g����h� k$���R���H<��ֶ�P=I]���}N'��u�fZL�2:]Z�����ټ�yxfs��s@	��0.�Î��;��$�=�n��Dsp�n�\�wBs�-3���U�n z-��6`��j���G���n+����6j��U� ����3���s�J�~��d&;�!���d��u��ĸ�R������n猛p��>��kƙ����҈y$DfUJ��g�e�hY�}�F����[(-�KCƬ��+|��]�=t��,/j���r4E>�h�C޷h�Ц�9
�.�dé�G�S��b�p�~Gp:91�Ӏٝ�#Z����� vr��"�A�;�ʢ޾sa�����1�I�Vc�2Ǻj��/dtI:�4`q���9�:�!���p�w��9��S�l�k��f$tQ������7��]������
C0��e�����C�|��.8.���_�a*�Jc�1CJ��&o=�^��]�E.��-j�"Ƀ[kgk��.לP�Օ��М���H���=����L��*�T����
��w�y>��܃sэ\�f����ǜ�n��!3�%8��t�v1A3�6'f�aoZ�w:��Υ�S����0W����ꪽ$���u�v!Gk��]{�#Xvu����W��j:��>��Ѽqѹ�B�{��'�daý���U���ܨ�������������'�J<
k'6N�=���~~��ZK%.<��T�~��U z
������ߏ��m/ˣ����U�.}T�|����á����Cp��ޡ���_���/��z��j�'�M��~�ң��
���n�OP�Ϝ��q ��z�N v��Ћwn����8|���s��f����� glj�oj��/n
sF�>����,n���^T�t����X��6z	c�yN�=W���D��� C�w~�����2]�a���f��#��!xv�e��l�(�ϐn7�/D�����
m�Y@�����50_����N��4�/�(������}N6s��x� �8���dC�`)Ly����~��0�DW�h5����tp�#\�ǔ� �O�ɂ}v{k�P&���Lc3U\dB*�=�z6ߣ�x���
�SՖ���KAI�VIUe�e�!>��RjJ��^o���,��#�AO����6�f®��>a�C�R�"lxjSOa�M=�!�5;��f{��Ss%dݪ�8���Z4]S�7������@&)m���v���e����_�D� �˓����=������b&Lf�p>!� a��!+�;LI�S0ӂ� jG2,���	xY��Ȏ��!+މl�� ���x�UR�e�����b9!�)_��b5͋��8P2���*�F���\5�L��v"^ ��0����1&��6�ﾲ��IY�l�:�,[��f�; �\��v8���p�w'�f�C�W{Z�3\+�;�p�EZ�J(Ɗ��ؤ��8%��J��reeP�m�pʂ3�׊�ÅTP4M��<�iI�9e�#<#�TY����}4�����ct��ʁ��a����YO8ޤE1�e0�sޝ����[HP�����5�r�W�&ݾXB�sU����VYb����@Y��+K}e����P�U��(I��,�8@��Н:C���.`^د�y���Pø-�[;�vbX)W�x��A�a$&5����)KXL֤� �{Q5P�A�aR�t��1Ȝ����]�,Lh�}��b�Z�J� ӽA�����BΛM����`�͆����d_k�\���>O����lRd�d�p{��N��OY���f�l�϶�϶q
7~���Z�W5�#й�+�h:��=�v����Wi+�����C��}*�:tf:����U�y�r��6���6'!v�ӆn��W����f���*o~J�R�@7A7�p��6.I��w���QL!�km�f~�Р����'�3|K�hف�C��)pR�%�q�k��djC�:��~�9���;��tZ�s:�v&��OX2�A��g�Z�l9tt�.|��8�ʳ�͒����<�e�@ϝ�qE��bT�3硗!#�bF���Dhq���4�	� \mF���O������y��Q���u�u�o���/�K��/�8t�LZ�-�P�J+�@��ny��s
Ǿ𠥎�H[�h,:Ύs��hP���V]p��g��������U��4��5e��;��D�O���"�ΐڔ�"�U=lD�"��L )ni��H��H4�D@?T�H�+$�B���bJy4�;��:�Ը��^+4�1U94��JO��b�zχ�HPH���iL���qs��Q�!b�X�&i�"���3��Vu�[�!F3��4b#}i>���'���_z[
*�8� -�Ź��������@�� ߧz1!��-�B�<��Z�Y�4`�:���Y����RM+��1��8��q��a�~�k�K��Mw*o�r.O���1��1�V́X��=���S��N[v}މ��>��r��u��]����{X���aّ�N$m�A$3a�p%����%�h�lN�T>����`1�ʃ��\�y�zP�	�Lb"�A�I��((2ݬ)��O�����;��`�6�&����"�� I�pDl�4Nm��Q:(L��h�Ea���.	7B��tpY�ÃA��ӥ��P1!-LC��B�a�!������� ��r����&ߎzv8��R�'�D]�B�����G�/����b�|T�_�J�
���`�<���,�@�~6�}�+[r����kbbK����,�k�z)�v�I�U��Haߥ�W��l㰍���8���g#~+9e�C;e39V}��[!̶q�j��Bl����Xk	�����Ռ��GO7L���#�x����kz�� ����Z�����P\d��&Ak�T&�������+w��Q�&���$t��rs/����#�}s����F藿��S����/������8t��kv���{�w��lZ8Q���8���z��������˒�s����Ƀt��7N���_�n<�@���y�__|���?=�^<߉?�u�J��~erEO�ym4��V�6��o�?�'?����n���󯁗����Г��x���HA��v���ޜ�v�jS;mj�M��i6M��v�_q��_q퀴����6�Ӧv�>��������[^F>�C�*W����Y�=�rAl�נ�B'��zl��c&�N�����/�C�MQ^�l�����<�S��)����a�{�38G����Af���צ��,��93v�՞3cO���sfl㰍�2̙9�|�#L��3s.w���Ui��.y�ɜ��/�:h\1�g';��Nvzߦ�t�	�  