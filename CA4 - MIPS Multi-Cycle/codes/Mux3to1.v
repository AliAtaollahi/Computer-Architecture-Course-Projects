module Mux3to1 #(parameter N = 32)(sel,in1,in2,in3,out);
    input [1:0]sel;
    input [N-1:0]in1,in2,in3;
    output reg [N-1:0]out;
    always @(sel,in1,in2,in3) begin
        out={N{1'b0}};
        case (sel)
            2'd0 : out=in1;
            2'd1 : out=in2;
            2'd2 : out=in3;
            default: out={N{1'b0}};
        endcase
        
    end
    
endmodule