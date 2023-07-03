`timescale 1ns/1ns
module MEMWB (clock, reset, mem__to_reg___in, reg__write_in, mem__to_reg__out_, reg__write_out_,
 data_from_data_memory_in, alu_result_in, mux5_out__in, adder1_in, data_from_memory_out_, alu_result_out_, mux5_out__in_out_, adder1_out_   
);
    input clock, reset, reg__write_in;
    input [1:0] mem__to_reg___in;
    output reg [1:0] mem__to_reg__out_;
    output reg reg__write_out_;
    input [31:0] data_from_data_memory_in, alu_result_in, adder1_in;
    input [4:0] mux5_out__in;
    output reg [31:0] data_from_memory_out_, alu_result_out_ ,adder1_out_;
    output reg [4:0] mux5_out__in_out_;
    always @(posedge clock) begin
        if (reset)begin
            {mem__to_reg__out_, reg__write_out_} <= {2'b00, 1'b0};
            {data_from_memory_out_, alu_result_out_, mux5_out__in_out_, adder1_out_} <= {101'd0};
        end
        else begin
            {mem__to_reg__out_, reg__write_out_} <= {mem__to_reg___in, reg__write_in};
            {data_from_memory_out_, alu_result_out_, mux5_out__in_out_, adder1_out_} <= {data_from_data_memory_in, alu_result_in, mux5_out__in, adder1_in};
        end
    end
    
endmodule