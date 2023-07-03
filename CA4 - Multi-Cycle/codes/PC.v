`timescale 1ns/1ns//changed
module PC (clk,rst,ld,in,out);
    input clk,rst,ld;
    input [11:0]in;//12 bit
    output reg [11:0]out;// 12 bit

    always @(posedge clk, posedge rst) begin
        if(rst==1'b1)begin
            out=12'd0;
        end
        else if(ld==1'b1)begin
             out=in;
        end
    end
endmodule