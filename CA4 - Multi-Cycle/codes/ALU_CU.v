`define MoveTo 9'b000000001
`define MoveFrom 9'b000000010
`define Add 9'b000000100
`define Sub 9'b000001000
`define And 9'b000010000
`define Or  9'b000100000
`define Not 9'b001000000
`define Nop 9'b010000000
`timescale 1ns/1ns
module ALU_CU(ALUop,func,op,notnoop,ALUCoWr);
    input [2:0]ALUop;
    input [8:0]func;
    output reg [2:0]op;
    output reg notnoop,ALUCoWr;
    always @(ALUop,func) begin
        op=3'b000;ALUCoWr=1'b0;notnoop=1'b1;
        case (ALUop)
            3'b000: op=3'b010;//add
            3'b001: op=3'b011;//sub
            3'b010: begin
                op=3'b000;
                case (func)
                    `MoveTo: begin op=3'b101;ALUCoWr=1'b1;notnoop=1'b1;end// A
                    `MoveFrom: begin op=3'b110;ALUCoWr=1'b0;notnoop=1'b1;end//B
                    `Add: begin op=3'b010;ALUCoWr=1'b0;notnoop=1'b1;end//A+B
                    `Sub: begin op=3'b011;ALUCoWr=1'b0;notnoop=1'b1;end//A-B
                    `And: begin op=3'b000;ALUCoWr=1'b0;notnoop=1'b1;end//A&B
                    `Or:  begin op=3'b001;ALUCoWr=1'b0;notnoop=1'b1;end//A|B
                    `Not: begin op=3'b100;ALUCoWr=1'b0;notnoop=1'b1;end//~B
                    `Nop: begin notnoop=1'b0;end
                    default: begin op=3'b110;ALUCoWr=1'b0;notnoop=1'b1;end
                endcase
            end
            3'b011: op=3'b000;//A&B
            3'b100: op=3'b001;//A|B
            default: op=3'b110;
        endcase
        
    end
    

endmodule