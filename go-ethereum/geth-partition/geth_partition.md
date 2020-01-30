# Geth Partition Testnet

This example shows how to deploy 2 Geth nodes on a test network and implement a network partition.

## Services

### Geth
Go-ethereum client.

## Task-runners

### geth-staticpeers-helper
Deploys helper function that generates static peers for the testnet

## Tests
 Run two geth nodes on the common-network for 10 minutes, implement a network partition for 10 minutes, then reunite the nodes for 10 minutes.
- private/public key will be copied over from `./keystore` to corresponding node.
- peering done statically (static-nodes.json file), all nodes peer to all nodes in the network.
- cpu mining enabled on start.
