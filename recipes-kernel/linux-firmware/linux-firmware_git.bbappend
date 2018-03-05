# Copyright 2018 Emcraft Systems

FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI += " \
            file://eeprom_ar6320_3p0_NFA324i_5.bin \
"

do_install_append () {
    # Install alternative firmware version (http://projects.dymacz.pl/sparklan_wpeq-261acn-bt/eeprom_ar6320_3p0_NFA324i_5.bin ) for LBEE5U91CQ installed on Emcraft SOM
    mv -f ${D}${nonarch_base_libdir}/firmware/ath10k/QCA6174/hw3.0/board.bin ${D}${nonarch_base_libdir}/firmware/ath10k/QCA6174/hw3.0/board.bin.orig
    cp ${WORKDIR}/eeprom_ar6320_3p0_NFA324i_5.bin ${D}${nonarch_base_libdir}/firmware/ath10k/QCA6174/hw3.0/
    (cd ${D}${nonarch_base_libdir}/firmware/ath10k/QCA6174/hw3.0/ ; ln -sf eeprom_ar6320_3p0_NFA324i_5.bin board.bin)
}
