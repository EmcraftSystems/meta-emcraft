FILESEXTRAPATHS_prepend := "${THISDIR}/qtbase:"

SRC_URI += "${@'file://0015-Check-glibc-version-for-renameat2-statx-on-non-boots.patch' if d.getVar('CONFIG_GLIBC_228') == '1' else ''}"
