#! /bin/bash

if [ -z "$(command -v jq)" ]; then
    echo 'Error: jq not found'
    exit 1
fi

if [ -z "$(command -v curl)" ]; then
    echo 'Error: curl not found'
    exit 1
fi

# start substrate
if [ "$NODE_INDEX" = 0 ]; then
    /var/local/node-template \
        --base-path /tmp/data \
        --chain=/var/local/customSpec.json \
        --node-key-file=/var/local/bootnode_libp2p_addr \
        --unsafe-ws-external \
        --rpc-cors=all \
        --port 30333 \
        --ws-port 9944 \
        --rpc-port 9933 \
        --telemetry-url 'ws://telemetry.polkadot.io:1024 0' \
        --validator & pid=$!
else
    /var/local/node-template \
        --base-path /tmp/data \
        --chain=/var/local/customSpec.json \
        --unsafe-ws-external \
        --rpc-cors=all \
        --port 30333 \
        --ws-port 9944 \
        --rpc-port 9933 \
        --telemetry-url 'ws://telemetry.polkadot.io:1024 0' \
        --validator \
        --bootnodes "/ip4/${NODE0_SERVICE0_SUBSTRATE_NETWORK}/tcp/30333/p2p/INSERT_BOOTNODE_LIBP2P_ADDR_HERE" & pid=$!
fi

# wait for node to start up
sleep 4

# insert keys
secret_seed=`cat /var/local/keys.json | jq ".node${NODE_INDEX}.aura.secret_seed"`
aura_pubkey=`cat /var/local/keys.json | jq ".node${NODE_INDEX}.aura.pubkey"`
grandpa_pubkey=`cat /var/local/keys.json | jq ".node${NODE_INDEX}.grandpa.pubkey"`

curl -H "Content-Type: application/json" -d \
'{"id":1, "jsonrpc":"2.0", "method": "author_insertKey", "params":["gran", '"${secret_seed}"','"${grandpa_pubkey}"']}' \
http://127.0.0.1:9933/

curl -H "Content-Type: application/json" -d \
'{"id":1, "jsonrpc":"2.0", "method": "author_insertKey", "params":["aura", '"${secret_seed}"','"${aura_pubkey}"']}' \
http://127.0.0.1:9933/

# restart substrate
kill $pid

# give substrate time to shutdown
sleep 2

if [ "$NODE_INDEX" = 0 ]; then
    /var/local/node-template \
        --base-path /tmp/data \
        --chain=/var/local/customSpec.json \
        --node-key-file=/var/local/bootnode_libp2p_addr \
        --unsafe-ws-external \
        --rpc-cors=all \
        --port 30333 \
        --ws-port 9944 \
        --rpc-port 9933 \
        --telemetry-url 'ws://telemetry.polkadot.io:1024 0' \
        --validator
else
    /var/local/node-template \
        --base-path /tmp/data \
        --chain=/var/local/customSpec.json \
        --unsafe-ws-external \
        --rpc-cors=all \
        --port 30333 \
        --ws-port 9944 \
        --rpc-port 9933 \
        --telemetry-url 'ws://telemetry.polkadot.io:1024 0' \
        --validator \
        --bootnodes "/ip4/${NODE0_SERVICE0_SUBSTRATE_NETWORK}/tcp/30333/p2p/INSERT_BOOTNODE_LIBP2P_ADDR_HERE" 
fi
