build:
	docker build -t "gcr.io/whiteblock/paritytech/substrate:latest" . -f substrate.Dockerfile

push:
	docker push "gcr.io/whiteblock/paritytech/substrate:latest"

gen-spec:
	substrate-node-template/target/release/node-template \
	build-spec \
	--disable-default-bootnode \
	--chain local > customSpec.json

run: 
	docker run -it --rm --name=substrate gcr.io/whiteblock/paritytech/substrate

tester:
	substrate-node-template/target/release/node-template \
	--base-path /tmp/data \
	--chain=customSpec.json \
	--unsafe-ws-external \
	--rpc-cors=all \
	--port 30333 \
	--ws-port 9944 \
	--rpc-port 9933 \
	--telemetry-url 'ws://telemetry.polkadot.io:1024 0' \
	--validator

local:
	genesis local substrate.yaml

stop-local:
	docker stop `docker ps -a -q`
	docker rm `docker ps -a -q`

clean:
	rm -rf ./build/

.PHONY: build push run tester local stop-local clean