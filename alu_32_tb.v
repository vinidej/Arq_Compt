`include "alu_32.v"

`timescale 1ns/1ps

module alu_32_tb;

  reg  [31:0] a, b;
  reg  [3:0]  alu_ctrl;
  wire [31:0] result;
  wire        zero;
  wire        carry_out;
  wire        overflow;

  // DUT
  alu_32 dut (
    .a(a),
    .b(b),
    .alu_ctrl(alu_ctrl),
    .result(result),
    .zero(zero),
    .carry_out(carry_out),
    .overflow(overflow)
  );

  // Dump para GTKWave
  initial begin
    $dumpfile("alu_32_tb.vcd");
    $dumpvars(0, alu_32_tb);
  end

  // Modelo de referência
  task automatic check;
    input [31:0] ta, tb;
    input [3:0]  top;
    input [127:0] nome;

    reg [31:0] exp_result;
    reg        exp_zero;
    reg        exp_carry_out;
    reg        exp_overflow;
    reg [32:0] wide_sum; // para pegar carry em 33 bits

  begin
    a = ta;
    b = tb;
    alu_ctrl = top;

    #1; // deixa a ALU propagar

    // valores padrão
    exp_result    = 32'b0;
    exp_carry_out = 1'b0;
    exp_overflow  = 1'b0;

    case (top)
      4'b0000: begin  // AND
        exp_result = ta & tb;
      end

      4'b0001: begin  // OR
        exp_result = ta | tb;
      end

      4'b0010: begin  // ADD
        wide_sum        = {1'b0, ta} + {1'b0, tb};
        exp_result      = wide_sum[31:0];
        exp_carry_out   = wide_sum[32];  // unsigned
        exp_overflow    = (ta[31] == tb[31]) &&
                          (exp_result[31] != ta[31]);
      end

      4'b0110: begin  // SUB (a - b)
        wide_sum        = {1'b0, ta} + {1'b0, ~tb} + 33'd1;
        exp_result      = wide_sum[31:0];
        exp_carry_out   = wide_sum[32];  // 1 = sem borrow
        exp_overflow    = (ta[31] != tb[31]) &&
                          (exp_result[31] != ta[31]);
      end

      4'b0111: begin  // SLT signed (igual à sua ALU)
        if ($signed(ta) < $signed(tb))
          exp_result = 32'd1;
        else
          exp_result = 32'd0;
      end

      4'b1100: begin  // NOR
        exp_result = ~(ta | tb);
      end

      default: begin
        exp_result    = 32'hDEAD_BEEF;
        exp_carry_out = 1'b0;
        exp_overflow  = 1'b0;
      end
    endcase

    exp_zero = (exp_result == 32'h0000_0000);

    // Verificação (igual ao seu formato)
    if (result      !== exp_result   ||
        zero        !== exp_zero     ||
        ((top == 4'b0010 || top == 4'b0110) &&
         (carry_out !== exp_carry_out || overflow !== exp_overflow))) begin

      $display("ERRO (%s): ctrl=%b a=%h b=%h", nome, top, ta, tb);
      $display("   result    = %h (exp %h)", result,    exp_result);
      $display("   zero      = %b (exp %b)", zero,      exp_zero);
      $display("   carry_out = %b (exp %b)", carry_out, exp_carry_out);
      $display("   overflow  = %b (exp %b)", overflow,  exp_overflow);
    end else begin
      $display("OK   (%s): ctrl=%b a=%h b=%h -> result=%h zero=%b carry_out=%b overflow=%b",
               nome, top, ta, tb, result, zero, carry_out, overflow);
    end
  end
  endtask

  // Sequência de testes
  initial begin
    // AND
    check(32'hFFFF_0000, 32'h0F0F_F0F0, 4'b0000, "AND 1");
    check(32'h0000_FFFF, 32'hFFFF_0000, 4'b0000, "AND 2");

    // OR
    check(32'hF0F0_0000, 32'h0F0F_FFFF, 4'b0001, "OR 1");

    // ADD simples
    check(32'd10, 32'd20, 4'b0010, "ADD 10+20");
    check(32'd0,  32'd0,  4'b0010, "ADD zero");
    check(32'hFFFF_FFFF, 32'd1, 4'b0010, "ADD carry_out");

    // ADD com overflow signed
    check(32'h7FFF_FFFF, 32'd1,       4'b0010, "ADD overflow +");
    check(32'h8000_0000, 32'hFFFF_FFFF, 4'b0010, "ADD overflow -");

    // SUB simples
    check(32'd20, 32'd10, 4'b0110, "SUB 20-10");
    check(32'd10, 32'd20, 4'b0110, "SUB 10-20");
    check(32'd0,  32'd0,  4'b0110, "SUB zero");

    // SUB com overflow signed
    check(32'h8000_0000, 32'd1, 4'b0110, "SUB overflow");

    // SLT signed
    check( 32'sd5,   32'sd7,  4'b0111, "SLT 5 < 7");
    check( 32'sd7,   32'sd5,  4'b0111, "SLT 7 < 5");
    check(-32'sd3,   32'sd2,  4'b0111, "SLT -3 < 2");
    check( 32'sd2,  -32'sd3,  4'b0111, "SLT 2 < -3");

    // NOR
    check(32'hFFFF_0000, 32'h0000_FFFF, 4'b1100, "NOR 1");

    #10;
    $display("Fim da simulação.");
    $finish;
  end

endmodule