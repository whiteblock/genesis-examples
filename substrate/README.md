# Substrate Example

This example shows how to create a private testnet of all validators. Scripts
and a workflow is provided to scale the number of validators. 

## Quickstart

If you are interested in just running this example out the box, clone this 
repository and rename the `quickstart` folder to `build`. Then, replace the two
instances of  `INSERT_BOOTNODE_LIBP2P_ADDR_HERE` in `wrapper.sh` with the key in
`build/bootnode_libp2p_addr.txt`. Lastly,

    genesis run substrate.yaml

Jump to the "Explore the UI" section.

## Customization Instructions

Clone this repository recursively to clone the source code for
[substrate-developer-hub/substrate-node-template](https://github.com/substrate-developer-hub/substrate-node-template).
Build `node-template` using the Docker workflow. This is important to ensure the
`glibc` version is  compatible with the substrate node Docker container that you
will build.

    cd substrate-node-template
    ./scripts/docker_run.sh

When the build completes and the container runs, close it. We have provided a
default chain specification `customSpec.json` in this repository which is based
on the template generated using the command below. You can use your own by
replacing it. To use the included scripts, make sure to use the filename
`customSpec.json`.

    ./substrate-node-template/target/release/node-template build-spec --disable-default-bootnode --chain local > customSpec.json

Next, run our python script to generate all the keys and modify the chain spec
for your testnet. It will use the substrate tool
[`subkey`](https://substrate.dev/docs/en/knowledgebase/integrate/subkey). A
pre-built binary is included in `bin/` to save time. If a newer version is
needed, replace the  existing one in `bin/`. In the command below, replace
`<num_keys>` with the desired number of validators and replace
`<chain_spec_file>` with the path to your `customSpec.json`.

    python3 gen_keys_chainspec.py <num_keys> <chain_spec_file>

To use the provided Genesis substrate.yaml file, run this command:

    python3 gen_keys_chainspec.py 4 customSpec.json

This will python script will generate validator keys and addresses, add the 
SS58 addresses into the chain spec file, and generate a libp2p address to be
specifically used for the bootnode in the network. These files will be generated
in a `build/` folder. Replace the two instances of 
`INSERT_BOOTNODE_LIBP2P_ADDR_HERE` in `wrapper.sh` with the key in
`bootnode_libp2p_addr.txt`. Next, build the substrate Docker container for
Genesis and push it to a registry.

    docker build . -f substrate.Dockerfile 

Change the `image:` for the substrate service in `substrate.yaml` to the
registry you pushed the container to. Under the `tests:` section of the yaml,
change the number of substrate nodes. Make sure to follow the `NODE_INDEX`
environment variable enumeration. Then, run the Genesis test.

    genesis run substrate.yaml

Note that the `gcr.io/whiteblock/polkadot-js/app` image was built using the 
default Dockerfile in https://github.com/polkadot-js/apps. When preparing this
example, the `chevdor/polkadot-ui:latest` image was months out of date, and
we needed to manually build the image.

## Explore the UI

After a newly launched test starts after the environment is setup, you can point
your  browser to the URL under `Domains:`. This will take you to the polkadot-js
app UI, which is running as a service in the test. In the settings section,
replace the IP address with the same domain. Example:

    ws://wingtundra-0.biomes.whiteblock.io:9944

Explore the UI to see the chain status. If you are using the provided
`chainSpec.json`, there will be test accounts available to send currency between
using the UI.
