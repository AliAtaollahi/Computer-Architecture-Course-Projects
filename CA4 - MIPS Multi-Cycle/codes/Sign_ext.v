`timescale 1ns/1ns// changed
module Sign_ext(in,out);
    input [11:0]in;// 12 bit
    output [15:0]out;// 16 bit
    assign out={{4{in[11]}},in};

endmodule