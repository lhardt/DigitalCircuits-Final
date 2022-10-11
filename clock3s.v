module clock3s(
    input clock,
    input LOW,
    output ena
);

wire HIGH;
not(HIGH, LOW);

wire EA1, EA0;
wire PE0, PE1;

DFFRSE dff1(.q(EA1), .d(PE1), .clk(clock), .reset(LOW), .set(LOW), .enable(HIGH));
DFFRSE dff0(.q(EA0), .d(PE0), .clk(clock), .reset(LOW), .set(LOW), .enable(HIGH));

buf(PE1, EA0);
nor(PE0, EA0, EA1);

buf(ena, PE1);

endmodule