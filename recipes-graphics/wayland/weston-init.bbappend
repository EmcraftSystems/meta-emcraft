FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " file://weston.ini"

do_install_append() {
    install -Dm0755 ${WORKDIR}/weston.ini ${D}${sysconfdir}/xdg/weston/weston.ini
}
