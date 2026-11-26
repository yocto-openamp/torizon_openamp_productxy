# Select the non-WiFi Mallow device tree, HMP, SPI_1 M7 handoff and SHT40 sensors.
# The Mallow base tree enables ecspi1 (SPI_1) for Linux. The spi1-gpio
# overlay disables it, freeing SPI_1 for the M7. The icm45686 overlay
# re-enables ecspi1 for the Linux IMU driver and must come after the
# spi1-gpio overlay.
# https://git.toradex.com/cgit/linux-toradex.git/tree/arch/arm64/boot/dts/freescale/imx8mp-verdin-mallow.dtsi
PRODUCTXY_FDT_OVERLAYS = " \
    verdin-imx8mp_hmp_overlay.dtbo \
    verdin-imx8mp_spi1-gpio_overlay.dtbo \
    verdin-imx8mp_icm45686_overlay.dtbo \
    verdin-imx8mp_sht40_overlay.dtbo \
"

# To hand SPI_1 to the M7 instead, remove the icm45686 line above.

UENV_EXTRA_CONFIGS:verdin-imx8mp = " \
    env set fdtfile imx8mp-verdin-nonwifi-mallow.dtb; \
    env set fdt_overlays ${PRODUCTXY_FDT_OVERLAYS} \
"

# See: https://developer.toradex.com/software/hmp/hmp-nxp/how-to-use-remoteproc/

# In Torizon's u-boot-distro-boot flow, final bootargs are assembled from
# uEnv variables (torizon_bootargs_l/r and tdxargs), not from APPEND.
do_compile:append:verdin-imx8mp() {
	sed -i '/^torizon_bootargs_r=.*clk-imx8mp\.mcore_booted=1/d' uEnv.txt
	echo 'torizon_bootargs_r=clk-imx8mp.mcore_booted=1' >> uEnv.txt
}
