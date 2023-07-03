
module mux3to1_32bit (a, b, c, select, y);
    input [31:0] a, b, c;
    input [1:0] select;
    output [31:0] y;
    assign y = (select == 2'b00) ? a:(select == 2'b01) ? b:c;
endmodule
