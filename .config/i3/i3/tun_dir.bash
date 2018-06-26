#!/usr/bin/bash

tun=$(ip -4 -h -o addr | awk '{print $2" "$4}' | grep -E 'tun'$1)

[[ $tun == "" ]] && echo $tun && exit

interface=$(echo $tun | awk '{print $1}')
address=$(echo $tun | awk '{print $2}')

case ${2} in
    int)
        echo $interface;;
    add)
        echo $address;;
esac
