module numberdigit(
    input  [2:0] number,
    output [6:0] digit
);

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
// B:  !five AND !six
// C:  !two
// D:  !one AND  !four AND !seven
// E:  number[3] AND !four
// F:  number[0] OR (!seven AND !number[1]) OR zero
// G:  number[0] OR (!seven AND !one AND !two)
endmodule;