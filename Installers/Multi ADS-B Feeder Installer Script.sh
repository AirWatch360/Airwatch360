#!/bin/bash

# Check if script is run as root
if [ "$EUID" -ne 0 ]; then 
    echo -e "\033[1;31m------------------------------"
    echo "Please run this script as root"
    echo "------------------------------\033[0m"
    exit 1
fi

# Function to echo messages with colors
print_message() {
    local message=$1
    local color=$2
    echo -e "${color}${message}${NC}"
}

# ANSI color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Array to collect messages
messages=()

# Introduction
print_message "------------------------------" "${GREEN}"
print_message "This Script will install multiple ADS-B feeders to Raspberry Pi OS" "${YELLOW}"
print_message "Before running make sure you have your coordinates (lat/lon in a form of DD.DDDD) and antenna height (in both feet and m) handy." "${YELLOW}"
print_message "------------------------------" "${GREEN}"

# Confirmation prompt
read -r -p "Do you want to continue with the installation? [y/N] " response
if [[ ! "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    echo "Installation aborted."
    exit 1
fi

# Update and upgrade system
print_message "------------------------------" "${GREEN}"
print_message "Updating System" "${YELLOW}"
print_message "------------------------------" "${GREEN}"
sudo apt-get update && sudo apt-get upgrade -y && sudo apt full-upgrade -y

# Get IP address
MYIP=$(hostname -I | awk '{print $1}')

cd /tmp

# Install dump1090
read -r -p "Do you want to install dump1090? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    print_message "------------------------------" "${GREEN}"
    print_message "Installing dump1090" "${YELLOW}"
    print_message "------------------------------" "${GREEN}"
    wget https://uk.flightaware.com/adsb/piaware/files/packages/pool/piaware/f/flightaware-apt-repository/flightaware-apt-repository_1.2_all.deb
    sudo dpkg -i flightaware-apt-repository_1.2_all.deb
    sudo apt-get update
    sudo apt-get install -y dump1090-fa
fi

# Install FlightAware
read -r -p "Do you want to install FlightAware? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    print_message "------------------------------" "${GREEN}"
    print_message "Installing FlightAware" "${YELLOW}"
    print_message "------------------------------" "${GREEN}"
    sudo apt-get update
    sudo apt-get -y install piaware
    sudo piaware-config allow-auto-updates yes
    sudo piaware-config allow-manual-updates yes
    messages+=("FlightAware Map: http://${MYIP}:8080/")
fi

# Install Planefinder
read -r -p "Do you want to install Planefinder? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    print_message "------------------------------" "${GREEN}"
    print_message "Installing Planefinder" "${YELLOW}"
    print_message "------------------------------" "${GREEN}"
    PFCLIENT_VER=5.0.161
    wget http://client.planefinder.net/pfclient_${PFCLIENT_VER}_armhf.deb
    sudo dpkg -i pfclient_${PFCLIENT_VER}_armhf.deb
    rm -f pfclient_${PFCLIENT_VER}_armhf.deb
    messages+=("Planefinder: http://${MYIP}:30053/")
fi

# Install FlightRadar24
read -r -p "Do you want to install FlightRadar24? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    print_message "------------------------------" "${GREEN}"
    print_message "Installing FlightRadar24" "${YELLOW}"
    print_message "------------------------------" "${GREEN}"
    sudo bash -c "$(wget -O - https://repo-feed.flightradar24.com/install_fr24_rpi.sh)"
    messages+=("FR24 Status: http://${MYIP}:8754/")
fi

# Install ADS-B Exchange
read -r -p "Do you want to install ADS-B Exchange? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    print_message "------------------------------" "${GREEN}"
    print_message "Installing ADS-B Exchange" "${YELLOW}"
    print_message "------------------------------" "${GREEN}"
    curl -L -o /tmp/axfeed.sh https://adsbexchange.com/feed.sh
    bash /tmp/axfeed.sh
    curl -L -o /tmp/axstats.sh https://www.adsbexchange.com/stats.sh 
    sudo bash /tmp/axstats.sh
    messages+=("ADS-B Exchange: https://www.adsbexchange.com/myip/")
fi

# Install OpenSky
read -r -p "Do you want to install OpenSky? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    print_message "------------------------------" "${GREEN}"
    print_message "Installing OpenSky" "${YELLOW}"
    print_message "------------------------------" "${GREEN}"
    wget https://opensky-network.org/files/firmware/opensky-feeder_latest_armhf.deb
    sudo dpkg -i opensky-feeder_latest_armhf.deb
fi


# Install Radarbox
read -r -p "Do you want to install Radarbox? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    print_message "------------------------------" "${GREEN}"
    print_message "Installing Radarbox" "${YELLOW}"
    print_message "------------------------------" "${GREEN}"
    sudo bash -c "$(wget -O - http://apt.rb24.com/inst_rbfeeder.sh)"
    sudo rbfeeder --set-network-mode on --set-network-host 127.0.0.1 --set-network-port 30005 --set-network-protocol beast --no-start
    messages+=("Radarbox: https://www.radarbox.com/raspberry-pi/claim")
fi

# Install Dump 1090 graphs
read -r -p "Do you want to install Dump 1090 graphs? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    print_message "------------------------------" "${GREEN}"
    print_message "Installing Dump 1090 graphs" "${YELLOW}"
    print_message "------------------------------" "${GREEN}"
    sudo bash -c "$(curl -L -o - https://github.com/wiedehopf/graphs1090/raw/master/install.sh)"
    messages+=("Graphs: http://${MYIP}/graphs1090/")
fi

# Install Dump 1090 maps
read -r -p "Do you want to install Dump 1090 maps? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    print_message "------------------------------" "${GREEN}"
    print_message "Installing Dump 1090 maps" "${YELLOW}"
    print_message "------------------------------" "${GREEN}"
    sudo bash -c "$(wget -nv -O - https://github.com/wiedehopf/tar1090/raw/master/install.sh)"
    sudo sed -i -e 's?.*flightawareLinks.*?flightawareLinks = true;?' /usr/local/share/tar1090/html/config.js
    messages+=("Map: http://${MYIP}/tar1090/")
fi

# Install Timelapse 1090
read -r -p "Do you want to install Timelapse 1090? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    print_message "------------------------------" "${GREEN}"
    print_message "Installing Timelapse 1090" "${YELLOW}"
    print_message "------------------------------" "${GREEN}"
    sudo bash -c "$(wget -q -O - https://raw.githubusercontent.com/wiedehopf/timelapse1090/master/install.sh)"
    messages+=("TimeLapse: http://${MYIP}/timelapse/")
fi

# Create feeder status script if FR24 was installed
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    print_message "------------------------------" "${GREEN}"
    print_message "FR24 Feed Status" "${YELLOW}"
    print_message "------------------------------" "${GREEN}"
    echo "piaware-status" | sudo tee /root/feeder-status.sh > /dev/null
    sudo chmod +x /root/feeder-status.sh
fi

# Final messages and links
print_message "------------------------------" "${GREEN}"
print_message "Installation Complete" "${YELLOW}"
print_message "------------------------------" "${GREEN}"

# Display collected messages
for message in "${messages[@]}"; do
    print_message "$message" "${YELLOW}"
done

print_message "------------------------------" "${GREEN}"
print_message "!! Please Reboot System !!" "${YELLOW}"
print_message "------------------------------" "${GREEN}"

# Reboot system if requested
read -r -p "Do you want to reboot now? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    sudo reboot
else
    echo "Reboot skipped. Please reboot your system manually later."
fi