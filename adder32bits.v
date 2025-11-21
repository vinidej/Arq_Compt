`include "adder16bits.v"

module adder32bits(
    input [31:0] a,
    input [31:0] b,
    input        cin,
    output [31:0]s,
    output       carry_out
);
wire cout;
adder16bits a0 (.a( a[15:0] ), .b( b[15:0] ), .cin(cin), .s( s[15:0] ), .carry_out(cout)) ;

adder16bits a1 ( .a( a[31:16] ) , .b( b[31:16] ) , .cin( cout ), .s( s[31:16] ), .carry_out(carry_out));

endmodule