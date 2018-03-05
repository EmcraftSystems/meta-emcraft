# Copyright 2018 Emcraft Systems

# FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

#SRC_URI += " \
#            file://firmware.conf \
#"

# Removed wpa_supplicant.service from the list, see in .bb
SYSTEMD_SERVICE_${PN} = "wpa_supplicant-nl80211@.service wpa_supplicant-wired@.service"


do_install_append () {
    # Disable wpa_supplicant start by dbus
    rm -f ${D}/${systemd_unitdir}/system/wpa_supplicant.service
    install -m 644 ${S}/wpa_supplicant/systemd/wpa_supplicant.service ${D}/${systemd_unitdir}/system/wpa_supplicant.service.disabled
}

FILES_${PN} += " \
  ${systemd_unitdir}/system/wpa_supplicant.service.disabled \
  ${systemd_unitdir}/system/wpa_supplicant@.service \
"
