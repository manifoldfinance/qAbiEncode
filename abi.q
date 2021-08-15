\d .abi

hex_to_int:{0x0 sv x};
int_to_hex:{0x0 vs x};

sha3: `qKeccak 2:(`qKeccak256;2);

pad32: {[x] 
    len: count x;
    fall: 32-len;
    (fall#0x00),x
    };
encodeValue: {[x]
    paramType: x[0];
    paramValue: x[1];
    $[any (paramType=`uint8),(paramType=`uint16), (paramType=`uint32),paramType=`uint64;
        pad32 int_to_hex paramValue;
        paramType=`bool;
        pad32 "x"$paramValue;
        paramType=`uint256;
        pad32 paramValue;
        paramType=`address;
        paramValue;
        paramType=`$"address[]";
        {(pad32 int_to_hex count x; x)} each paramValue;
        0x0000;
        ]
    };
encode: {[ funcString; paramValues ]
    hash: sha3[ funcString; count funcString ];
    methodId: 4#hash;
    firstB: first funcString ss "(";
    lastB: last funcString ss ")";
    paramTypes: `$"," vs funcString[1+firstB+til lastB - (1+firstB)];
    $[(count paramTypes)=count paramValues;
        methodId, raze encodeValue each paramTypes,' paramValues; / expand for dynamic types
        0x0000;
        ]
    };

\d .
