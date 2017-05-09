#!/bin/sh

INTERVAL=120
SSID_STATUS=0

vpn_watchdog() {
	if [ -h "/sys/class/net/data" ]; then
   		return 0
	else
		return 1
	fi

}

# Network check loop
while :

do

vpn_watchdog
_net_status="$?"

	if [[ "$_net_status" -eq "0" && "$SSID_STATUS" -eq "1" ]]; then
		. owf2_management_off.sh
		SSID_STATUS=0

	elif [[ "$_net_status" -eq "1" && "$SSID_STATUS" -eq "0" ]]; then
		. owf2_management_on.sh
		SSID_STATUS=1

	else
		sleep $INTERVAL
	fi

done
