# Enable Toradex HMP and release SPI_1 for M7 use on Verdin iMX8MP.
#
# Source overlay (from device-tree-overlays.git):
#   overlays/verdin-imx8mp_hmp_overlay.dts
#
# Resulting boot-time overlay:
#   verdin-imx8mp_hmp_overlay.dtbo

# Links
# https://community.toradex.com/t/rpmsg-on-verdin-imx8mp/29025/2
# https://developer.toradex.com/software/hmp/hmp-nxp/how-to-use-remoteproc/#setting-up-and-enabling-the-remoteproc
# https://developer.toradex.com/software/linux-resources/device-tree/first-steps-with-device-tree-overlays/
# https://git.toradex.com/cgit/linux-toradex.git/tree/arch/arm64/boot/dts/freescale/imx8mp-verdin-mallow.dtsi

# TEZI_EXTERNAL_KERNEL_DEVICETREE:append:verdin-imx8mp = " \
# 	verdin-imx8mp_hdmi_overlay.dtbo \
# 	verdin-imx8mp_dsi-to-hdmi_overlay.dtbo \
# 	verdin-imx8mp_spidev_overlay.dtbo \
# 	verdin-imx8mp_hmp_overlay.dtbo"
FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append:verdin-imx8mp = " file://verdin-imx8mp_spi1-gpio_overlay.dts"

do_collect_overlays:append:verdin-imx8mp() {
	install -m 0644 ${WORKDIR}/verdin-imx8mp_spi1-gpio_overlay.dts ${DT_FILES_PATH}/
}

TEZI_EXTERNAL_KERNEL_DEVICETREE_BOOT:append:verdin-imx8mp = " verdin-imx8mp_hmp_overlay.dtbo verdin-imx8mp_spi1-gpio_overlay.dtbo"
