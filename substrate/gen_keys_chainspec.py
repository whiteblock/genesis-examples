from shutil import which
import sys
import subprocess
import re
import os
import json


def modify_chainspec(file, keys):
    with open(file, 'r+') as f:
        chainspec = json.load(f)
        chainspec['genesis']['runtime']['aura']['authorities'] = []
        chainspec['genesis']['runtime']['grandpa']['authorities'] = []

        for node in keys.values():
            chainspec['genesis']['runtime']['aura']['authorities'].append(
                node['aura']['ss58_addr'])
            chainspec['genesis']['runtime']['grandpa']['authorities'].append(
                [node['grandpa']['ss58_addr'], 1])

        f.seek(0)
        f.truncate()
        json.dump(chainspec, f, indent=2)


if __name__ == '__main__':
    if which("subkey") is None:
        print("Substrate 'subkey' utility missing. Please install it.")
        exit()

    if len(sys.argv) > 3:
        print("too many arguments")
        exit()
    elif len(sys.argv) == 3:
        num_keys = int(sys.argv[1])
        chainspec_file = sys.argv[2]
    else:
        print("not enough arguments")
        exit()

    keys = {}

    for i in range(num_keys):
        keys['node{}'.format(i)] = {
            'aura': {},
            'grandpa': {}
        }
        k = keys['node{}'.format(i)]

        # generate aura key
        result = subprocess.run(['./bin/subkey', 'generate'], stdout=subprocess.PIPE)
        result = str(result.stdout, 'utf-8')

        # parse aura secret seed
        seed = re.compile('(?<=Secret seed:        ).*')
        secret_seed = seed.search(result).group(0)
        k['aura']['secret_seed'] = secret_seed

        # parse aura public key
        key = re.compile('(?<=Public key \(hex\):   ).*')
        k['aura']['pubkey'] = key.search(result).group(0)

        # parse aura SS58 address
        ss58 = re.compile('(?<=SS58 Address:       ).*')
        k['aura']['ss58_addr'] = ss58.search(result).group(0)

        # generate grandpa key using the same seed
        result = subprocess.run(
            ['subkey', '--ed25519', 'inspect', secret_seed],
            stdout=subprocess.PIPE
        )
        result = str(result.stdout, 'utf-8')

        k['grandpa']['secret_seed'] = secret_seed

        # parse grandpa public key
        key = re.compile('(?<=Public key \(hex\):   ).*')
        k['grandpa']['pubkey'] = key.search(result).group(0)

        # parse grandpa SS58 address
        ss58 = re.compile('(?<=SS58 Address:       ).*')
        k['grandpa']['ss58_addr'] = ss58.search(result).group(0)


    # create json with list of nodeX keys. need seed and the aura+gran pubkey and ss58 addr.
    filename = './build/keys.json'
    os.makedirs(os.path.dirname(filename), exist_ok=True)
    with open(filename, 'w') as f:
        json.dump(keys, f, indent=4)

    if (os.path.exists('./build/bootnode_libp2p_addr') and
        os.path.exists('./build/bootnode_libp2p_addr.txt')) is False:
        filename = './build/bootnode_libp2p_addr.txt'
        with open(filename, 'w') as f:
            result = subprocess.run(
                ['./bin/subkey', 'generate-node-key', './build/bootnode_libp2p_addr'],
                stdout=subprocess.PIPE)
            result = str(result.stdout, 'utf-8')
            f.seek(0)
            f.truncate()
            f.write(result)
            f.close()
    else:
        print("Bootnode keys found. Skipping generation...")

    # modify chain spec template file with new validator set
    modify_chainspec(chainspec_file, keys)
