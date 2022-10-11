module numberdigit(
    input  [3:0] number,
    output [6:0] digit
);

wire [3:0] n_number;
not( n_number[3], number[3] );
not( n_number[2], number[2] );
not( n_number[1], number[1] );
not( n_number[0], number[0] );

wire _0123, _4567, _89, _01, _23, _45, _67;
and( _0123, n_number[0], n_number[1]);
and( _4567, n_number[0],   number[1]);
and(   _01,       _0123, n_number[2]);
and(   _23,       _0123,   number[2]);
and(   _89,   number[0], n_number[1]);
and(   _45,       _4567, n_number[2]);
and(   _67,       _4567,   number[2]);

wire _0, _1, _2, _3, _4, _5, _6, _7, _8, _9;
and(    _0,         _01, n_number[3]);
and(    _1,         _01,   number[3]);
and(    _2,         _23, n_number[3]);
and(    _3,         _23,   number[3]);
and(    _4,         _45, n_number[3]);
and(    _5,         _45,   number[3]);
and(    _6,         _67, n_number[3]);
and(    _7,         _67,   number[3]);
and(    _8,         _89, n_number[3]);
and(    _9,         _89,   number[3]);


// INPUT A B C D E F G
//  0000 1 1 1 1 1 1 0
//  0001 0 1 1 0 0 0 0
//  0010 1 1 0 1 1 0 1
//  0011 1 1 1 1 0 0 1
//  0100 0 1 1 0 0 1 1
//  0101 1 0 1 1 0 1 1
//  0110 1 0 1 1 1 1 1
//  0111 1 1 1 0 0 0 0
//  1000 1 1 1 1 1 1 1
//  1001 1 1 1 1 0 1 1

// A:  number[0] OR number[2] OR five OR zero
wire a_aux1, a_aux2;

or(a_aux1,  number[0],  number[2]);
or(a_aux2,         _5,         _0);
or(digit[0],   a_aux1,     a_aux2);

// B:  !five AND !six
nor(digit[1], _5, _6);
// C:  !two
not( digit[2], _2);
// D:  !one AND  !four AND !seven
wire _14;
or(_14, _1, _4);
nor(digit[3], _14, _7);
// E:  !number[3] AND !four
wire n_4;
not(n_4, _4);
and(digit[4], n_4, n_number[3]);
// F:  number[0] OR (!seven AND number[1]) OR zero
wire f_aux1, f_aux2;
wire n_7;

or(f_aux1, _0, number[0]);
not(n_7, _7);
and(f_aux2, n_7, number[1]);

or(digit[5],  f_aux2, f_aux1);

// G:  number[0] OR (!seven AND !one AND !zero)
wire n_0, n_1;
not(n_0, _0);
not(n_1, _1);

wire g_aux1, g_aux2;
and(g_aux1, n_7, n_1);
and(g_aux2, g_aux1, n_0);

or(digit[6], g_aux2, number[0]);

endmodule