# Besu Examples
- [besu.md](./besu.md)
- [besu-ibft-tps.md](./besu-ibft-tps.md)

## Accessing http rpc port
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

## see also:
- https://besu.hyperledger.org/en/stable/HowTo/Configure/Genesis-File/#creating-the-hyperledger-besu-genesis-file
