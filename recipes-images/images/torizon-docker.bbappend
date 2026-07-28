# Extend the torizon-docker image with packages needed to build Zephyr
# firmware for the Cortex-M7 (Verdin i.MX 8M Plus) directly on the target.
#
# Host-side cross-compilation is the more common workflow; install these
# packages only when on-target development is explicitly required.

# Core tools for on-target Zephyr firmware workflows
PRODUCTXY_IMAGE_INSTALL_CORE = " \
    git \
    python3 \
    python3-pip \
    python3-setuptools \
    python3-wheel \
    python3-dev \
    python3-venv \
    python3-xmltodict \
    binutils \
    dtc \
    wget \
    curl \
    xz \
    file \
    gperf \
    openocd \
    uv \
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


IMAGE_INSTALL:append = " \
    ${PRODUCTXY_IMAGE_INSTALL_CORE} \
    ${PRODUCTXY_IMAGE_INSTALL_DPKG} \
    ${PRODUCTXY_IMAGE_INSTALL_NATIVE_BUILD} \
"

IMAGE_INSTALL:append:verdin-imx8mp = " imx-m7-demos kernel-module-netconsole kernel-module-imx-rpmsg-pingpong kernel-module-rpmsg-client-sample-6.6.142-7.7.0-devel kernel-module-rpmsg-tty example rpmsgclientsample"

# Allow the torizon user to run sudo without password prompts.
ROOTFS_POSTPROCESS_COMMAND:append = " productxy_enable_torizon_passwordless_sudo; productxy_disable_torizon_password_expire_on_first_login;"

productxy_enable_torizon_passwordless_sudo() {
    install -d ${IMAGE_ROOTFS}${sysconfdir}/sudoers.d
    echo 'torizon ALL=(ALL) NOPASSWD: ALL' > ${IMAGE_ROOTFS}${sysconfdir}/sudoers.d/99-torizon-nopasswd
    chmod 0440 ${IMAGE_ROOTFS}${sysconfdir}/sudoers.d/99-torizon-nopasswd
}

# Skip first-boot password expiration enforced by torizon-users postinstall.
productxy_disable_torizon_password_expire_on_first_login() {
    touch ${IMAGE_ROOTFS}${sysconfdir}/.passwd_changed
}
