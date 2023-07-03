`timescale 1ns/1ns
`include "pipeline.v"
module pipeline_test();
    reg clock=1'b0;
    reg reset=1'b1;
    pipeline CPU(clock, reset);
    always begin #16 clock = ~clock; end    
    initial
    begin
        #40 reset =1'b0;
        #40000 $stop;
    end
endmodule