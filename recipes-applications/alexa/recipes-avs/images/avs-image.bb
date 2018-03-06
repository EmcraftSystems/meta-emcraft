DESCRIPTION = "Amazon Voice Services Image"
LICENSE = "MIT"

inherit core-image

### WARNING: This image is NOT suitable for production use and is intended
###          to provide a way for users to reproduce the image used during
###          the validation process of i.MX BSP releases for AVS_SDK.

## Select Image Features
IMAGE_FEATURES += " \
    debug-tweaks \
    tools-profile \
    splash \
    nfs-server \
    tools-debug \
    ssh-server-dropbear \
    tools-testapps \
    hwcodecs \
    ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', '', \
       bb.utils.contains('DISTRO_FEATURES',     'x11', 'x11-base x11-sato', \
                                                       '', d), d)} \
"

CORE_IMAGE_EXTRA_INSTALL += " \
    packagegroup-core-full-cmdline \
    packagegroup-tools-bluetooth \
    packagegroup-fsl-tools-audio \
    packagegroup-fsl-tools-gpu \
    packagegroup-fsl-tools-gpu-external \
    packagegroup-fsl-tools-testapps \
    packagegroup-fsl-tools-benchmark \
    packagegroup-fsl-gstreamer1.0 \
    packagegroup-fsl-gstreamer1.0-full \
    ${@bb.utils.contains('DISTRO_FEATURES', 'wayland', 'weston-init', '', d)} \
    ${@bb.utils.contains('DISTRO_FEATURES', 'x11 wayland', 'weston-xwayland xterm', '', d)} \
"


EXTRA_IMAGE_FEATURES += "dev-pkgs tools-sdk"
IMAGE_INSTALL_append = " firefox"
IMAGE_INSTALL_append = " x11vnc"
IMAGE_INSTALL_append = " libtasn1"
IMAGE_INSTALL_append = " gtest"
IMAGE_INSTALL_append = " portaudio-v19"
IMAGE_INSTALL_append = " curl"
IMAGE_INSTALL_append = " nghttp2"
IMAGE_INSTALL_append = " mbedtls"
IMAGE_INSTALL_append = " python-flask"
IMAGE_INSTALL_append = " python-requests"
IMAGE_INSTALL_append = " git"
IMAGE_INSTALL_append = " flac"
IMAGE_INSTALL_append = " python-pip"
IMAGE_INSTALL_append = " cmake"
IMAGE_INSTALL_append = " putty"
IMAGE_INSTALL_append = " ${@bb.utils.contains('DISTRO_FEATURES', 'x11', 'xdotool', '', d)}"


LICENSE_FLAGS_WHITELIST = "commercial_gst-fluendo-mp3 \
                             commercial_gst-openmax \
                             commercial_gst-plugins-ugly \
                             commercial_gst-ffmpeg \
                             commercial_gstreamer1.0-libav \
                             commercial_lame \
                             commercial_libav \
                             commercial_libpostproc \
                             commercial_mplayer2 \
                             commercial_x264 \
                             commercial_libmad \
                             commercial_mpeg2dec \
                             commercial_qmmp \
                             oracle_java \
                             commercial \
                             "

export IMAGE_BASENAME = "avs"
IMAGE_NAME = "${MACHINE}-${IMAGE_BASENAME}-${DATETIME}"
IMAGE_LINK_NAME = "${MACHINE}-${IMAGE_BASENAME}"


