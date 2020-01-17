# Simple Geth Testnet

This example shows how to deploy 2 Geth nodes on a test network.

## Services

### Geth
Go-ethereum client.

## Tests
Run two geth nodes on the common-network.
- private/public key will be copied over from `./keystore` to corresponding node.
- peering done statically (static-nodes.json file), all nodes peer to all nodes in the network.
- setup ethstats with the `geth_ethstats.yaml` test definition file.
- cpu mining enabled on start.
