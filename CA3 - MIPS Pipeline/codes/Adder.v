module Adder (A,
                  B,
                  sum);
    input signed [31:0]A,B;
    output signed [31:0]sum;
    assign sum=A+B;
    
endmodule