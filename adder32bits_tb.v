`timescale 1ns/1ns

`include "adder32bits.v"

module adder32bits_tb;

    // Declarações dos sinais do DUT
    reg  [31:0] a, b;
    reg         cin;
    wire [31:0] s;
    wire        carry_out;

    // Instanciação do DUT (nova ordem das portas do seu módulo)
    adder32bits DUT (
        .a(a),
        .b(b),
        .cin(cin),
        .carry_out(carry_out),
        .s(s)
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
        a   = 32'd0;
        b   = 32'd0;
        cin = 1'b0;

        // 1000 combinações pseudo-aleatórias
        repeat (1000) begin
            #10;
            a = $random;
            b = $random;
            cin = $random;      // agora também testamos o cin
        end

        // Testes específicos
        #10; a = 32'hFFFFFFFF; b = 32'h00000001; cin = 1'b0;
        #10; a = 32'd123456;   b = 32'd654321;   cin = 1'b0;
        #10; a = 32'h80000000; b = 32'h80000000; cin = 1'b0;

        #10;
        $finish;
    end


    /*****************
    *    MONITOR     *
    ******************/
    reg [32:0] expected_sum;

    always @(a, b, cin) begin
        expected_sum = a + b + cin;
        #1;
        if (s !== expected_sum[31:0] || carry_out !== expected_sum[32]) begin
            $display("ERRO:");
            $display("  a=%h", a);
            $display("  b=%h", b);
            $display("  cin=%b", cin);
            $display("  esperado_s=%h  esperado_carry=%b",
                     expected_sum[31:0], expected_sum[32]);
            $display("  obtido_s=%h     obtido_carry=%b",
                     s, carry_out);
            $display("-------------------------------------------");
        end
        // Para debug detalhado, descomente:
        // else $display("OK: a=%h b=%h cin=%b s=%h carry=%b",
        //               a, b, cin, s, carry_out);
    end

endmodule
