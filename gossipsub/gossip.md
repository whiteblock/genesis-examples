# Gossipsub Testnet

This example shows how to deploy 4 Gossipsub nodes and 1 Orchestra node on a test network.

### Private Key Generation
The following tool was used to generate the keys used in this test: https://github.com/agencyenterprise/pem-utils. This tool provides utility to create pem files and IPFS id's from them. The private keys in the `pems` directory are pre-generated keys using this tooling.

## Services

### gossipsub
Libp2p's Gossipsub

### orchestra
Load injector service

## Task-Runners

### init
Gives Gossipsub nodes 15 seconds to start up

### topology-generator
Creates a pseudo-randomly generated list of peers for gossipnodes to connect to and generate a deterministic network topology

### run 
Runs the testnetwork for 12.5 minutes (750 s)

## Tests

### gossip-load-test
Runs a gossipsub network and sends messages for 12.5 minutes (750 s)