module counter150(clk,rst,init_cn,count_en,co,out)
    input clk,rst,init_cn,count_en;
    output co;
    output reg[7:0] out;
    always @(posedge clk,posedge rst) begin
        if(rst)
            out=8'd106;
        else if(init_cn)
            out=8'd106;
        else if(count_en)
            out+=8'd1;
    end
    assign co=(count_en)?&out:1'b0;
endmodule