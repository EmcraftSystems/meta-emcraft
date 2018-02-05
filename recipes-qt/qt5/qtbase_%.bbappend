# This appends to
# meta-fsl-bsp-release/imx/meta-sdk/recipes-qt5/qt5/qtbase_%.bbappend
# to add Emcraft-specific Qt5 environment variables to /etc/profile.d/qt5.sh

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = "file://qt5-fb-emcraft.sh"

do_install_append () {
    if ls ${D}${libdir}/pkgconfig/Qt5*.pc >/dev/null 2>&1; then
        sed -i 's,-L${STAGING_DIR_HOST}/usr/lib,,' ${D}${libdir}/pkgconfig/Qt5*.pc
    fi
    install -d ${D}${sysconfdir}/profile.d/
    install -m 0755 ${WORKDIR}/qt5-fb-emcraft.sh ${D}${sysconfdir}/profile.d/qt5.sh
}
