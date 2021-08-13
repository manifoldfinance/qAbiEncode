# qKeccak256
Keccak C library for kdb+ integration. Modified from the original sha3 library at:

https://github.com/mjosaarinen/tiny_sha3
by Dr. Markku-Juhani O. Saarinen

based on Keccak algo:
https://keccak.team/keccak_specs_summary.html

## Usage

```q
q)sha3: `qKeccak 2:(`qKeccak256;2)
q)sha3["sam(bytes,bool,uint256[])";count "sam(bytes,bool,uint256[])"]
0xa5643bf27e2786816613d3eeb0b62650200b5a98766dfcfd4428f296fb56d043

```
