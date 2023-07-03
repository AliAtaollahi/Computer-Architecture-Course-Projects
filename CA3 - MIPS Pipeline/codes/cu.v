`include "alu_cu.v"
`define R_type 6'b000000
`define Addi 6'b001001
`define Slti 6'b001010
`define Lw 6'b100011 
`define Sw 6'b101011
`define J 6'b000010
`define Jal 6'b000011
`define Jr 6'b000110
`define Beq 6'b000100
`timescale 1ns/1ns
module cu (operation_code,thefunction,zero,reg__destination,mem__to_reg,reg__write, alu_src, mem__read, mem__write, pc_src, operation, IF_flush, operands_eq );
    input [5:0] operation_code,thefunction;
    input zero , operands_eq;
    output reg reg__write, alu_src, mem__read, mem__write,IF_flush;
    output reg [1:0] pc_src, mem__to_reg,reg__destination;
    output [2:0] operation;
    reg [1:0] alu_operation;
    reg branch;
    alu_cu ALU_CTRL(alu_operation, thefunction, operation);
    always @(operation_code)
    begin
        {reg__destination, mem__to_reg, reg__write, alu_src, mem__read, mem__write, pc_src, alu_operation, IF_flush} = 13'd0;
        case (operation_code)
            `R_type : {reg__destination, reg__write, alu_operation} = {2'b01, 1'b1, 2'b10};
            `Lw : {alu_src, mem__to_reg, reg__write, mem__read} = {1'b1, 2'b01, 1'b1, 1'b1};
            `Sw : {alu_src, mem__write} = 2'b11;
            `Beq : {pc_src, IF_flush} = {1'b0, operands_eq, operands_eq};   
            `Addi : {reg__write, alu_src} = 2'b11;
            `J : {pc_src, IF_flush} = {2'b10, 1'b1};
            `Jal : {reg__destination, mem__to_reg, pc_src} = {2'b10, 2'b10, 2'b10};
            `Jr: {pc_src} = {2'b11};
            `Slti: {alu_src, reg__destination, reg__write, alu_operation, mem__to_reg} = {1'b1, 2'b00, 1'b1, 2'b11, 2'b00}; 
        endcase
    end
endmodule