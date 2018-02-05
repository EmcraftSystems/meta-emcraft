# Copyright 2018 Emcraft Systems

# SRCBRANCH ?= "imx_4.9.51_imx8m_beta"
# SRCREV = "7c3a73f0d90eb788d7d5d6dea1f129467961f0ce"

SRC_URI = "${MX8_DOWNLOADS}/imx-mkimage-emcraft.tar.gz"

# Released under the MIT license (see COPYING.MIT for the terms)
SRC_URI[md5sum] = "a34096aed11003963be5253697ab17e3"
SRC_URI[sha256sum] = "f03fd69ba39d92e00ecba831c70d1b6aebebe7e7d616388031aeb778afad096d"

S = "${WORKDIR}/imx-mkimage"
