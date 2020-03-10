# Besu IBFP TPS Example

Uses proof-of-authority/ibft consensus algorithm for block production

Testnet consists of 7 nodes. See (./genesis-ibft.json)[./genesis-ibft.json] for initial conditions.

## Transactions
Uses the transaction helper to generate a constant stream of transactions until the timeout is reached

## Accessing http rpc port
The http rpc api port can be accessed on port `:8545` of the first biome instance
```
$ genesis run ./besu-ibft-tps.yaml
Project: adcdcc66-d4c4-47b7-aed2-cbe28c3681d3
    baseline:
        Domains:
            pythonseed-0.biomes.whiteblock.io
            pythonseed-1.biomes.whiteblock.io
        ID: 3c9f6908-53fb-464e-8fac-d1dd484c339b
$ geth attach http://pythonseed-0.biomes.whiteblock.io:8545 --exec eth.blockNumber
```
