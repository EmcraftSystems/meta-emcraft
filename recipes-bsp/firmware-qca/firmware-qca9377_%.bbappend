# Copyright 2019 Emcraft Systems
#
# This addition to the recipe is to work around a bug in the NXP's packaging of
# the firmware-qca9377 and linux-firmware-qca packages. Both packages provides
# the same firmware.conf which results in error when using package_ipk.

RDEPENDS_${PN} += "linux-firmware"

do_install_append () {
		  rm -rf ${D}${sysconfdir}
}
FILES_${PN}_remove = "${sysconfdir}/bluetooth/firmware.conf"
