`include "DP.v"
`include "CU.v"
`timescale 1ns/1ns
module Mips(clk,rst,inst);
    input clk,rst;
    output [31:0]inst;
    wire[2:0]ALU_control;
    wire mem_read,mem_write,RegWrite,RegDst,ALUSrc,MemToReg,PCSrc,Jmp,Jr,selR31,Jal,zero;
    DP dp(.clk(clk),.rst(rst),.mem_read(mem_read),.mem_write(mem_write),.RegWrite(RegWrite),
    .RegDst(RegDst),.ALUSrc(ALUSrc),.MemToReg(MemToReg),.PCSrc(PCSrc),.Jmp(Jmp),.Jr(Jr),.selR31(selR31),
    .Jal(Jal),.ALU_control(ALU_control),.out(inst),.zero(zero));

    CU cu(.opc(inst[31:26]),.func(inst[5:0]),.zero(zero),.mem_read(mem_read),.mem_write(mem_write),.RegWrite(RegWrite),.RegDst(RegDst),
    .ALUSrc(ALUSrc),.MemToReg(MemToReg),.PCSrc(PCSrc),.Jmp(Jmp),.Jr(Jr),.selR31(selR31),.Jal(Jal),.ALU_control(ALU_control));
endmodule