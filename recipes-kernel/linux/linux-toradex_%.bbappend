FILESEXTRAPATHS:prepend := "${THISDIR}/linux-toradex:"

SRC_URI:append = " file://netconsole.cfg file://rpmsg-tty.cfg file://sample-rpmsg-client.cfg file://igc.cfg"
SRC_URI:append:verdin-imx8mp = " file://sht4x.cfg"
SRC_URI:append:verdin-imx8mp = " \
    file://0001-iio-add-inv-icm45600-driver.patch \
    file://0002-iio-enable-inv-icm45600-build.patch \
    file://0003-iio-adapt-icm45600-to-linux-6.6.patch \
    file://icm45600.cfg \
"

KERNEL_CONFIG_FRAGMENTS:append = " ${WORKDIR}/netconsole.cfg"
KERNEL_CONFIG_FRAGMENTS:append = " ${WORKDIR}/rpmsg-tty.cfg"
KERNEL_CONFIG_FRAGMENTS:append = " ${WORKDIR}/sample-rpmsg-client.cfg"
KERNEL_CONFIG_FRAGMENTS:append = " ${WORKDIR}/igc.cfg"
KERNEL_CONFIG_FRAGMENTS:append:verdin-imx8mp = " ${WORKDIR}/sht4x.cfg"
KERNEL_CONFIG_FRAGMENTS:append:verdin-imx8mp = " ${WORKDIR}/icm45600.cfg"
