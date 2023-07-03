`timescale 1ns/1ns
module mux2to1_32bit (a, b,  select,  y);
    input [31:0] a, b;
    input select;
    output [31:0] y;
    assign y = (select == 1'b1) ? b : a;
endmodule
    
    
