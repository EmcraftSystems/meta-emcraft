AVS_CONF="/etc/alexa_sdk/avs.conf"
SENSORY_FILE="/usr/lib/sensory-alexa/lib/libsnsr.a"
NO_SENSORY_REQUIRED="/etc/alexa_sdk/no_sensory"

while [ ! -d "/etc/alexa_sdk/booted" ]
do
 echo ""
 echo "====================================================================== "
 echo " Welcome to Alexa SDK Image for NXP i.mx7D Pico Pi                     "
 echo " Let's setup your environemt...                                        "
 echo ""
 echo " ** Please enable the Network access by Ethernet/Wifi **               "
 if [ -e $NO_SENSORY_REQUIRED ]
 then
 echo ""
 else
 echo ""
 echo " For using Wake Word Detection, please, accept the Sensory license...  "
 fi
 echo ""
 echo "====================================================================== "
 echo ""
 echo ""
 
 if [ !  -e $NO_SENSORY_REQUIRED ]
 then
  if [ ! -d "/etc/alexa_sdk/sensory" ]
  then
   /home/root/Alexa_SDK/Scripts/renewSensoryLicense.sh
   if [ -e $SENSORY_FILE ]
   then
    mkdir /etc/alexa_sdk/sensory
    sleep 2
   else
    echo ""
    echo ""
    echo " ==========================  WARNING  ================================= "
    echo " By not accepting the Sensory license you will not able to use AVS       "
    echo " with Wake Word Detection.                                              "
    echo " You can always accept/renew Sensory license by running the following:  "
    echo ""
    echo "      $ /home/root/Alexa_SDK/Scripts/renewSensoryLicense.sh                 "
    echo ""
    echo " ==========================  WARNING  ================================= "
    sleep 4
   fi
  fi
 fi
 echo ""
 echo ""
 echo "====================================================================== "
 echo " Now we will setup your AVS Credentials                                "
 echo "======================================================================="
 
 /home/root/Alexa_SDK/Scripts/setCredentials.sh
 if [ -e $AVS_CONF ]
 then
  mkdir /etc/alexa_sdk/booted
 fi

done

/home/root/Alexa_SDK/Scripts/getAVSToken.sh

echo ""
echo ""
echo "====================================================================== "
echo " Done!!! You are now ready to start with Alexa SDK for NXP Pico Pi     "
echo ""
echo " To run the SampleApp: "
echo " "
echo "   cd ~/Alexa_SDK/avs-sdk-client/SampleApp/src/                          "
echo ""
if [ -e $SENSORY_FILE ]
then
 echo "   TZ=UTC ./SampleApp ../../Integration/AlexaClientSDKConfig.json \      "
 echo "   ../../Integration/inputs/SensoryModels/ DEBUG9                        "
else
 echo "   TZ=UTC ./SampleApp ../../Integration/AlexaClientSDKConfig.json \      "
 echo "   DEBUG9                                                                "
fi
echo ""
echo " NOTE: For make Alerts/Timers works properly on AVS, you need to          "
echo " sync your date to UTC. You can do it by running next script:                       "
echo ""
echo "  /home/root/Alexa_SDK/Scripts/setUTCTime.sh                           "
echo ""
echo " Enjoy !!!                                                             "
echo "======================================================================="
echo ""
echo ""

