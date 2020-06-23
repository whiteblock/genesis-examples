FROM gcr.io/prysmaticlabs/build-agent as builder

COPY prysm /src
WORKDIR /src

RUN bazel build //beacon-chain:beacon-chain --define=ssz=minimal
RUN bazel build //tools/genesis-state-gen --define=ssz=minimal

# using modified version of tool which adds 2 seconds due to genesis-state-gen
# roughtime rounding error
RUN bazel build //tools/update-genesis-time --define=ssz=minimal

FROM ubuntu:18.04

COPY --from=builder /src/bazel-bin/beacon-chain/linux_amd64_stripped/beacon-chain /usr/local/bin/
COPY --from=builder /src/bazel-bin/tools/genesis-state-gen/linux_amd64_stripped/genesis-state-gen /usr/local/bin/
COPY --from=builder /src/bazel-bin/tools/update-genesis-time/linux_amd64_stripped/update-genesis-time /usr/local/bin/

COPY eth2-beaconchain-explorer /eth2-beaconchain-explorer

EXPOSE 3333
EXPOSE 4000
EXPOSE 8080

ENTRYPOINT ["/usr/local/bin/beacon-chain"]
