# Extend the torizon-docker image with packages needed to build Zephyr
# firmware for the Cortex-M7 (Verdin i.MX 8M Plus) directly on the target.
#
# Host-side cross-compilation is the more common workflow; install these
# packages only when on-target development is explicitly required.

# Core tools for on-target Zephyr firmware workflows
PRODUCTXY_IMAGE_INSTALL_CORE = " \
    binutils \
    dtc \
    wget \
    curl \
    dnsmasq \
    xz \
    file \
    libgpiod \
    libgpiod-tools \
    uv \
"

PRODUCTXY_IMAGE_INSTALL_PYTHON = " \
    python3 \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    python3-dev \
    python3-venv \
    python3-xmltodict \
"

PRODUCTXY_IMAGE_INSTALL_DEV = " \
    git \
    openocd \
    iproute2 \
    iperf3 \
    lsof \
    tio \
    gperf \
"

# Package manager tools
PRODUCTXY_IMAGE_INSTALL_DPKG = " \
    dpkg \
"

# Toolchain for native C/C++ builds on target
PRODUCTXY_IMAGE_INSTALL_NATIVE_BUILD = " \
    gcc \
    g++ \
    make \
    cmake \
    ninja \
    ccache \
"
PRODUCTXY_IMAGE_INSTALL_NATIVE_BUILD = ""

IMAGE_INSTALL:append = " \
    ${PRODUCTXY_IMAGE_INSTALL_CORE} \
    ${PRODUCTXY_IMAGE_INSTALL_PYTHON} \
    ${PRODUCTXY_IMAGE_INSTALL_DPKG} \
    ${PRODUCTXY_IMAGE_INSTALL_NATIVE_BUILD} \
    ${PRODUCTXY_IMAGE_INSTALL_DEV} \
"

IMAGE_INSTALL:append:verdin-imx8mp = " imx-m7-demos kernel-module-netconsole kernel-module-imx-rpmsg-pingpong rpmsg-client-sample kernel-module-rpmsg-tty example rpmsgclientsample remoteproc-permissions"
IMAGE_INSTALL:append:verdin-imx8mp = " kernel-module-sht4x"

# Allow the torizon user to run sudo without password prompts.
ROOTFS_POSTPROCESS_COMMAND:append = " productxy_enable_torizon_passwordless_sudo; productxy_enable_enp1s0_shared_dhcp; productxy_disable_dnsmasq_service; productxy_disable_torizon_password_expire_on_first_login;"

productxy_enable_torizon_passwordless_sudo() {
    install -d ${IMAGE_ROOTFS}${sysconfdir}/sudoers.d
    echo 'torizon ALL=(ALL) NOPASSWD: ALL' > ${IMAGE_ROOTFS}${sysconfdir}/sudoers.d/99-torizon-nopasswd
    chmod 0440 ${IMAGE_ROOTFS}${sysconfdir}/sudoers.d/99-torizon-nopasswd
}

productxy_enable_enp1s0_shared_dhcp() {
    install -d ${IMAGE_ROOTFS}${sysconfdir}/NetworkManager/system-connections
    cat > ${IMAGE_ROOTFS}${sysconfdir}/NetworkManager/system-connections/enp1s0-shared.nmconnection <<'EOF'
[connection]
id=enp1s0-shared
type=ethernet
interface-name=enp1s0
autoconnect=true

[ethernet]

[ipv4]
method=shared
address1=192.168.50.1/24

[ipv6]
method=disabled

[proxy]
EOF
    chmod 0600 ${IMAGE_ROOTFS}${sysconfdir}/NetworkManager/system-connections/enp1s0-shared.nmconnection
}

# dnsmasq is only installed for its tooling; NetworkManager's shared-dhcp
# already provides DHCP, so mask the service to avoid a port-67 conflict.
productxy_disable_dnsmasq_service() {
    install -d ${IMAGE_ROOTFS}${sysconfdir}/systemd/system
    ln -sf /dev/null ${IMAGE_ROOTFS}${sysconfdir}/systemd/system/dnsmasq.service
    rm -f ${IMAGE_ROOTFS}${systemd_system_unitdir}/multi-user.target.wants/dnsmasq.service
}

# Skip first-boot password expiration enforced by torizon-users postinstall.
productxy_disable_torizon_password_expire_on_first_login() {
    touch ${IMAGE_ROOTFS}${sysconfdir}/.passwd_changed
}
