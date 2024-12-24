	#!/bin/bash
#####################################################
# Source https://mailinabox.email/ https://github.com/mail-in-a-box/mailinabox
# Updated by cryptopool.builders for crypto use...
# Modified by Vaudois
# Further modified to support Ubuntu 22.04 and PHP 8.2 without Apache
#####################################################
 
ESC_SEQ="\x1b["
COL_RESET=$ESC_SEQ"39;49;00m"
RED=$ESC_SEQ"31;01m"
GREEN=$ESC_SEQ"32;01m"
YELLOW=$ESC_SEQ"33;01m"
BLUE=$ESC_SEQ"34;01m"
MAGENTA=$ESC_SEQ"35;01m"
CYAN=$ESC_SEQ"36;01m"
 
echo
echo -e "$CYAN => Check prerequisite : $COL_RESET"
 
if [ "`lsb_release -d | sed 's/.*:\s*//' | sed 's/22\.04\.[0-9]/22.04/' `" == "Ubuntu 22.04 LTS" ]; then
    DISTRO=22
    echo -e "$GREEN Ubuntu 22.04 LTS detected. Continuing installation... $COL_RESET"
    sudo chmod g-w /etc /etc/default /usr
elif [ "`lsb_release -d | sed 's/.*:\s*//' | sed 's/20\.04\.[0-9]/20.04/' `" == "Ubuntu 20.04 LTS" ]; then
    DISTRO=20
    echo -e "$GREEN Ubuntu 20.04 LTS detected. Continuing installation... $COL_RESET"
    sudo chmod g-w /etc /etc/default /usr
else
    echo -e "$RED This script only supports Ubuntu 22.04 LTS and Ubuntu 20.04 LTS $COL_RESET"
    echo -e "$RED Stopping installation now! $COL_RESET"
    exit 1
fi
 
ARCHITECTURE=$(uname -m)
if [ "$ARCHITECTURE" != "x86_64" ]; then
  if [ -z "$ARM" ]; then
    echo -e "$RED YiimP Install Script only supports x86_64 and will not work on any other architecture, like ARM or 32 bit OS. $COL_RESET"
    echo -e "$RED Your architecture is $ARCHITECTURE $COL_RESET"
    exit 1
  fi
fi
 
# Check for PHP 8.2
if command -v php > /dev/null 2>&1; then
    PHP_VERSION=$(php -r "echo PHP_MAJOR_VERSION.'.'.PHP_MINOR_VERSION;")
    if [ "$PHP_VERSION" == "8.2" ]; then
        echo -e "$GREEN PHP 8.2 detected. $COL_RESET"
    else
        echo -e "$YELLOW PHP version $PHP_VERSION detected. This script is optimized for PHP 8.2. $COL_RESET"
        echo -e "$YELLOW You may encounter issues. Do you want to continue? (y/n) $COL_RESET"
        read -r response
        if [[ "$response" =~ ^([nN][oO]|[nN])$ ]]; then
            echo -e "$RED Exiting installation. $COL_RESET"
            exit 1
        fi
    fi
else
    echo -e "$YELLOW PHP not detected. Installing PHP 8.2... $COL_RESET"
    sudo apt update
    sudo apt install -y php8.2 php8.2-cli php8.2-fpm php8.2-mysql php8.2-curl php8.2-gd php8.2-mbstring php8.2-xml php8.2-zip
fi
 
# Check if Apache is installed and stop it if it is
if systemctl is-active --quiet apache2; then
    echo -e "$YELLOW Apache2 is running. Stopping and disabling it... $COL_RESET"
    sudo systemctl stop apache2
    sudo systemctl disable apache2
    echo -e "$GREEN Apache2 has been stopped and disabled. $COL_RESET"
fi
 
echo -e "$GREEN All prerequisites checked and satisfied. $COL_RESET"
echo -e "$GREEN Proceeding with the rest of the installation... $COL_RESET"