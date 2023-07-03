`include "Adder.v"
`include "Data_mem.v"
`include "Mux.v"
`include "Sign_ext.v"
`include "ALU.v"
`include "PC.v"
`include "Inst_mem.v"
`include "shifter.v"
`include "Reg_file.v"
`timescale 1ns/1ns
module DP(clk,rst,mem_read,mem_write,RegWrite,RegDst,ALUSrc,MemToReg,PCSrc,Jmp,Jr,selR31,Jal,ALU_control,out,zero);
    input clk,rst,mem_read,mem_write,RegWrite,RegDst,ALUSrc,MemToReg,PCSrc,Jmp,Jr,selR31,Jal;
    input[2:0]ALU_control;
    output [31:0]out;
    output zero;
    wire [31:0]PCin,PCout,instruction,ALU_out,op1,op2,ALU_B,address,addressSh2,Write_reg_data,Write_reg_data1,Mem_out,PC4,jump_addr,PC4OrBeq,JAndOther;
    wire [27:0]instShift2;
    wire[4:0] Write_reg1,Write_reg;
    PC pc(.clk(clk),.rst(rst),.in(PCin),.out(PCout));
    Inst_mem insMem(.addr(PCout),.inst(instruction));
    Adder adder(.A(32'd4),.B(PCout),.sum(PC4));
    ALU alu(.A(op1),.B(ALU_B),.control(ALU_control),.zero(zero),.Y(ALU_out));
    Reg_file reg_f(.clk(clk),.RegWrite(RegWrite),.read_reg1(instruction[25:21]),.read_reg2(instruction[20:16]),
    .write_reg(Write_reg),.write_data(Write_reg_data),.read_data1(op1),.read_data2(op2));

    Data_mem data_mem(.clk(clk),.mem_read(mem_read),.mem_write(mem_write),.addr(ALU_out),.write_data(op2),.read_data(Mem_out));
    Sign_ext se(.in(instruction[15:0]),.out(address));

    Mux #(5) mux1(.in1(instruction[20:16]),.in2(instruction[15:11]),.sel(RegDst),.out(Write_reg1));
    Mux mux2(.in1(op2),.in2(address),.sel(ALUSrc),.out(ALU_B));
    Mux mux3(.in1(ALU_out),.in2(Mem_out),.sel(MemToReg),.out(Write_reg_data1));
    shifter sh1(.in(address),.out(addressSh2));
    shifter #(28) sh2(.in({2'd0,instruction[25:0]}),.out(instShift2));

    Adder add2(.A(PC4),.B(addressSh2),.sum(jump_addr));
    Mux mux4(.in1(PC4),.in2(jump_addr),.sel(PCSrc),.out(PC4OrBeq));
    Mux mux5(.in1(PC4OrBeq),.in2({PC4[31:28],instShift2}),.sel(Jmp),.out(JAndOther));

    Mux mux6(.in1(JAndOther),.in2(op1),.sel(Jr),.out(PCin));
    Mux #(5)mux7(.in1(Write_reg1),.in2(5'd31),.sel(selR31),.out(Write_reg));

    Mux mux8(.in1(Write_reg_data1),.in2(PC4),.sel(Jal),.out(Write_reg_data));

    assign out=instruction;

endmodule