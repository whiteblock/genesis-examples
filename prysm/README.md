# NOTE:
You need to clone this repo recursively to build the validator and beacon chain images

# TODO:
Have the validator get farther along than `Waiting for beacon chain start log from the ETH 1.0 deposit contract`:

```
time="2020-03-28 04:37:14" level=info msg="Validating for public key" prefix=node pubKey=0xab8d3a9bcc160e518fac0756d3e192c74789588ed4a2b1debf0c78f78479ca8edb05b12ce21103076df6af4eb8756ff9
time="2020-03-28 04:37:14" level=info msg="Validating for public key" prefix=node pubKey=0xaec922bd7a9b7b1dc21993133b586b0c3041c1e2e04b513e862227b9d7aecaf9444222f7e78282a449622ffc6278915d
time="2020-03-28 04:37:14" level=info msg="Validating for public key" prefix=node pubKey=0x92a93728c252a45ef587ca53a037593912599d82e2b8aa1b734b99d500a0ac8c142092ea8b3c2c34a28dc8ddf337a249
time="2020-03-28 04:37:14" level=info msg="Validating for public key" prefix=node pubKey=0x94f0c8535601596eb2165adb28ebe495891a3e4ea77ef501e7790cccb281827d377a5a8d4c200e3595d3f38f8633b480
time="2020-03-28 04:37:14" level=info msg="Validating for public key" prefix=node pubKey=0xa34febc12af07316580b480364f90a76313ccce7927bbe263e27ea270853b02ad4d1428caf55363f3ebebac622cb9fd6
time="2020-03-28 04:37:14" level=info msg="Validating for public key" prefix=node pubKey=0x91ae4686b0d20470409f020eaca826c3efc6c1926ed25d05e6f0f7916391ec89c2341917277c437ac8fffffe94b68111
time="2020-03-28 04:37:14" level=info msg="Validating for public key" prefix=node pubKey=0x9314c6de0386635e2799af798884c2ea09c63b9f079e572acc00b06a7faccce501ea4dfc0b1a23b8603680a5e3481327
time="2020-03-28 04:37:14" level=info msg="Validating for public key" prefix=node pubKey=0xae00fc3de831b09661a0ac02873c45c84cb2b58cffb6430a3f607e4c3fa1e0932397f11307cd169cdc6f79c463527260
time="2020-03-28 04:37:14" level=info msg="Validating for public key" prefix=node pubKey=0xaef9162ee6f29ee82fbfe387756d84f9ac472eb8709217aaf28f5ef0ea273f6210e531496470b30d2b7747216e3672d5
time="2020-03-28 04:37:14" level=info msg="Validating for public key" prefix=node pubKey=0x81054bd51ce57a8415f0c8e0f2fbf94f5a8464552baa33263c20a4da062e5ed994a4d32c171106d2008cd063f48f6fe2
time="2020-03-28 04:37:14" level=info msg="Validating for public key" prefix=node pubKey=0x8d5d3672a233db513df7ad1e8beafeae99a9f0199ed4d949bbedbb6f394030c0416bd99b910e14f73c65b6a11fe6b62e
time="2020-03-28 04:37:14" level=info msg="Validating for public key" prefix=node pubKey=0xb9d1d914df3d4565465c3fd52b5b96e637f9980570cabf5b5d4aadf5a329ac36ad672819d997e735f5052e28b1f0c104
time="2020-03-28 04:37:14" level=info msg="Validating for public key" prefix=node pubKey=0xb245d63d3f9d8ea1807a629fcb1b328cb4d542f35a3d5bc478be0df389dddd712fc4c816ba3fede9a96320ae6b24a7d8
2020/03/28 04:37:14 exit status 128
time="2020-03-28 04:37:14" level=info msg="Starting validator node" prefix=node version="Prysm/Git commit: {STABLE_GIT_COMMIT}. Built at: 2020-03-28T04:37:14Z"
time="2020-03-28 04:37:14" level=info msg="Starting 2 services: [*prometheus.Service *client.ValidatorService]" prefix=registry
time="2020-03-28 04:37:14" level=info msg="Collecting metrics at endpoint" endpoint=":8080" prefix=prometheus
time="2020-03-28 04:37:14" level=warning msg="You are using an insecure gRPC connection! Please provide a certificate and key to use a secure connection." prefix=validator
time="2020-03-28 04:37:14" level=warning msg="Incorrect gRPC header flag format. Skipping " prefix=validator
time="2020-03-28 04:37:14" level=info msg="Successfully started gRPC connection" prefix=validator
time="2020-03-28 04:37:14" level=info msg="Waiting for beacon chain start log from the ETH 1.0 deposit contract" prefix=validator
```
