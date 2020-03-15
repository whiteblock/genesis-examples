# Creating custom POW-network
## 1. Create node identities
```
# run this multiple times to create node identities as needed
$ docker run --rm -it gcr.io/whiteblock/helpers/ethereum/accounts:master generate
[{"privateKey":"0f8d2f2fdba6eb8afa2e41e355b8407aa694fbf8ee6d8be278a45860628e1eba","publicKey":"74ccafe2182af87c6eb6ce9f59f94c83f305880b029f23d1e54f89f31197e2b01145e98aa2ad2837aa323e8d32b516992d4808a1a46f5bcc0c4081202a57e5a1","address":"0x0204932e7dcf37663dd5ec5103cbb1050a7f9ee7"},{"privateKey":"0129210dbaff3eea1161c69524789df5c397d3a195ff9c165f5dc8ad46543440","publicKey":"0edcb57186375ec1b590227004642c208ce9b8aa78de398b350056a9fdc66a6c4f695fa68594c1f68dfd6b1647f257861a406316ec04e336446376b96527313c","address":"0xca511e698b2fa3c245d6a877b65e0e189db5e4a7"}]
```

NOTE: prepend `0x` to each private key when saving it to a `keystore/pk*` file.

## 2. Create genesis file
see: https://besu.hyperledger.org/en/stable/Tutorials/Private-Network/Create-Private-Network/#2-create-genesis-file

## 3. Set bootnode public key in besu service definition

```
--bootnodes enode://<bootnode-public-key>@${BOOTNODE_SERVICE0_BESU_NETWORK}:30303
```
