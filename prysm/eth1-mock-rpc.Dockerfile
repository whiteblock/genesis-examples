FROM gcr.io/whiteblock/base:ubuntu1804

COPY eth1-mock-rpc-bin /usr/local/bin/eth1-mock-rpc

EXPOSE 7777
EXPOSE 7778

ENTRYPOINT ["/usr/local/bin/eth1-mock-rpc"]
