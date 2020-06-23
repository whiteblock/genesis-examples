FROM ubuntu:18.04

RUN apt-get update && apt-get install -y curl jq

COPY substrate-node-template/target/release/node-template /var/local/

WORKDIR /var/local/

EXPOSE 30333 9933 9944 9615

ENTRYPOINT ["bash", "-c", "/var/local/wrapper.sh"]

# Note: customSpec.json needs to be built into the container. Fix coming soon!
COPY customSpec.json /var/local/customSpec.json
COPY wrapper.sh /var/local/wrapper.sh
