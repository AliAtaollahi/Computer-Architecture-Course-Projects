`timescale 1ns/1ns
module EXmem (clock, reset, adder1, zero, alu_result, mux3_out_, mux5_out_, adder1_out_, zero_out_, alu_result_out_, mux3_out__out_, mux5_out__out_,
        mem__write_in, mem__read_in, mem__to_reg___in, reg__write_in, mem__write, mem__read, mem__to_reg, reg__write);
    input clock, reset,zero;
    input [31:0] adder1, alu_result, mux3_out_;
    input [4:0] mux5_out_;
    output reg [31:0] adder1_out_,alu_result_out_, mux3_out__out_;
    output reg [4:0] mux5_out__out_;
    output reg zero_out_;
    input reg__write_in,mem__read_in, mem__write_in;
    input [1:0] mem__to_reg___in;
    output reg reg__write, mem__read, mem__write;
    output reg [1:0] mem__to_reg;
    always @(posedge clock) begin
        if (reset)begin
            {adder1_out_, zero_out_, alu_result_out_, mux3_out__out_, mux5_out__out_} <= {102'd0};
            {mem__write, mem__read, mem__to_reg, reg__write} <= {5'd0};
        end
        else begin
            {adder1_out_, zero_out_, alu_result_out_, mux3_out__out_, mux5_out__out_} <= {adder1, zero, alu_result, mux3_out_, mux5_out_};
            {mem__write, mem__read, mem__to_reg, reg__write} <= {mem__write_in, mem__read_in, mem__to_reg___in, reg__write_in};
        end
    end

    
endmodule