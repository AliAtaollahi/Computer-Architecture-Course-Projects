`timescale 1ns/1ns
module mux4to1_32bit(a, b, c, d, select, y);
    input [31:0] a, b, c, d;
    input [1:0] select;
    output [31:0] y;

    assign y = (select == 2'b00) ? a:(select == 2'b01) ? b:(select == 2'b10) ? c:d;
endmodule