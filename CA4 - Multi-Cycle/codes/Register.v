module Register (clk,rst,ld,in,out);
    input clk,rst,ld;
    input [15:0]in;
    output reg [15:0]out;

    always @(posedge clk, posedge rst) begin
        if(rst==1'b1)begin
            out=16'd0;
        end
        else if(ld==1'b1)begin
             out=in;
        end
    end
    
endmodule