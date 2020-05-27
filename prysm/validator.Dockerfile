FROM gcr.io/prysmaticlabs/build-agent as builder

COPY prysm /src
WORKDIR /src

RUN bazel build //validator:validator --define=ssz=minimal

FROM gcr.io/whiteblock/base:ubuntu1804

COPY --from=builder /src/bazel-bin/validator/linux_amd64_stripped/validator /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/validator"]
