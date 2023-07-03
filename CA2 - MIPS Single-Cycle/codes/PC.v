`timescale 1ns/1ns
module PC (clk,rst,in,out);
    input clk,rst;
    input [31:0]in;
    output reg [31:0]out;

    always @(posedge clk, posedge rst) begin
        if(rst==1'b1)begin
            out=32'd0;
        end
        else begin
             out=in;
        end
    end
endmodule