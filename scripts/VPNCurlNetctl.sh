#!/bin/bash
# i3Blocks VPN status command using netctl

# Variables 
# Check the public ip which outputs to a file 
IPExternal=$(curl -s --connect-timeout 60 http://ifconfig.me > ~/.ipCurl.log)

# Functions
#Check VPN status; see if tun0 existings as a connection
getVPN () 
{
if ip route show | grep "tun0" > /dev/null ; then
  DisplayVPNIP
else
  getIP
fi
}

# Display the VPN IP in the Status bar
DisplayVPNIP () {
 $IPExternal &&  echo 🔐 `cat ~/.ipCurl.log`
}

#Check External IP exisits or if the network is locked
getIP () {
if grep -q [0-9] ~/.ipCurl.log; then
 $IPExternal && echo 🔓 `cat ~/.ipCurl.log`
else
  echo  🔒 LOCKED 🔒
fi
}

# Run the script
getVPN
