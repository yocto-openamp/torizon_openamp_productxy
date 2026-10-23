FILESEXTRAPATHS:prepend := "${THISDIR}/linux-toradex:"

SRC_URI:append = " file://netconsole.cfg file://rpmsg-tty.cfg file://sample-rpmsg-client.cfg file://igc.cfg"
SRC_URI:append:verdin-imx8mp = " file://sht4x.cfg"

KERNEL_CONFIG_FRAGMENTS:append = " ${WORKDIR}/netconsole.cfg"
KERNEL_CONFIG_FRAGMENTS:append = " ${WORKDIR}/rpmsg-tty.cfg"
KERNEL_CONFIG_FRAGMENTS:append = " ${WORKDIR}/sample-rpmsg-client.cfg"
KERNEL_CONFIG_FRAGMENTS:append = " ${WORKDIR}/igc.cfg"
KERNEL_CONFIG_FRAGMENTS:append:verdin-imx8mp = " ${WORKDIR}/sht4x.cfg"
