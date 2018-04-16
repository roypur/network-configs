#!/bin/bash
TEST_IP="2001:4860:4860::8888"
PING_RES=`/bin/ping -w 5 -c 3  ${TEST_IP} | grep --count "100%"`
PREFIX="/opt/vyatta/bin/vyatta-op-cmd-wrapper"

if [ "${PING_RES}" -eq "1" ]
then
    ${PREFIX} release dhcpv6-pd interface eth0
    ${PREFIX} delete dhcpv6-pd duid 
    ${PREFIX} renew dhcpv6-pd interface eth0
fi
    
