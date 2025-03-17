# Copyrigh (C) 2025 Emcraft Systems
# IMX8MMINI-SOM root filesystem image

require dynamic-layers/qt6-layer/recipes-fsl/images/imx-image-full.bb

IMAGE_INSTALL += " \
    qt-demo \
"
