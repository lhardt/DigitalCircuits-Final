module circuit(
        input clock,
        input down,
        output [6:0] display,
        input LOW
);


wire HIGH;
not( HIGH, LOW );
// and( LOW, n_number_0, display[0] );


wire [3:0] state_i;
wire [3:0] state_f;
wire [3:0] repr_number;
wire [6:0] number_buf;

internalstate state_machine( .in(state_i), .out(state_f), .down(down));
reg4          register(.ed(state_f), .eck(clock), .es(LOW), .er(LOW), .eena(HIGH), .sq(state_i));
statenumber   out_number(.in(state_i), .number(repr_number));
numberdigit   output_view(.number(repr_number), .digit(number_buf));

buf( display[0], number_buf[0]);
buf( display[1], number_buf[1]);
buf( display[2], number_buf[2]);
buf( display[3], number_buf[3]);
buf( display[4], number_buf[4]);
buf( display[5], number_buf[5]);
buf( display[6], number_buf[6]);

endmodule