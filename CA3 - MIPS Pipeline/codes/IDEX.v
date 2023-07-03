module IDEX (clock, reset, alu_op_in, alu_src_in, reg__write_in, reg__destination_in, mem__read_in, mem__write_in, mem__to_reg___in, alu_operation, alu_src, reg__write, reg__destination, mem__read, mem__write, mem__to_reg,
 read_data1, read_data2, sign_ext, Rt, Rd, Rs, adder1, read_data1_out_, read_data2_out_, sign_ext_out_, Rt_out_, Rd_out_, Rs_out_, adder1_out_);
    input clock, reset,alu_src_in,reg__write_in,mem__read_in, mem__write_in;
    input [1:0] reg__destination_in;
    input [2:0] alu_op_in;
    input [1:0] mem__to_reg___in;
    output reg alu_src,reg__write,mem__read, mem__write;
    output reg [1:0] reg__destination, mem__to_reg;
    output reg [2:0] alu_operation;
    input [31:0] read_data1, read_data2, sign_ext;
    input [4:0] Rt, Rd, Rs;
    input [31:0] adder1;
    output reg [31:0] read_data1_out_, read_data2_out_, sign_ext_out_;
    output reg [4:0] Rt_out_, Rd_out_, Rs_out_;
    output reg [31:0] adder1_out_;
    always @(posedge clock)
    begin
        if (reset) begin
            {alu_operation, alu_src, reg__write, reg__destination, mem__read, mem__write, mem__to_reg} <= {11'd0};
            {read_data1_out_, read_data2_out_, sign_ext_out_, adder1_out_} <= {128'b0};
            {Rt_out_, Rd_out_, Rs_out_} <= {15'b0};
        end
        else begin
            {alu_operation, alu_src, reg__write, reg__destination, mem__read, mem__write, mem__to_reg} <= {alu_op_in, alu_src_in, reg__write_in, reg__destination_in, mem__read_in, mem__write_in, mem__to_reg___in};
            {read_data1_out_, read_data2_out_, sign_ext_out_, adder1_out_} <= {read_data1, read_data2, sign_ext, adder1};
            {Rt_out_, Rd_out_, Rs_out_} <= {Rt, Rd, Rs};
        end
    end 
endmodule