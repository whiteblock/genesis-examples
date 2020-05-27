FROM gcr.io/prysmaticlabs/build-agent as builder

COPY prysm /src
WORKDIR /src

RUN bazel build //beacon-chain:beacon-chain --define=ssz=minimal
RUN bazel build //tools/genesis-state-gen --define=ssz=minimal
RUN /src/bazel-bin/tools/genesis-state-gen/linux_amd64_stripped/genesis-state-gen \
  --output-yaml=/tmp/genesis.ssz \
  --num-validators=4 \
  --mainnet-config=false # aka minimal-config

RUN cat /tmp/genesis.ssz

FROM gcr.io/whiteblock/base:ubuntu1804

COPY --from=builder /src/bazel-bin/beacon-chain/linux_amd64_stripped/beacon-chain /usr/local/bin/
COPY --from=builder /tmp/genesis.ssz /tmp/genesis.ssz

EXPOSE 4000

ENTRYPOINT ["/usr/local/bin/beacon-chain"]
