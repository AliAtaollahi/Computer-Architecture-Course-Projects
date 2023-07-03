`define Add 6'b100000
`define Sub 6'b100011
`define And 6'b100100
`define Or 6'b100101
`define Slt 6'b101010
`timescale 1ns/1ns
module alu_cu(ALUop,func,op);
    input [1:0]ALUop;
    input [5:0]func;
    output reg [2:0]op;
    always @(ALUop,func) begin
        op=3'b000;
        case (ALUop)
            2'b00: op=3'b010;//add
            2'b01: op=3'b110;//sub
            2'b10: begin
                op=3'b000;
                case (func)
                    `Add: op=3'b010;
                    `Sub: op=3'b110;
                    `And: op=3'b000;
                    `Or:  op=3'b001;
                    `Slt: op=3'b111;
                    default: op=3'b110;
                endcase
            end
            2'b11: op=3'b111;//Slt
            default: op=3'b110;
        endcase
        
    end

endmodule
