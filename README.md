# qAbiEncode
KDB+ library for abi encoding ethereum functions. Specifications at:

https://docs.soliditylang.org/en/v0.5.3/abi-spec.html

Supports encoding of static and dynamic types. Fixed types have not been included as they are not currently used in our application.

## Install
Download repo contents and compile C library e.g.
```shell
$ git clone https://github.com/manifoldfinance/qAbiEncode.git
$ cd qAbiEncode
$ make
```

## Usage
Call .abi.encode, passing function signature and values i.e.

```q
q)\l abi.q
q).abi.encode["sam(bytes,bool,uint256[])";("dave";1b;(1 2 3))]
0xa5643bf20000000000000000000000000000000000000000000000000000000000000060000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000a0000000000000000000000000000000000000000000000000000000000000000464617665000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000003

```

Compare results with,
https://docs.soliditylang.org/en/v0.5.3/abi-spec.html

or

https://abi.hashex.org/

## qKeccak256
Ethereum Keccak C library for kdb+ integration. Ethereum sha3 differs from modern sha3 in the padding constant; 

padding (keccak) = 0x01

padding (sha3) = 0x06

Modified from the original sha3 library at:

https://github.com/mjosaarinen/tiny_sha3
by Dr. Markku-Juhani O. Saarinen

based on Keccak algo:
https://keccak.team/keccak_specs_summary.html

### Keccak Usage

```q
q)sha3: `qKeccak 2:(`qKeccak256;2)
q)sha3["sam(bytes,bool,uint256[])";count "sam(bytes,bool,uint256[])"]
0xa5643bf27e2786816613d3eeb0b62650200b5a98766dfcfd4428f296fb56d043

```
