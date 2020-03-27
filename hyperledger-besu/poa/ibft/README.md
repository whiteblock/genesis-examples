# Besu IBFP TPS Example

Uses proof-of-authority/ibft consensus algorithm for block production

Testnet consists of 7 nodes. See (./genesis-ibft.json)[./genesis-ibft.json] for initial conditions.

## Transactions
Uses the transaction helper to generate a constant stream of transactions until the timeout is reached

## Accessing http rpc port
The http-rpc port can be externally exposed on the boot node by adding a port mapping to the bootnode service
e.g.
```
system:
  - type: bootnode
    port-mappings:
      - "8545:8545"
    resources:
      networks:
        - name: besu-network
```

This allows the testnet to be accessed externally:
```
$ genesis run ./besu-ibft-tps.yaml
Project: adcdcc66-d4c4-47b7-aed2-cbe28c3681d3
    baseline:
        Domains:
            pythonseed-0.biomes.whiteblock.io
        ID: 3c9f6908-53fb-464e-8fac-d1dd484c339b
$ geth attach http://pythonseed-0.biomes.whiteblock.io:8545 --exec eth.blockNumber
```

## Creating/Modifying Nodes
Proof-of-Authority/iBFT networks require encoding the nodes that are authorized to
produce blocks into the genesis file.

### Step 1: Creating Accounts
Use the `gcr.io/whiteblock/ethereum/accounts:master` helper to create a json list of test accounts.
```
$ docker run --rm -it gcr.io/whiteblock/helpers/ethereum/accounts:master generate
[{'address': '0xbb7aec51c32b2d5649f3cb2c6a0273a705aed03b',
  'privateKey': '4a05a8cfb03a901f23fc69ffeb61e91425d4b50bfa8b22220aac48d927e8ed9b',
  'publicKey': '978a22249c380b8d5f755f71da2616ba951476b83ce13f5ab8b00cd9b3b2a08a3f7eb6ec7e6117532002dcfbade3299e953bd60725706b0fe7731f224514f7ea'},
 {'address': '0x9bcafd29c54e34d1e5ed02cd9f776b2eaa29d0c5',
  'privateKey': '563ffc16d8a8ea4c39cc9377aa3ada78aac55b7c62332214fe0fa255a19162d0',
  'publicKey': 'e2bc6b60bd15bf20e09d1e77d1e31b8b4d1d60444aa244ec5901203b706b2c3e4de44f8e90e488101cdcc8b894ecaa6928125cca3e38acd1a49613602bda86d4'}]
```

### Step 2: Use generated addresses to populate the extraData genesis field
use the address field to populate a json list of authoritative nodes:
```
# toEncode.json
[
  "0xd5e9cf1c79aa30f2573ef262fb6d1dbb6ca7614b",
  "0x76d81931b1afeb029f7f9889e18375ef62bc0fbe",
  "0xff6aa9e7a0e7b3149efa2929accf801be2407408",
  "0x73e46631232d6504b8c137db25723d39d38cfbd7",
  "0x67df06ecd2d2b16b16657cb59aebc322fdc0019f",
  "0xb219d9e541735992c5ff825a2477181bc9f356df",
  "0x3b318694b3680ad3383bad6c9296c9ff7c8e395f"
]
```

Following the directions [here](./https://besu.hyperledger.org/en/stable/HowTo/Configure/Consensus-Protocols/IBFT/#extra-data), use the `hyperledger/besu:latest` container to create the value for the `extraData` genesis field:

```
$ docker run -v $(pwd):/src --workdir /src --rm -it hyperledger/besu:latest rlp encode --from=toEncode-ibft.json
```

### Step 3: Create private key files
finally, create a file in the [keystore](./keystore) directory for each private key

Note: prepend `0x`, e.g.:
```
# keystore/pk0
0x4a05a8cfb03a901f23fc69ffeb61e91425d4b50bfa8b22220aac48d927e8ed9b
```
and
```
# keystore/pk1
0x563ffc16d8a8ea4c39cc9377aa3ada78aac55b7c62332214fe0fa255a19162d0
```
