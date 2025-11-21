`timescale 1ns/1ns

`include "adder32bits.v"

module adder32bits_tb;

    // Declarações dos sinais do DUT
    reg  [31:0] a, b;
    wire [31:0] s;
    wire        carry_out;

    // Instanciação do DUT
    adder32bits DUT (
        .a(a),
        .b(b),
        .cin(1'b0),
        .s(s),
        .carry_out(carry_out)
    );

    // Dump de formas de onda
    initial begin
        $dumpfile("adder32bits_tb.vcd");
        $dumpvars(0, adder32bits_tb);
    end

    /*****************
    *   DRIVER       *
    ******************/
    initial begin
        // Inicialização
        a = 32'd0;
        b = 32'd0;

        // Vamos testar 1000 combinações pseudo-aleatórias,
        // pois testar todas as 2^64 combinações é impossível.
        repeat (1000) begin
            #10;
            a = $random;
            b = $random;
        end

        // Testes específicos (úteis para depuração)
        #10; a = 32'hFFFFFFFF; b = 32'h00000001; // overflow
        #10; a = 32'd123456;   b = 32'd654321;   // soma simples
        #10; a = 32'h80000000; b = 32'h80000000; // carry alto

        #10;
        $finish;
    end


    /*****************
    *    MONITOR     *
    ******************/
    reg [32:0] expected_sum;

    always @(a, b) begin
        expected_sum = a + b;
        #1;
        if (s !== expected_sum) begin
            $display("ERRO: a=%h  b=%h  esperado=%h  obtido=%h",
                a, b, expected_sum, s);
        end
        // Caso queira ver cada operação funcionando, habilite:
        // else $display("OK: a=%h  b=%h  s=%h", a, b, s);
    end

endmodule