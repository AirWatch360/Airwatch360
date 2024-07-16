# How to share data from Piaware?

**Note:** SSH password for piaware image is "flightaware" without the quotes.

To share data from your Piaware with Flightradar24, simply follow the instructions below:

1. Login/SSH into your Pi and run the following script on it. This will download, install, and start the signup process. It might take a little time to complete, so give it a while.
   ```sh
   wget -qO- https://fr24.com/install.sh | sudo bash -s
   ```

**Note:** This does not affect your piaware feed!

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
```