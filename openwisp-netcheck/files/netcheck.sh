#!/bin/sh

INTERVAL=120

vpn_watchdog() {
	if [ -h "/sys/class/net/owf2" ]; then
                _ssid_status=1
        else
                _ssid_status=0
        fi

	if [ -h "/sys/class/net/data" ]; then
		_net_status=0
	else
	        _net_status=1
	fi

}

logger	-s "OpenWISP network check: started" \
	-t openwisp \
	-p daemon.info

# Network check loop
while :

do

vpn_watchdog

	if [[ "$_net_status" -eq "0" && "$_ssid_status" -eq "1" ]]; then
		. owf2_management_off.sh
		_ssid_status=0
		logger	-s "OpenWISP network check: Management SSID down" \
			-t openwisp \
			-p daemon.info
		sleep 5

	elif [[ "$_net_status" -eq "1" && "$_ssid_status" -eq "0" ]]; then
		. owf2_management_on.sh
		_ssid_status=1
                logger	-s "OpenWISP network check: Management SSID up" \
			-t openwisp \
			-p daemon.info
		sleep 5

	else
		sleep $INTERVAL
	fi

done
