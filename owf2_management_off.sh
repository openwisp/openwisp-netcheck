#!/bin/sh

# Delete guest DHCP, network and WiFi interfaces
uci delete dhcp.public
uci delete network.public
uci delete wireless.public

uci commit
reload_config
