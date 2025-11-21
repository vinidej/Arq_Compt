`include "full_adder_1bit.v"

module adder4bits(
    input [3:0] a,
    input [3:0] b,
    input       cin,
    output      carry_out,
    output [3:0] s
);
    wire[2:0] cout;
    full_adder_1bit fa0( .s(s[0]), .cout(cout[0]), .a(a[0]), .b(b[0]), .cin(cin));

    full_adder_1bit fa1( .s(s[1]),     .cout(cout[1]),        .a(a[1]),     .b(b[1]),     .cin(cout[0]));

    full_adder_1bit fa2( .s(s[2]),     .cout(cout[2]),        .a(a[2]),     .b(b[2]),     .cin(cout[1])       );

    full_adder_1bit fa3( .s(s[3]),     .cout(carry_out),        .a(a[3]),     .b(b[3]),     .cin(cout[2])       );
    
    
endmodule