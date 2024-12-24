	#!/bin/bash
################################################################################ 
#
# Program:
#   Install needed Package to compile crypto currency
# 
################################################################################
 
function package_compile_crypto
{
    # Installing Package to compile crypto currency
    output " >--> Installing needed Package to compile crypto currency"
    sleep 3
 
    # Common packages for both Ubuntu 20.04 and 22.04
    apt_install build-essential libtool gettext bsdmainutils git cmake autotools-dev automake pkg-config libzmq5
    apt_install libssl-dev libevent-dev libseccomp-dev libcap-dev libminiupnpc-dev libboost-all-dev zlib1g-dev libz-dev
    apt_install libminiupnpc-dev libdb5.3 libdb5.3++
    apt_install libcanberra-gtk-module libqrencode-dev libzmq3-dev
    apt_install libqt5gui5 libqt5core5a libqt5webkit5-dev libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler
    apt_install zlib1g-dev libz-dev libseccomp-dev libcap-dev libminiupnpc-dev gettext libcanberra-gtk-module libqrencode-dev libzmq3-dev
    apt_install libqt5gui5 libqt5core5a libqt5webkit5-dev libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler
 
    # Ubuntu version-specific installations
    if [ "$(lsb_release -rs)" == "20.04" ]; then
        output " >--> Installing PHP 7.4 for Ubuntu 20.04..."
        apt_install php7.4 php7.4-cli php7.4-fpm php7.4-json php7.4-common php7.4-mysql php7.4-zip php7.4-gd php7.4-mbstring php7.4-curl php7.4-xml php7.4-bcmath
    elif [ "$(lsb_release -rs)" == "22.04" ]; then
        output " >--> Installing PHP 8.2 for Ubuntu 22.04..."
        apt_install php8.2 php8.2-cli php8.2-fpm php8.2-common php8.2-mysql php8.2-zip php8.2-gd php8.2-mbstring php8.2-curl php8.2-xml php8.2-bcmath
    else
        output " >--> Unsupported Ubuntu version. Please use Ubuntu 20.04 or 22.04."
        return 1
    fi
 
    output " >--> Updating system..."
    hide_output sudo apt -y update && sudo apt -y upgrade > /dev/null 2>&1
 
    apt_install libgmp-dev libunbound-dev libsodium-dev libunwind8-dev liblzma-dev libreadline-dev libldns-dev libexpat1-dev
    apt_install libpgm-dev libhidapi-dev libusb-1.0-0-dev libudev-dev libboost-chrono-dev libboost-date-time-dev libboost-filesystem-dev
    apt_install libboost-locale-dev libboost-program-options-dev libboost-regex-dev libboost-serialization-dev libboost-system-dev libboost-thread-dev
    apt_install default-libmysqlclient-dev librtmp-dev libssh2-1 libssh2-1-dev libldap2-dev libidn11-dev
    apt_install liblbfgs-dev libbrotli-dev libssh-dev libnghttp2-dev libpsl-dev
    apt_install python3 ccache doxygen graphviz
 
    output " >--> Package installation completed."
}