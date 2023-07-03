`timescale 1ns/1ns
`include "dp.v"
`include "cu.v"
`include "hazard_u.v"
`include "forward_u.v"
module pipeline(clock, reset);
    input clock, reset;
    wire [1:0] reg__destination,mem__to_reg,pc_src,forward_A, forward_B;
    wire [2:0] alu__ctrl;
    wire [5:0] IFID_opcode_out_;
    wire [5:0] IFID_func__out_;
    wire [4:0] IDEX__Rt, IFID__Rt, IFID__Rs, IDEX_Rs,EXmem__Rd,MEMWB_Rd;
    wire EXmem__reg__write,MEMWB_reg__write,alu_src,reg__write,flush,mem__read,mem__write,zero_out_,operands_eq,IDEX_mem__read;
    wire hazard,IFID_Ld,pc_load;
    dp DP(clock, reset, reg__destination, mem__to_reg, alu_src, pc_src, alu__ctrl, reg__write, flush,mem__read, mem__write, forward_A,
    forward_B, IFID_opcode_out_, IFID_func__out_, zero_out_, operands_eq, IDEX_mem__read, IDEX__Rt, IFID__Rt, IFID__Rs, IDEX_Rs,
    EXmem__reg__write, EXmem__Rd, MEMWB_reg__write, MEMWB_Rd);
    cu CU(IFID_opcode_out_, IFID_func__out_, zero_out_, reg__destination, mem__to_reg, reg__write, alu_src, mem__read, mem__write, pc_src, alu__ctrl, flush, operands_eq );
    hazard_u HU(IDEX__Rt, IFID__Rs, IFID__Rt, IDEX_mem__read, pc_load, IFID_Ld, hazard);
    forward_u FU(IDEX_Rs, IDEX__Rt, EXmem__reg__write, EXmem__Rd, MEMWB_reg__write, MEMWB_Rd, forward_A, forward_B);
endmodule
