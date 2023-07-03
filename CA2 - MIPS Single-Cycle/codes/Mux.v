`timescale 1ns/1ns
module Mux#(parameter N = 32)(sel,in1,in2,out);
    input sel;
    input [N-1:0]in1,in2;
    output [N-1:0]out;

    assign out=(sel==1'b0)?in1:in2;

endmodule