module internalstate(
    input [3:0]     in,
    input           down,
    output [3:0]    out
);


//    | Current State   | Next State (DOWN=0) | Next State (DOWN=1)  |
//    |-----------------|---------------------|----------------------|
//    | A 101 (1st 3)   | B 100 (2nd 3)       | F 010 (2)            |
//    | B 100 (2nd 3)   | C 011 (3rd 3)       | A 101 (1st 3)        |
//    | C 011 (3rd 3)   | D 110 (5)           | B 100 (2nd 3)        |
//    | D 110 (5)       | E 111 (6)           | C 011 (3rd 3)        |
//    | E 111 (6)       | F 010 (2)           | D 110 (5)            |
//    | F 010 (6)       | A 010 (2)           | E 110 (5)            |


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

wire _zero;
and(_zero, n_in[1], n_in[2]);

///////////////////////////////////////////////////////////////////////
//                            NEXT STATES                            //
///////////////////////////////////////////////////////////////////////

wire up;
not(up, down);

// A ===================================================================
wire out_a, out_a1, out_a2, out_a3;
and(out_a1,     _f,     up);
and(out_a2,     _b,   down);
or (out_a3, out_a2,  _zero);
or ( out_a, out_a1, out_a3);

// B ===================================================================
wire out_b, out_b1, out_b2;
and(out_b1,     _a,     up);
and(out_b2,     _c,   down);
or ( out_b, out_b1, out_b2);

// C ===================================================================
wire out_c, out_c1, out_c2;
and(out_c1,     _b,     up);
and(out_c2,     _d,   down);
or ( out_c, out_c1, out_c2);

// D ===================================================================
wire out_d, out_d1, out_d2;
and(out_d1,     _c,     up);
and(out_d2,     _e,   down);
or ( out_d, out_d1, out_d2);

// E ===================================================================
wire out_e, out_e1, out_e2;
and(out_e1,     _d,     up);
and(out_e2,     _f,   down);
or ( out_e, out_e1, out_e2);

// F ===================================================================
wire out_f, out_f1, out_f2;
and(out_f1,     _e,     up);
and(out_f2,     _a,   down);
or ( out_f, out_f1, out_f2);

///////////////////////////////////////////////////////////////////////
//                           STATE TO BIT                            //
///////////////////////////////////////////////////////////////////////


//    | A 101 |
//    | B 100 |
//    | C 011 |
//    | D 110 |
//    | E 111 |
//    | F 010 |

// out[0] ===============================================================
// is not used.
buf( out[0], in[0]);

// out[1] ===============================================================
// = NOT ( C or F )
wire out_cf;
or(out_cf, out_c, out_f);
not(out[1], out_cf);

// out[2] ===============================================================
// = NOT ( A or B )

wire out_ab;
or(out_ab, out_a, out_b);
not(out[2], out_ab);

// out[3] ===============================================================
// = (A or C or E)

wire out_ac;
or(out_ac, out_a, out_c);
or(out[3], out_ac, out_e);

endmodule