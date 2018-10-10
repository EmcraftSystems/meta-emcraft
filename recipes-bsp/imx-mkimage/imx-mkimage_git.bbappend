# Copyright 2018 Emcraft Systems

# This appends to meta-fsl-bsp-release/imx/meta-bsp/recipes-bsp/imx-mkimage_git.bb

# Redefine sources
require imx-mkimage-emcraft.inc

# The recipe doesn't build without this line on Fedora 28 for some reason
EXTRA_OEMAKE += "CFLAGS="
