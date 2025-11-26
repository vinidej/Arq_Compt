`include "full_adder_1bit.v"

module adder32bits(
    input [31:0] a,
    input [31:0] b,
    input       cin,
    output      carry_out,
    output      carry30, //Esse é o penúltimo carry, será usada para fazer uma XOR com o último carry. O nome se refere ao carry da posição 30.
    output [31:0] s
);
    wire[30:0] cout; //31 wire de carry.
    //Blocos de somas de 1 bit com o cout sendo a entrada cin do próximo. 32 ao total em cadeia. As saída vão de 0 a 31 em ordem, assim como o numero "a" e o "b".
    full_adder_1bit fa0( .s(s[0]),      .cout(cout[0]),         .a(a[0]),     .b(b[0]),     .cin(cin)           );

    full_adder_1bit fa1( .s(s[1]),      .cout(cout[1]),         .a(a[1]),     .b(b[1]),     .cin(cout[0])       );

    full_adder_1bit fa2( .s(s[2]),      .cout(cout[2]),         .a(a[2]),     .b(b[2]),     .cin(cout[1])       );

    full_adder_1bit fa3( .s(s[3]),      .cout(cout[3]),         .a(a[3]),     .b(b[3]),     .cin(cout[2])       );

    full_adder_1bit fa4( .s(s[4]),      .cout(cout[4]),         .a(a[4]),     .b(b[4]),     .cin(cout[3])       );

    full_adder_1bit fa5( .s(s[5]),      .cout(cout[5]),         .a(a[5]),     .b(b[5]),     .cin(cout[4])       );

    full_adder_1bit fa6( .s(s[6]),      .cout(cout[6]),         .a(a[6]),     .b(b[6]),     .cin(cout[5])       );

    full_adder_1bit fa7( .s(s[7]),      .cout(cout[7]),         .a(a[7]),     .b(b[7]),     .cin(cout[6])       );

    full_adder_1bit fa8( .s(s[8]),      .cout(cout[8]),         .a(a[8]),     .b(b[8]),     .cin(cout[7])       );

    full_adder_1bit fa9( .s(s[9]),      .cout(cout[9]),         .a(a[9]),     .b(b[9]),     .cin(cout[8])       );

    full_adder_1bit fa10( .s(s[10]),     .cout(cout[10]),        .a(a[10]),    .b(b[10]),      .cin(cout[9])         );

    full_adder_1bit fa11( .s(s[11]),     .cout(cout[11]),        .a(a[11]),     .b(b[11]),     .cin(cout[10])     );

    full_adder_1bit fa12( .s(s[12]),     .cout(cout[12]),        .a(a[12]),     .b(b[12]),     .cin(cout[11])       );

    full_adder_1bit fa13( .s(s[13]),     .cout(cout[13]),        .a(a[13]),     .b(b[13]),     .cin(cout[12])       );

    full_adder_1bit fa14( .s(s[14]),     .cout(cout[14]),        .a(a[14]),     .b(b[14]),     .cin(cout[13])       );

    full_adder_1bit fa15( .s(s[15]),     .cout(cout[15]),        .a(a[15]),     .b(b[15]),     .cin(cout[14])       );

    full_adder_1bit fa16( .s(s[16]),     .cout(cout[16]),        .a(a[16]),     .b(b[16]),     .cin(cout[15])       );

    full_adder_1bit fa17( .s(s[17]),     .cout(cout[17]),        .a(a[17]),     .b(b[17]),     .cin(cout[16])       );

    full_adder_1bit fa18( .s(s[18]),     .cout(cout[18]),        .a(a[18]),     .b(b[18]),     .cin(cout[17])       );

    full_adder_1bit fa19( .s(s[19]),     .cout(cout[19]),        .a(a[19]),     .b(b[19]),     .cin(cout[18])       );

    full_adder_1bit fa20( .s(s[20]),     .cout(cout[20]),        .a(a[20]),     .b(b[20]),     .cin(cout[19])        );

    full_adder_1bit fa21( .s(s[21]),     .cout(cout[21]),        .a(a[21]),     .b(b[21]),     .cin(cout[20])        );

    full_adder_1bit fa22( .s(s[22]),     .cout(cout[22]),        .a(a[22]),     .b(b[22]),     .cin(cout[21])        );

    full_adder_1bit fa23( .s(s[23]),     .cout(cout[23]),        .a(a[23]),     .b(b[23]),     .cin(cout[22])       );

    full_adder_1bit fa24( .s(s[24]),     .cout(cout[24]),        .a(a[24]),     .b(b[24]),     .cin(cout[23])       );

    full_adder_1bit fa25( .s(s[25]),     .cout(cout[25]),        .a(a[25]),     .b(b[25]),     .cin(cout[24])       );

    full_adder_1bit fa26( .s(s[26]),     .cout(cout[26]),        .a(a[26]),     .b(b[26]),     .cin(cout[25])       );

    full_adder_1bit fa27( .s(s[27]),     .cout(cout[27]),        .a(a[27]),     .b(b[27]),     .cin(cout[26])       );

    full_adder_1bit fa28( .s(s[28]),     .cout(cout[28]),        .a(a[28]),     .b(b[28]),     .cin(cout[27])       );

    full_adder_1bit fa29( .s(s[29]),     .cout(cout[29]),        .a(a[29]),     .b(b[29]),     .cin(cout[28])       );

    full_adder_1bit fa30( .s(s[30]),     .cout(carry30),        .a(a[30]),     .b(b[30]),     .cin(cout[29])       ); 
//O penúltimo carry é guardado em carry30, e o último em carry_out.
    full_adder_1bit fa31( .s(s[31]),     .cout(carry_out),        .a(a[31]),     .b(b[31]),     .cin(carry30)       );


endmodule
