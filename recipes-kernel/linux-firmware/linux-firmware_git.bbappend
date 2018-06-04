# Copyright 2018 Emcraft Systems

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
            file://eeprom_ar6320_3p0_NFA324i_5.bin \
    	    file://iwlwifi-8265-22.ucode \
    	    file://ibt-12-16.ddc \
    	    file://ibt-12-16.sfi \
"

do_install_append () {
    # Install alternative firmware version (http://projects.dymacz.pl/sparklan_wpeq-261acn-bt/eeprom_ar6320_3p0_NFA324i_5.bin ) for LBEE5U91CQ installed on Emcraft SOM
    mv -f ${D}${nonarch_base_libdir}/firmware/ath10k/QCA6174/hw3.0/board.bin ${D}${nonarch_base_libdir}/firmware/ath10k/QCA6174/hw3.0/board.bin.orig
    cp ${WORKDIR}/eeprom_ar6320_3p0_NFA324i_5.bin ${D}${nonarch_base_libdir}/firmware/ath10k/QCA6174/hw3.0/
    (cd ${D}${nonarch_base_libdir}/firmware/ath10k/QCA6174/hw3.0/ ; ln -sf eeprom_ar6320_3p0_NFA324i_5.bin board.bin)
    cp ${WORKDIR}/iwlwifi-8265-22.ucode ${D}${nonarch_base_libdir}/firmware
    install -d -m 0755 ${D}${nonarch_base_libdir}/firmware/intel
    cp ${WORKDIR}/ibt-12-16.ddc ${D}${nonarch_base_libdir}/firmware/intel
    cp ${WORKDIR}/ibt-12-16.sfi ${D}${nonarch_base_libdir}/firmware/intel
}

PACKAGES =+ "${PN}-intel-8265"

FILES_${PN}-intel-8265 = " \
  ${nonarch_base_libdir}/firmware/intel/ibt-12-16.ddc \
  ${nonarch_base_libdir}/firmware/intel/ibt-12-16.sfi \
  "
