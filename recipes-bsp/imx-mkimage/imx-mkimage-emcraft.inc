# Copyright 2018 Emcraft Systems

# SRCBRANCH ?= "imx_4.9.51_imx8m_beta"
# SRCREV = "7c3a73f0d90eb788d7d5d6dea1f129467961f0ce"

SRC_URI = "${MX8_DOWNLOADS}/imx-mkimage-emcraft.tar.gz"

# Released under the MIT license (see COPYING.MIT for the terms)
SRC_URI[md5sum] = "e2ec4435f139ee2e2419dbf16ef0cb89"
SRC_URI[sha256sum] = "f5bf8c7dc7346b44d99715bbfb12c68cbd35d477061e4df764c548e6feb05862"

S = "${WORKDIR}/imx-mkimage"
