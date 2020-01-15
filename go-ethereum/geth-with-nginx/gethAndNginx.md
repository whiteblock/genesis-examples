# Geth with Nginx
This example shows how to deploy 2 geth nodes to a network along with nginx service

## Services
### Geth
Go-ethereum client
### Nginx
Web server

## Tasks
### geth-transactions
A simple echo command for now.

## Sidecars
### "yes"
A sidecar to nginx service

## Tests

|  Phase       | Duration   | Description                                                         |
|--------------|------------|---------------------------------------------------------------------|
| baseline tps |  5 minutes | Run without network latency for 5 minutes                           |
| tps w/ latency |  5 minutes | Run with network latency of 100ms for 5 minutes                   |
| nginx deploy |  2 minutes (default) |  Run two networks with 10 instances of the nginx service for a default of 2 minutes               |