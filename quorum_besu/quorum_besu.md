# Hyperledger Besu - Quorum Testnet

This example shows how to deploy 3 Besu nodes and 4 Quorum nodes on a test network.

## Services

### Quorum Geth
Quorum Go-ethereum client

### Hyperledger Besu
Hyperledger Besu client

### Ethstats
An ethstats service connected to the 4 Quorum nodes

## Task-Runners

### static-peers
Helper that gathers the IP addresses and generate a static peers file.

### Testnet Expiration
Sets the testnet to operate for 10 minutes.

## Tests
Run 3 Besu nodes and 4 Quorum nodes on the quorum-network