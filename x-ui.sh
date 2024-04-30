#!/bin/bash

for ip_ad in $(sed -nE  's/.*"ip": "([^"]+)".*/\1/p' scan.json); do
        if curl --max-time 1 http://$ip_ad:54321; then
                res=$(curl "http://${ip_ad}:54321/login"  --data-raw 'username=admin&password=admin' --compressed  --insecure)
                if [[ "$res" =~ .*true.* ]]; then
                        echo $ip_ad | tee >> week.log
                fi
                echo $ip_ad | tee >> all.log
        fi
done;
