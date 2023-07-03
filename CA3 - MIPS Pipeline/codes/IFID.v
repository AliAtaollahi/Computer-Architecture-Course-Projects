`timescale 1ns/1ns
module IFID(clock, reset, load, flush, instruction, adder1, inst_out_, adder1_out_);
    input clock, reset, flush,load;  
    input [31:0] instruction, adder1;
    output reg [31:0] inst_out_, adder1_out_;
    always @(posedge clock)
    begin
        if (flush)begin 
            inst_out_ <= 32'b0; 
        end
        else if (reset)begin
            adder1_out_ <= 32'b0;
            inst_out_ <= 32'b0;
        end
        else begin
            if (load) begin
                adder1_out_ <= adder1; 
                inst_out_ <= instruction;
                   
            end
        end
    end
endmodule