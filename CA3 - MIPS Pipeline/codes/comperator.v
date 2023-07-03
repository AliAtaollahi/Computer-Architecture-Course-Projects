module comperator (in1, in2, eq);
    input [31:0]in1,in2;
    output eq;
    assign eq = (in1==in2);
    
endmodule