export DISPLAY=:0.0

echo "============================================================ "
echo " Now we will try to authenticate your AVS device             "
echo ""

x11vnc > /dev/null 2>&1 &
pip install commentjson > /dev/null 2>&1

IP=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')

echo " Please Open a VNC connection with IP = $IP"
echo ""
echo " Open FireFox on your VNC connection and copy/paste the below "
echo " URL to login with your Amazon AVS Developer user/pass        "
echo ""

cd /home/root/Alexa_SDK/avs-sdk-client/
python AuthServer/AuthServer.py > /dev/null

echo ""
echo ""
echo "============================================================ "


