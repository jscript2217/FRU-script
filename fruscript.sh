#!/bin/bash

for((;;))
do
    # Insert IP
    echo "Insert BMC IP Address."
    read IP
    # IP string format validation
    if [[  $IP =~ ^(([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))\.){3}([1-9]?[0-9]|1[0-9][0-9]|2([0-4][0-9]|5[0-5]))$ ]]; then
        echo "BMC IP Address : $IP"
        break
    else
        echo "'$IP' is not ip address. please try again."
    fi
done
