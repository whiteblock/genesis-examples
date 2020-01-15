# Lighthouse Testnet
This example shows how to deploy 4 Lighthouse beacon nodes and 1 Lighthouse validator client to a network

## Services
### Lighthouse_* (all 4 Lighthouse beacon nodes)
SigmaPrime's Eth 2.0 client

### Validator-Client
SigmaPrime's Eth 2.0 validator client

## Tasks
### start-first-node
Spin up first Lighthouse beacon node

### testnet-expiration
Set an expiration of 10 minutes (600 seconds) on the Lighthouse testnet

## Tests

|  Phase       | Duration   | Description                                                         |
|--------------|------------|---------------------------------------------------------------------|
| start |  1 minute | Allow first Lighthouse beacon node to spin up                           |
| testnet-expiration (baseline) | 10 minutes | Add validator client and remainder of Lighthouse beacon nodes to testnet and allow testnet to run for 10 mninutes |
