#!/bin/bash -xe
  
env | grep "GOSSIP_NODE[0-9]_SERVICE0_GOSSIP_NETWORK" > /topology/IP.txt
#sed -i '' 's/GOSSIP_NODE[0-9]_SERVICE0_GOSSIP_NETWORK=//g' IP.txt
sed -i 's/GOSSIP_NODE[0-9]_SERVICE0_GOSSIP_NETWORK=//g' /topology/IP.txt

count=`cat /topology/IP.txt | wc -l | sed -e 's/^[[:space:]]*//'`
echo $((count - 1)) > /topology/NODECOUNT.txt
