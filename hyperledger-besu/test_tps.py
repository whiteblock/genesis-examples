"""
assumes you have dig and geth
"""
import pathlib
import shlex
import subprocess
import time

import pytest

DEV = False


class Biome:
    def __init__(self, domain_name):
        self.domain_name = domain_name

        # there isn't currently a way to get the external ip from genesis-cli
        # so ask a dns server that should be one of (if not) the first
        # to get the record
        # Sample output:
        # $ dig +noall +answer @ns-cloud-d1.googledomains.com foemulberry-0.biomes.whiteblock.io  # noqa: E501
        # foemulberry-0.biomes.whiteblock.io. 5 IN A      35.188.227.206
        if DEV:
            cmd = f'dig +noall +answer @ns-cloud-c1.googledomains.com {domain_name}'  # noqa: E501
        else:
            cmd = f'dig +noall +answer @ns-cloud-d1.googledomains.com {domain_name}'  # noqa: E501
        tries = 20
        for i in range(tries):
            proc = subprocess.run(
                shlex.split(cmd),
                check=True,
                capture_output=True,
                encoding='utf-8'
            )
            # eg 'foemulberry-0.biomes.whiteblock.io. 5 IN A\t35.188.227.206\n'
            # or '' if no record is found
            if proc.stdout:
                ipaddr = proc.stdout.split('\t')[1].strip()
                self.external_ip = ipaddr
                break
            time.sleep(i)
        else:
            msg = f"failed to resolve {domain_name} via {self.dns_server}"
            raise AssertionError(msg)


class GenesisRun:
    def __init__(self, test_id, biome):
        self.id = test_id
        self.biome = biome


@pytest.fixture(scope='session')
def genesis_run():
    yaml_path = pathlib.Path(__file__).parent / 'besu-ibft-tps.yaml'
    if DEV:
        cmd = shlex.split(f"genesis run {yaml_path} --no-await --dev")
    else:
        cmd = shlex.split(f"genesis run {yaml_path} --no-await")
    # send this to background? or should genesis have a detach feature?
    proc = subprocess.run(cmd, check=True, capture_output=True, encoding='utf-8')   # noqa: E501

    # Sample output:
    # $ genesis run --no-await tests/static_nginx.yaml
    # Project: 79e207f6-dcd8-47d8-9814-bdaa011c3ba6
    #     serve-static-files:
    #         Domains:
    #             burnhail-0.biomes.whiteblock.io
    #         ID: 2b49713a-0e2e-4cfe-80b4-2096adef1e5d
    lines = proc.stdout.splitlines()
    test_id = lines[-1].split(':')[-1].strip()
    print(f'test_id: {test_id}')
    # it would be faster to get the ip address than to wait for dns
    domain_name = lines[-2].strip()
    biome = Biome(domain_name)
    print(f'biome: {biome.domain_name} {biome.external_ip}')
    yield GenesisRun(test_id, biome)


def test_access_http_rpc_port(genesis_run):
    cmd = shlex.split(
        f'geth attach http://{genesis_run.biome.external_ip}:8545 --exec eth.blockNumber'   # noqa: E501
    )
    tries = 20
    for i in range(tries):
        try:
            subprocess.run(cmd, check=True)
        except subprocess.CalledProcessError:
            if i == tries - 1:
                raise
            else:
                time.sleep(i)
                continue
        break
