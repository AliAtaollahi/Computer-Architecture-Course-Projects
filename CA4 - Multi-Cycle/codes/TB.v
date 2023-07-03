`include "processor.v"
`timescale 1ns/1ns
module TB ();
    reg clkk,rstt;
    wire[15:0]instt;
    processor UUT(.clk(clkk),.rst(rstt),.inst(instt));
    initial begin
        clkk=1'b0;
        #10 rstt=1'b1;
        #10 rstt=1'b0;
        repeat(10000) #10 clkk = ~clkk; 
    end



    
endmodule