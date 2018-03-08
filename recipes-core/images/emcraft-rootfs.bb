# Copyrigh (C) 2018 Emcraft Systems
# IMX8M-SOM root filesystem image, based on fsl-image-qt5-validation.

require recipes-fsl/images/fsl-image-qt5-validation-imx.bb

hostname = "imx8m-som"

IMAGE_INSTALL += "\
	      usbutils	\
	      i2c-tools \
	      lcdtest	\
	      opkg	\
	      qtmultimedia	\
	      qtcanvas3d	\
	      qt5-emcraft-demo	\
	      avs-device-sdk	\
	      socat	\
	      links	\
	      qtserialport	\
	      "

# To exclude a package or group from the image:
# PACKAGE_EXCLUDE = "packagegroup-fsl-tools-testapps i2c-tools"
#
# See the full list of packages included in the image in
# {builddir}/tmp/deploy/images/imx8m-som/emcraft-rootfs-imx8m-som.manifest
