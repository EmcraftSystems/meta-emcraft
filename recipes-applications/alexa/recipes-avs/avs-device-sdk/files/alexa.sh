#!/bin/sh

echo 30000 >  /proc/sys/vm/min_free_kbytes
amixer set 'Capture PGA' 100% && amixer sset 'Headphone' 100% &&  amixer sset 'Playback' 100%

# Disable pulseAudio due to conflicts with AVS
if [ -f /usr/bin/pulseaudio ]; then
    echo "pulseaudio disabled permanently in /usr/bin"
    mv /usr/bin/pulseaudio /usr/bin/pulseaudio.disabled
fi

/home/root/Alexa_SDK/avs-sdk-client/SampleApp/src/SampleApp \
	/AlexaClientSDKConfig.json.imx8m-som

