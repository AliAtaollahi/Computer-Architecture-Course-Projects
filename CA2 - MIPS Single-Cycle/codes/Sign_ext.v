`timescale 1ns/1ns
module Sign_ext(in,out);
    input [15:0]in;
    output [31:0]out;
    assign out={{16{in[15]}},in};

endmodule