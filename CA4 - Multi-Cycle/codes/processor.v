`include "DP.v"
`include "CU.v"
`timescale 1ns/1ns
module processor(clk,rst,inst);
    input clk,rst;
    output [15:0]inst;

    wire mem_read,mem_write,IorD,IRWrite,writeRegSel,MemToReg,writeRegEn,PCld;
    wire [1:0] PCSrc;
    wire[2:0]ALU_control;
    wire ALUSrcA;
    wire[1:0]ALUSrcB;
    wire zero;


    DP dp(.clk(clk),.rst(rst),.mem_read(mem_read),.mem_write(mem_write),.IorD(IorD),
    .IRWrite(IRWrite),.writeRegSel(writeRegSel),.MemToReg(MemToReg),.writeRegEn(writeRegEn),.PCld(PCld),
    .PCSrc(PCSrc),.ALU_control(ALU_control),.ALUSrcA(ALUSrcA),.ALUSrcB(ALUSrcB),.out(inst),.zero(zero));

    CU cu(.clk(clk),.rst(rst),.opc(inst[15:12]),.func(inst[8:0]),.zero(zero),.mem_read(mem_read),.mem_write(mem_write),
    .PCld(PCld),.IorD(IorD),.IRWrite(IRWrite),.writeRegSel(writeRegSel),.MemToReg(MemToReg),.writeRegEn(writeRegEn),
    .PCSrc(PCSrc),.ALUSrcA(ALUSrcA),.ALUSrcB(ALUSrcB),.ALU_control(ALU_control));
endmodule