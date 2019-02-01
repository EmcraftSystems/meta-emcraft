# Copyright 2018 Emcraft Systems
# This addition to the recipe is to work around a bug in the NXP's packaging
# of the firmware-qca6174 and firmware-qca9377 packages. Both packages provides
# the same firmware.conf which results in error when using package_ipk.
do_install_append () {
		  rm -rf ${D}${sysconfdir}
}
FILES_${PN}_remove = "${sysconfdir}/bluetooth/firmware.conf"
