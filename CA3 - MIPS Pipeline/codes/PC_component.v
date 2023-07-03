`timescale 1ns/1ns
module PC_component (in, rst, ld, clk, out);
    input clk,rst,ld;
    input [31:0]in;
    output reg [31:0]out;

    always @(posedge clk, posedge rst) begin
        if(rst==1'b1)begin
            out=32'd0;
        end
        else if(ld==1'b1)begin
             out=in;
        end
    end
endmodule


