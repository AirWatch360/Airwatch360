# Setting Up PiAware on Your Raspberry Pi

Do you want to link your Raspberry Pi with dump1090 to FlightAware?
If you are running an ADS-B receiver with dump1090 on a Raspberry Pi then you can install the PiAware package to transmit your ADS-B receiver data to FlightAware.

PiAware users can simultaneously use data from their Raspberry Pi running dump1090 and also send flight data to FlightAware via PiAware. Users that share data with FlightAware automatically qualify for a free upgrade to an Enterprise Account.

## What is PiAware?
PiAware is a FlightAware client program that runs on a Raspberry Pi to securely transmit dump1090 ADS-B and Mode S data to FlightAware. PiAware is for people who are already running their own Raspberry Pi with an ADS-B receiver and dump1090.

It's fast and easy to get started.
Using the simple steps below, you can configure your Raspberry Pi to feed FlightAware. The process should take two to three minutes.
Already running PiAware?
View the PiAware upgrade page to update to the latest version.

## What's needed
You should already have a Raspberry Pi with Raspberry Pi OS installed and some basic familiarity with using it.

If you are new to using a Raspberry Pi or need to build a receiver from scratch, please see these instructions instead!

### Requirements:
- Raspberry Pi
- Raspberry Pi OS Bookworm, Bullseye, or Buster installed
- Internet Connection
- Access to a command line shell on the Pi, either over the network or using an attached keyboard and display
- SSH access must be enabled on the Raspberry Pi for remote access. See [Raspberry Pi SSH Documentation](https://www.raspberrypi.org/documentation/remote-access/ssh/) for information on enabling SSH.

### Install the latest OS updates and reboot
This will ensure that you have the latest OS updates before you install FlightAware packages.

```sh
sudo apt update
sudo apt full-upgrade
sudo reboot
```

### Download and Install PiAware
Download and install the FlightAware APT repository package, which tells your Pi's package manager (apt) how to find FlightAware's software packages in addition to the packages provided by Raspbian.

```sh
wget https://uk.flightaware.com/adsb/piaware/files/packages/pool/piaware/f/flightaware-apt-repository/flightaware-apt-repository_1.2_all.deb
sudo dpkg -i flightaware-apt-repository_1.2_all.deb
```

Update your apt package sources and install PiAware. This will install all the required dependencies on your Raspberry Pi.

```sh
sudo apt update
sudo apt install piaware
```

Enable automatic and manual (web-based, via your request) PiAware software updates. These updates are disabled by default. To leave updates disabled, skip this step.

```sh
sudo piaware-config allow-auto-updates yes
sudo piaware-config allow-manual-updates yes
```

### Download and Install dump1090-fa
If you don't already have ADS-B decoder software such as dump1090-fa installed, then you can install FlightAware's version of dump1090 by executing the following command.

```sh
sudo apt install dump1090-fa
```

### Download and Install dump978-fa
Note: 978 MHz UAT is only present in the U.S. If you live outside the U.S, you can skip this step.

```sh
sudo apt install dump978-fa
```

For further instructions to configure your receiver for 978 UAT, go to your [advanced configuration page](https://flightaware.com/adsb/piaware/advanced-configuration).

### Reboot your Pi
Once you have finished installing and configuring the packages, reboot your Raspberry Pi to ensure that everything starts correctly.

```sh
sudo reboot
```

### Claim your PiAware client on FlightAware.com
You should wait about four or five minutes for your PiAware to start and then you can associate your FlightAware account with your PiAware device to receive all the benefits.

Claim your PiAware client on FlightAware.com click --> [https://flightaware.com/adsb/piaware/claim](https://flightaware.com/adsb/piaware/claim)

If after 5 minutes your device hasn't displayed as claimed try restarting the device, if that still doesn't work re-confirm the Wi-Fi settings (if using Wi-Fi) are correct. Lastly, contact support on ADSBsupport@FlightAware.com. Check your stats page (link below) to confirm it was claimed.

### View your ADS-B statistics
View your ADS-B stats at: [FlightAware ADS-B Stats](https://uk.flightaware.com/adsb/stats/USERNAME)
FlightAware will begin processing your data immediately and displaying your statistics within 30 minutes.

- Statistics Page
- or click 'My ADS-B' in the header while signed in. This will only appear after the site has sent data for 30 minutes.
  
Configure your location and antenna height on your statistics page by clicking on the gear icon located to the right of the Site name.

Multilateration, also known as MLAT, functions by pinpointing the location of an aircraft by knowing the locations of sites that received messages from the aircraft.

The FlightAware stats page will also tell you the local IP of your device and provide a link for direct connection. This is where you can find a link to SkyAware, a web portal for viewing flights the receiver is picking up messages from on a map.