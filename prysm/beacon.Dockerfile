FROM gcr.io/prysmaticlabs/build-agent as builder

COPY prysm /src
WORKDIR /src

RUN bazel build //beacon-chain --define ssz=minimal --jobs=auto --verbose_failures

FROM gcr.io/whiteblock/base:ubuntu1804

COPY --from=builder /src/bazel-bin/beacon-chain/linux_amd64_stripped/beacon-chain /usr/local/bin/

EXPOSE 4000

ENTRYPOINT ["/usr/local/bin/beacon-chain"]
