`include "data_mem.v"
`include "inst_mem.v"
`include "shl2_26bit.v"
`include "PC_component.v"
`include "Adder.v"
`include "mux4to1_32bit.v"
`include "IFID.v"
`include "shl2_32bit.v"
`include "sign_ext.v"
`include "reg__file.v"
`include "IDEX.v"
`include "mux2to1_32bit.v"
`include "mux3to1_5bit.v"
`include "mux3to1_32bit.v"
`include "EXmem.v"
`include "alu.v"
`include "MEMWB.v"
`include "comperator.v"
module dp (clock, reset,  reg__destination, mem__to_reg, alu_src, pc_src, alu__ctrl, reg__write, flush, mem__read, mem__write,
                 forward_A, forward_B, IFID_opcode_out_, IFID_func__out_, alu_zero, operands_eq, IDEX_mem__read__out_,
                 IDEX_Rt_out_, IFID__Rt, IFID__Rs, IDEX_Rs_out_, EXmem__reg__write_out_, EXmem__mux5_out_, MEMWB_reg__write_out_, MEMWB_mux5_out_);
    input clock, reset,alu_src, reg__write,mem__read,mem__write,flush; 
    input [1:0] reg__destination, pc_src,mem__to_reg,forward_A, forward_B;
    input  [2:0] alu__ctrl;
    output alu_zero,operands_eq,IDEX_mem__read__out_,EXmem__reg__write_out_, MEMWB_reg__write_out_;
    output [4:0] IDEX_Rt_out_, IFID__Rt, IFID__Rs, IDEX_Rs_out_,EXmem__mux5_out_, MEMWB_mux5_out_;
    output [5:0] IFID_opcode_out_ , IFID_func__out_;
    
    wire [31:0] mux2_out__,alu_result_,EXmem__adder1_out__,MEMWB__data_from_memory_out_,MEMWB_alu_result_out__,MEMWB_adder1_out_,mux3__out_, mux4__out_,IDEX__adder1_out_,mux6__out_,
                read_data2,shl2_32__out_,sign_ext_out_,adder2_out_,read_data1,IFID_inst_out_, IFID_adder1_out_,adder1_out_,mux1_out_,IDEX_read1_out_, IDEX_read2_out_, IDEX_sign_ext_out_;

    wire [27:0] shl2_26b_out_;
    wire EXmem__zero_out_,cout1,IDEX_alu_src_in,IDEX_reg__write_in,IDEX_mem__read_in,IDEX_mem__write_in,IDEX_reg__write_out_,IDEX_mem__write_out_,IDEX_alu_src_out_,cout2;
    wire [1:0] EXmem__mem__to_reg__out_,MEMWB_mem__to_reg__out_,IDEX_reg__destination_in,IDEX_mem__to_reg__in,IDEX_reg__destination_out_,IDEX_mem__to_reg__out_;
    wire [4:0] mux5_out__,IDEX_Rd_out__;
    wire [2:0] IDEX_alu_ctrl_in,IDEX_alu_ctrl_out_;
    wire [10:0] mux7_out_;
    wire [31:0]inst_addres, instruction, EXmem__alu_result__out_;
    wire [31:0] data_out_;
    wire EXmem__mem__write__out_, EXmem__mem__read_out_;
    wire [31:0]data_in,max, max_index;
    data_mem DM (EXmem__alu_result__out_, data_out_,  EXmem__mem__read_out_, EXmem__mem__write__out_, clock, data_in, max, max_index);
    inst_mem IM (inst_addres, instruction);
    shl2_26bit SHL2_26(IFID_inst_out_[25:0], shl2_26b_out_);
    PC_component PC(mux1_out_, reset, pc_load, clock, inst_addres);
    Adder ADDER_1(inst_addres , 32'd4, adder1_out_);
    mux4to1_32bit MUX1(adder1_out_, adder2_out_, {IFID_adder1_out_[31:28], shl2_26b_out_}, read_data1, pc_src, mux1_out_);
    IFID IFIDReg(clock, reset, IFID_Ld, flush, instruction, adder1_out_, IFID_inst_out_, IFID_adder1_out_);
    Adder ADDER_2(shl2_32__out_, IFID_adder1_out_, adder2_out_);
    shl2_32bit SHL2_32(sign_ext_out_, shl2_32__out_);
    sign_ext SGN_EXT(IFID_inst_out_[15:0], sign_ext_out_);
    reg__file RF(mux6__out_, IFID_inst_out_[25:21], IFID_inst_out_[20:16], MEMWB_mux5_out_, MEMWB_reg__write_out_,
     reset, clock, read_data1, read_data2);
     IDEX idex(clock, reset, IDEX_alu_ctrl_in, IDEX_alu_src_in, IDEX_reg__write_in, IDEX_reg__destination_in, IDEX_mem__read_in,
     IDEX_mem__write_in, IDEX_mem__to_reg__in, IDEX_alu_ctrl_out_, IDEX_alu_src_out_, IDEX_reg__write_out_,
      IDEX_reg__destination_out_, IDEX_mem__read__out_, IDEX_mem__write_out_, IDEX_mem__to_reg__out_,read_data1, read_data2, sign_ext_out_, IFID_inst_out_[20:16], IFID_inst_out_[15:11],
     IFID_inst_out_[25:21], IFID_adder1_out_, IDEX_read1_out_, IDEX_read2_out_, IDEX_sign_ext_out_, IDEX_Rt_out_, IDEX_Rd_out__, IDEX_Rs_out_, IDEX__adder1_out_);
    mux2to1_32bit MUX4(mux3__out_, IDEX_sign_ext_out_, IDEX_alu_src_out_, mux4__out_);
    mux3to1_5bit MUX5(IDEX_Rt_out_, IDEX_Rd_out__, 5'b11111, IDEX_reg__destination_out_, mux5_out__);
    mux3to1_32bit MUX2(IDEX_read1_out_, mux6__out_, EXmem__alu_result__out_, forward_A, mux2_out__);
    mux3to1_32bit MUX3(IDEX_read2_out_, mux6__out_, EXmem__alu_result__out_, forward_B, mux3__out_);
    EXmem exmem(clock, reset, IDEX__adder1_out_, alu_zero, alu_result_, mux3__out_, mux5_out__, 
      EXmem__adder1_out__, EXmem__zero_out_, EXmem__alu_result__out_, data_out_, EXmem__mux5_out_,
      IDEX_mem__write_out_, IDEX_mem__read__out_, IDEX_mem__to_reg__out_, IDEX_reg__write_out_,
      EXmem__mem__write__out_, EXmem__mem__read_out_, EXmem__mem__to_reg__out_, EXmem__reg__write_out_);
    alu ALU(mux2_out__, mux4__out_, IDEX_alu_ctrl_out_, alu_result_, alu_zero);
    mux3to1_32bit MUX6(MEMWB_alu_result_out__, MEMWB__data_from_memory_out_, MEMWB_adder1_out_, MEMWB_mem__to_reg__out_, mux6__out_);
    MEMWB memwb(clock, reset, EXmem__mem__to_reg__out_, EXmem__reg__write_out_, MEMWB_mem__to_reg__out_, MEMWB_reg__write_out_,
     data_in, EXmem__alu_result__out_, EXmem__mux5_out_, EXmem__adder1_out__,
      MEMWB__data_from_memory_out_, MEMWB_alu_result_out__, MEMWB_mux5_out_, MEMWB_adder1_out_);
    comperator comp(read_data1,read_data2,operands_eq);
    assign {IFID_Ld,pc_load} = (IDEX_mem__read__out_ && ((IDEX_Rt_out_ == IFID__Rs) || (IDEX_Rt_out_ == IFID__Rt))) ? 2'b00 : 2'b11;
    assign {IFID_opcode_out_,IFID_func__out_,IFID__Rt,IFID__Rs} = { IFID_inst_out_[31:26] , IFID_inst_out_[5:0] , IFID_inst_out_[20:16] , IFID_inst_out_[25:21] };
    assign mux7_out_ = (IDEX_mem__read__out_ && ((IDEX_Rt_out_ == IFID__Rs) || (IDEX_Rt_out_ == IFID__Rt))) ? 11'b0 : {alu__ctrl, alu_src, reg__write, reg__destination, mem__read, mem__write, mem__to_reg} ;
    assign {IDEX_alu_ctrl_in, IDEX_alu_src_in, IDEX_reg__write_in, IDEX_reg__destination_in, IDEX_mem__read_in, IDEX_mem__write_in, IDEX_mem__to_reg__in} = mux7_out_;
    
endmodule