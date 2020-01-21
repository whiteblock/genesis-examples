#!/bin/bash
#sed -i 's/IPLIST/'$IPS'/g' ./configs/orchestra/config.json

eval 'IPFILE=($(cat IP.txt))'

declare -a IPS
for ip in "${IPFILE[@]}"; do
  IPS+=($ip:8080,)
done

IPADDRS=`echo ${IPS[@]} | tr -d '[:space:]' | jq -R -s -c 'split(",")[:-1]'`
sed -i 's/IPLIST/'$IPADDRS'/g' ./configs/orchestra/config.json
