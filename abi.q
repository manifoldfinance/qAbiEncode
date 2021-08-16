/ abi encoding specs: https://docs.soliditylang.org/en/v0.5.3/abi-spec.html

\d .abi

hex_to_int:{0x0 sv x};
int_to_hex:{0x0 vs x};

sha3: `qKeccak 2:(`qKeccak256;2);

castToHex: {[x]
  tp: type x;
  $[10h = tp; / string
    "x"$x;
    -10h = tp; / char
    "x"$enlist x;
    4h = tp; / bytes
	x;
	-4h = tp;   / byte
	enlist x;
	-7h = tp;   / long
	int_to_hex x;
	-6h = tp;   / int
	int_to_hex x;
	-5h = tp;   / short
	int_to_hex x;
    -1h = tp;
    "x"$x;
	'`unknownType
	]
  };

pad32: {[x] 
    len: count x;
    fall: 32-len;
    raze (fall#0x00),x
    };
padRight32: {[x] 
    len: count x;
    fall: 32-len;
    raze x,fall#0x00
    };
encodeValue: {[x]
    paramType: x[0];
    paramValue: x[1];
    $[any (paramType=`uint8),(paramType=`uint16), (paramType=`uint32),paramType=`uint64;
        pad32 castToHex paramValue;
        paramType=`bool;
        pad32 castToHex paramValue;
        paramType=`uint256;
        pad32 castToHex paramValue;
        paramType=`address;
        pad32 paramValue;
        paramType=`$"address[]";
        (pad32 int_to_hex count paramValue;{[addr] pad32 addr} each paramValue);
        any (paramType=`$"uint256[]"),(paramType=`$"uint32[]"),(paramType=`$"uint64[]"),paramType=`$"uint16[]";
        (pad32 int_to_hex count paramValue;{[uint]  pad32 castToHex uint} each paramValue);
        any (paramType=`string),paramType=`bytes;
        (pad32 int_to_hex count castToHex paramValue; padRight32 castToHex paramValue);
        0x0000;
        ]
    };

shiftDynamic: {[x;y]
    offset: y*32;
    shiftedVals:();
    dynamicVals:();
    i:0;
    do[y;
        $[ 32 < count raze raze x[i];
            [
                dynamicVals,: raze raze x[i];
                shiftedVals,: pad32 int_to_hex offset;
                offset: offset + count dynamicVals;
                ];
            [shiftedVals,: raze raze x[i];]
            ];
        i:i+1;
        ];
    shiftedVals,dynamicVals
    };
encode: {[ funcString; paramValues ]
    hash: sha3[ funcString; count funcString ];
    methodId: 4#hash;
    firstB: first funcString ss "(";
    lastB: last funcString ss ")";
    paramTypes: `$"," vs funcString[1+firstB+til lastB - (1+firstB)];
    $[(count paramTypes)=count paramValues;
        [
            encVals: encodeValue each paramTypes,' enlist each paramValues;
            methodId, raze shiftDynamic[encVals; count paramTypes]
            ];
        0x0000;
        ]
    };

\d .
