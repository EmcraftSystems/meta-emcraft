FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " file://weston.ini"
SRC_URI_append = " file://weston.ivi.ini"

do_install_append() {
    if [ "${@bb.utils.filter('BBFILE_COLLECTIONS', 'ivi', d)}" ]; then
        WESTON_INI_SRC=${B}/../weston.ivi.ini
    else
        WESTON_INI_SRC=${B}/../weston.ini
    fi
    WESTON_INI_DEST_DIR=${D}${sysconfdir}/xdg/weston
    install -d ${WESTON_INI_DEST_DIR}
    install -m 0644 ${WESTON_INI_SRC} ${WESTON_INI_DEST_DIR}/weston.ini
}

