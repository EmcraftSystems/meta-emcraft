#!/bin/bash 
SENSORY_FILE="/usr/lib/sensory-alexa/lib/libsnsr.a"
date -s "$(curl http://s3.amazonaws.com -v 2>&1 | grep "Date: " | awk '{ print $3 " " $5 " " $4 " " $7 " " $6 " GMT"}')"
cd /usr/lib/
if [ ! -d "/usr/lib/sensory-alexa" ]
then
    git clone https://github.com/Sensory/alexa-rpi.git sensory-alexa > /dev/null
fi
cd sensory-alexa
git reset --hard > /dev/null
#git pull
./bin/license.sh; # accept license agreement
if [ ! -d "/home/root/Alexa_SDK/avs-sdk-client/Integration/inputs/SensoryModels" ]
then
 mkdir -p /home/root/Alexa_SDK/avs-sdk-client/Integration/inputs/SensoryModels
fi
if [ ! -d "/home/root/Alexa_SDK/avs-device-sdk/KWD/inputs/SensoryModels" ]
then
 mkdir -p /home/root/Alexa_SDK/avs-device-sdk/KWD/inputs/SensoryModels
fi
DIFF=$(git diff)
if [ "$DIFF" != "" ] 
then
 cp ./models/spot-alexa-rpi-31000.snsr /home/root/Alexa_SDK/avs-sdk-client/Integration/inputs/SensoryModels/spot-alexa-rpi-31000.snsr
 cp ./models/spot-alexa-rpi-31000.snsr /home/root/Alexa_SDK/avs-device-sdk/KWD/inputs/SensoryModels/spot-alexa-rpi-31000.snsr
 cd /home/root/Alexa_SDK/avs-sdk-client
 cmake ../avs-device-sdk -DSENSORY_KEY_WORD_DETECTOR=ON -DSENSORY_KEY_WORD_DETECTOR_LIB_PATH=/usr/lib/sensory-alexa/lib/libsnsr.a -DSENSORY_KEY_WORD_DETECTOR_INCLUDE_DIR=/usr/lib/sensory-alexa/include -DGSTREAMER_MEDIA_PLAYER=ON -DCMAKE_PREFIX_PATH=/usr/lib/gstreamer-1.0 -DCMAKE_INSTALL_PREFIX=. -DPORTAUDIO=ON -DPORTAUDIO_LIB_PATH=/usr/lib/libportaudio.so \-DPORTAUDIO_INCLUDE_DIR=/portaudio/include -DCMAKE_BUILD_TYPE=RELEASE

# Loop until the make is successful
 keepBuilding=1
 while [ "$keepBuilding" == 1 ]
 do
   trap 'kill -INT -$pid' INT
   timeout 11m make SampleApp &
   pid=$!
   wait $pid
   if [ $? -eq 124 ]
   then
     keepBuilding=1
   else
    keepBuilding=0
   fi
 done

else
 git rm $SENSORY_FILE
fi

