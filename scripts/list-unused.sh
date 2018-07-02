#!/bin/bash
public_ipv6=$(curl --silent -6 "https://icanhazip.com")
res="$?"

if [[ "${res}" == "0" ]]
then
    local_ipv6=$(ip -6 addr | grep "/")
    for addr_line in ${local_ipv6}
    do
        addr=$(echo ${addr_line} | awk '{print $2}')
        addr_noprefix=$(echo ${addr} | cut "-d/" "-f1")
        if [[ "${addr_noprefix}" != "${public_ipv6}" ]]
        then
            first_nibble=$(echo ${addr} | head -c 1)
            if [[ "${first_nibble}" == "2" ]] || [[ "${first_nibble}" == "3" ]]
            then
                echo ${addr}
            fi
        fi
    done
else
    echo "public IPv6 not detected"
fi
