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
"

# Extra dependencies often required by Zephyr build tooling
PRODUCTXY_IMAGE_INSTALL_ZEPHYR_DEPS = " \
    pkgconfig \
    libffi-dev \
    libssl-dev \
    zlib1g-dev \
    bzip2 \
    unzip \
    patch \
    rsync \
"

IMAGE_INSTALL:append = " \
    ${PRODUCTXY_IMAGE_INSTALL_CORE} \
    ${PRODUCTXY_IMAGE_INSTALL_DPKG} \
    ${PRODUCTXY_IMAGE_INSTALL_NATIVE_BUILD} \
    ${PRODUCTXY_IMAGE_INSTALL_ZEPHYR_DEPS} \
"

IMAGE_INSTALL:append:verdin-imx8mp = " imx-m7-demos kernel-module-netconsole example rpmsgclientsample"

# Files already included in Zephyr SDK
#    gcc \
#    g++ \
#    binutils \
#    make \
#    cmake \
#    ninja \
#