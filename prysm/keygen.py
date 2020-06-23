# from py_ecc.bls.api import privtopub
from hashlib import sha256 as _sha256
from typing import List, Dict
from eth_utils import (
    encode_hex,
    int_to_big_endian,
)
import base64
import json
import os

# Number of keys to generate
NUM_KEYS = 4

CURVE_ORDER = 52435875175126190479447740508185965837690552500527637822603658699938581184513


def int_to_hex(n: int, byte_length: int = None) -> str:
    byte_value = int_to_big_endian(n)
    if byte_length:
        byte_value = byte_value.rjust(byte_length, b'\x00')
    return encode_hex(byte_value)


def sha256(x):
    return _sha256(x).digest()


def generate_validator_keypairs(N: int) -> List[Dict]:
    keypairs = []
    for index in range(N):
        privkey = int.from_bytes(
            sha256(index.to_bytes(length=32, byteorder='little')),
            byteorder='little',
        ) % CURVE_ORDER

        # note: switching to big-endian
        privkey_b64 = base64.b64encode(
            privkey.to_bytes(length=32, byteorder='big')
        )
        privkey_b64 = privkey_b64.decode('utf-8')
        keypairs.append({
            'validator_key': privkey_b64,
            'withdrawal_key': privkey_b64
        })
    return keypairs


if __name__ == '__main__':
    keypairs = generate_validator_keypairs(NUM_KEYS)

    validator_keys = {
        'keys': keypairs
    }

    os.makedirs(os.path.dirname('./build/validator_keys.json'), exist_ok=True)
    with open('./build/validator_keys.json', 'w') as f:
        json.dump(validator_keys, f, indent=4)
