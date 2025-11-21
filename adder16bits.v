`include "adder4bits.v"

module adder16bits(
    input [15:0] a,
    input [15:0] b,
    input        cin,
    output [15:0] s,
    output carry_out
);
wire[2:0] cout;
adder4bits a0(.a(a[3:0]), .b(b[3:0]), .cin(cin), .carry_out(cout[0]), .s(s[3:0]) );

adder4bits a1(.a(a[7:4]), .b(b[7:4]), .cin(cout[0]), .carry_out(cout[1]), .s(s[7:4]) );

adder4bits a2(.a(a[11:8]), .b(b[11:8]), .cin(cout[1]), .carry_out(cout[2]), .s(s[11:8]) );

adder4bits a3(.a(a[15:12]), .b(b[15:12]) , .cin(cout[2]), .carry_out(carry_out), .s(s[15:12]) );

endmodule