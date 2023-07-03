`include "Mux.v"
`include "Sign_ext.v"
`include "ALU.v"
`include "PC.v"
`include "Reg_file.v"
`include "Memory.v"
`include "Register.v"
`include "Mux3to1.v"
`timescale 1ns/1ns
module DP(clk,rst,mem_read,mem_write,IorD,IRWrite,writeRegSel,MemToReg,writeRegEn,PCld,PCSrc,ALU_control,ALUSrcA,ALUSrcB,out,zero);
    input clk,rst,mem_read,mem_write,IorD,IRWrite,writeRegSel,MemToReg,writeRegEn,PCld;
    input[1:0] PCSrc;
    input[2:0]ALU_control;
    input ALUSrcA;
    input[1:0]ALUSrcB;
    output [15:0]out;
    output zero;

    wire [11:0]PCin,PCout;
    wire [11:0]memAddr;
    wire [15:0]instruction,Ain,Aout,Bin,Bout,instOrData,memoryout,writeData,immediate_data,ALU_A,ALU_B,ALU_result,ALU_out;
    wire [2:0]writeReg;
    //wire PCld;
    //assign PCld=(PCWriteCond&zero)|PCWrite;
    PC pc(.clk(clk),.rst(rst),.ld(PCld),.in(PCin),.out(PCout));
    Mux #(12)mux1(.sel(IorD),.in1(PCout),.in2(instruction[11:0]),.out(memAddr));

    Memory memory(.clk(clk),.mem_read(mem_read),.mem_write(mem_write),.addr(memAddr),.write_data(Aout),.read_data(instOrData));
    Register IR(.clk(clk),.rst(rst),.ld(IRWrite),.in(instOrData),.out(instruction));
    Register MDR(.clk(clk),.rst(rst),.ld(1'b1),.in(instOrData),.out(memoryout));

    //assign writeRegSel= ALUCoWr & regDst;
    Mux #(3)mux2(.sel(writeRegSel),.in1(3'd0),.in2(instruction[11:9]),.out(writeReg));
    Mux #(16)mux3(.sel(MemToReg),.in1(ALU_out),.in2(memoryout),.out(writeData));
    Reg_file reg_f(.clk(clk),.RegWrite(writeRegEn),.read_reg1(3'd0),.read_reg2(instruction[11:9]),
                    .write_reg(writeReg),.write_data(writeData),.read_data1(Ain),.read_data2(Bin));

    Sign_ext sign(.in(instruction[11:0]),.out(immediate_data));
    Register A(.clk(clk),.rst(rst),.ld(1'b1),.in(Ain),.out(Aout));
    Register B(.clk(clk),.rst(rst),.ld(1'b1),.in(Bin),.out(Bout));
    Mux #(16)mux4(.sel(ALUSrcA),.in1({{4{1'b0}},PCout}),.in2(Aout),.out(ALU_A));
    Mux3to1 #(16)mux5(.sel(ALUSrcB),.in1(Bout),.in2(16'd1),.in3(immediate_data),.out(ALU_B));

    ALU alu(.A(ALU_A),.B(ALU_B),.control(ALU_control),.zero(zero),.Y(ALU_result));
    Register alu_reg(.clk(clk),.rst(rst),.ld(1'b1),.in(ALU_result),.out(ALU_out));

    Mux3to1 #(12) mux6(.sel(PCSrc),.in1(ALU_result[11:0]),.in2(instruction[11:0]),.in3({PCout[11:9],instruction[8:0]}),.out(PCin));



    assign out=instruction;

endmodule