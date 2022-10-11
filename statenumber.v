module statenumber(
    input  [3:0] in,
    output [3:0] number
);

///////////////////////////////////////////////////////////////////////
//                           CURRENT STATES                          //
///////////////////////////////////////////////////////////////////////

wire [3:0] n_in;
not(n_in[0], in[0]);
not(n_in[1], in[1]);
not(n_in[2], in[2]);
not(n_in[3], in[3]);

wire _cf, _c, _f;
and(_cf, n_in[1],   in[2]);
and(_c,      _cf,   in[3]);
and(_f,      _cf, n_in[3]);

wire _ab, _de, _a, _b, _d, _e;
and(_ab,   in[1], n_in[2]);
and(_de,   in[1],   in[2]);
and( _a,     _ab,   in[3]);
and( _b,     _ab, n_in[3]);
and( _d,     _de, n_in[3]);
and( _e,     _de,   in[3]);

///////////////////////////////////////////////////////////////////////
//                           CURRENT STATES                          //
///////////////////////////////////////////////////////////////////////
//    | State (bin.) | Number
//    |--------------| -------------
//    | 111 (E)      | 6 (0110)
//    | 110 (D)      | 5 (0101)
//    | 101 (A)      | 3 (0011)
//    | 100 (B)      | 3 (0011)
//    | 011 (C)      | 3 (0011)
//    | 010 (F)      | 2 (0010)

wire LOW;
and(LOW, in[0], n_in[0]);

// number[0] ==============================================================
buf(number[0], LOW);

// number[1] ==============================================================
// = E or D
or(number[1], _d, _e);

// number[2] ==============================================================
// = NOT D
not(number[2], _d);

// number[3] ==============================================================
// = NOT (E or F)
nor(number[3], _e, _f);

endmodule
