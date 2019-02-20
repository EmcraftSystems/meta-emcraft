# This appends to
# meta-fsl-bsp-release/imx/meta-sdk/recipes-qt5/qt5/qtbase_%.bbappend
# to add Emcraft-specific Qt5 environment variables to /etc/profile.d/qt5.sh

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://qt5-fix-glibc-2.28-build.patch"

# Enable GIF support
PACKAGECONFIG_append_pn-qtbase = " gif"
