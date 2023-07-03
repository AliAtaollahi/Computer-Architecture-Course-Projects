`timescale 1ns/1ns
module shifter#(parameter N = 32) (in,out);
    input [N-1:0]in;
    output [N-1:0]out;

    assign out = in << 2;
endmodule