#!/bin/bash

# docker run --rm -it gcr.io/whiteblock/helpers/ethereum/tx:master \
docker run --rm -it tx \
 --tps=1 \
 --private-key=5d07b874ec190c444ed1a39a6104a1eaafab1e5837c259f520c3ae2e287c857d \
 --destination=0xb8172dc7230f3b84787331a976218d57735b65bb \
 --value=0.1 \
 --chain-id=2018 \
 --target=$1:8545 \
 --gas-price=0x1fff \
 --gas-limit=0x1fffffffffff
