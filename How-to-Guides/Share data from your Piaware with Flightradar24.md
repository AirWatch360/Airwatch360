# How to share data from Piaware?

**Note:** SSH password for piaware image is "flightaware" without the quotes.

To share data from your Piaware with Flightradar24, simply follow the instructions below:

1. Login/SSH into your Pi and run the following script on it. This will download, install, and start the signup process. It might take a little time to complete, so give it a while.
   ```sh
   wget -qO- https://fr24.com/install.sh | sudo bash -s
   ```

**Note:** This does not affect your piaware feed!

'''
# Welcome to the FR24 Decoder/Feeder sign up wizard!

Before you continue please make sure that:
1. Your ADS-B receiver is connected to this computer or is accessible over network
2. You know your antenna's latitude/longitude up to 4 decimal points and the altitude in feet
3. You have a working email address that will be used to contact you
4. fr24feed service is stopped. If not, please run: `sudo service fr24feed stop`

To terminate - press Ctrl+C at any point

Step 1.1 – Enter your email address (username@domain.tld) 

**Enter your email address here**

Step 1.2 – If you used to feed FR24 with ADS-B data before enter your sharing key.
If you don’t remember your sharing key, please use the retrieval form:
http://feed.flightradar24.com/forgotten_key.php

Otherwise leave this field empty and continue.

**Enter sharing key or leave blank if signing up**

*Verifying sharing key...OK*

*If signing up, you will be asked to provide your coordinates in decimal format*

Step 1.3 – Would you like to participate in MLAT calculations? (yes/no):

**yes**

*IMPORTANT: For MLAT calculations the antenna's location should be entered very precise!*

Step 3.A – Enter antenna's latitude (DD.DDDD)

**Latitude in decimal format**

Step 3.B – Enter antenna's longitude (DDD.DDDD)

**Longitude in decimal format**

Step 3.C – Enter antenna's altitude above the sea level (in feet)

**Altitude in feet above sea level**

Using latitude: 59.3308, longitude: 18.07080, altitude: 150ft above sea level

We have detected that you already have a dump1090 instance running. We can therefore automatically configure the FR24 Decoder to use existing receiver configuration, or you can manually configure all the parameters.

Would you like to use autoconfig (yes/no):

**yes**

Step 6A – Please select desired logfile mode:

1 = Disabled
2 = 72 hour, 24h rotation
Default logfile mode (0-2): 

**2**

Step 6B – Please enter desired logfile path (/var/log):

**Leave blank**

Submitting form data...OK

Congratulations! You are now registered and ready to share ADS-D data with Flightradar24.
Your radar id is T-ESB5415, please include it in all email communication with us.
You are expected to start sharing data within the next 3 days or otherwise your ID/KEY will be deleted.

Thank you for supporting Flightradar24! We hope that you will enjoy our Premium services that will be available to you as soon as you become an active feeder.

To start sending data now please execute:

**sudo service fr24feed start** `<-- Last step`

Saving settings to /etc/fr24feed.ini...OK
Settings saved
To restart the service run `sudo service fr24feed restart` to use new configuration.
*FR24 Feeder/Decoder online and configured!*

pi@raspberrypi:~$

'''

Open your browser and go to
```
http://IP-of-Pi:8754/settings.html
```
Make sure to replace `IP-of-Pi` in the above URL with the actual IP address of your raspberry pi. If you have the correct IP address.

Both the settings below are correct. You can use either. Just make sure you use the correct port with the correct receiver type i.e., AVR(TCP) is 30002.

### Via SSH

To SSH into a Pi, refer to [this guide](https://flightradar24com.freshdesk.com/en/support/solutions/articles/3000115468).

Run the following command to display your settings:
```sh
cat /etc/fr24feed.ini
```

They should be as follows:

Both the settings below are correct. You can use either. Just make sure you use the correct port with the correct receiver type i.e., AVR(TCP) is 30002.

```ini
receiver="avr-tcp"
fr24key="Sharing Key"
host="127.0.0.1:30002"
bs="no"
raw="no"
logmode="2"
windowmode="0"
logpath="/var/log/fr24feed"
mpx="no"
mlat="no"
mlat-without-gps="no"
```

OR

```ini
receiver="beast-tcp"
fr24key="Sharing Key"
host="127.0.0.1:30005"
bs="no"
raw="no"
logmode="2"
windowmode="0"
logpath="/var/log/fr24feed"
mpx="no"
mlat="no"
mlat-without-gps="no"
```