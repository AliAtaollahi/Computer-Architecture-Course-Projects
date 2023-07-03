`timescale 1ns/1ns
module Adder (A,B,sum);
    input signed [31:0]A,B;
    output signed [31:0]sum;
    assign #1 sum=A+B;
endmodule