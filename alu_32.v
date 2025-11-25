`include "adder32bits.v"


module alu_32(
    input wire[31:0] a,
    input wire[31:0] b,
    input wire [3:0] alu_ctrl,

    output reg[31:0] result,
    output reg       zero,
    output reg       carry_out,
    output reg       overflow
);

wire[31:0] result_da_funcao;
wire       carry_da_funcao;
wire       carry_anterior;
wire       cin;
wire[31:0] n_b;

assign n_b = (alu_ctrl == 4'b0110) ? ~b : b;
assign cin = (alu_ctrl == 4'b0110) ? 1'b1 : 1'b0;


adder32bits a0(
    .a(a[31:0]), 
    .b(n_b[31:0]), 
    .cin(cin), 
    .carry_out(carry_da_funcao),
    .carry30(carry_anterior),
    .s(result_da_funcao[31:0]) 
);

always @(*) begin
    result    = 32'd0;
    zero      = 1'b1;
    carry_out = 1'b0;
    overflow  = 1'b0;

    case(alu_ctrl)
        4'b0000: begin  //AND
            result = a & b;
            carry_out = 1'b0;
            overflow = 1'b0;
            if(result == 32'd0)
                zero = 1'b1;
            else
                zero = 1'b0;
        end
        4'b0001: begin  //OR
            result = a | b;
            carry_out = 1'b0;
            overflow = 1'b0;
            if(result == 32'd0)
                zero = 1'b1;
            else
                zero = 1'b0;
        end
        4'b0111: begin  //SLT
            zero = 1'b0;
            carry_out = 1'b0;
            overflow = 1'b0;
            if ($signed(a) < $signed(b))begin
                result = 32'd1;
                zero = 1'b0;
            end
            else begin
                result = 32'd0;
                zero = 1'b1;
            end
        end
        4'b1100: begin  //NOR
            result = ~(a | b);
            carry_out = 1'b0;
            overflow = 1'b0;
            if(result == 32'd0)
                zero = 1'b1;
            else
                zero = 1'b0;
        end
        4'b0010: begin //ADD
            result = result_da_funcao;
            carry_out = carry_da_funcao;
            overflow = carry_anterior ^ carry_da_funcao;
            if(result == 32'd0)
                zero = 1'b1;
            else
                zero = 1'b0;
        end
        4'b0110: begin //SUB
            result = result_da_funcao;
            carry_out = carry_da_funcao;
            overflow = carry_anterior ^ carry_da_funcao;
            if(result == 32'd0)
                zero = 1'b1;
            else    
                zero = 1'b0;
        end

    endcase
end


endmodule