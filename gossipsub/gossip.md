# Gossipsub Testnet

This example shows how to deploy 4 Gossipsub nodes and 1 Orchestra node on a test network.

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