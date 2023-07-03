`timescale 1ns/1ns
module shl2_26bit (data__in, data_out_);
    input [25:0] data__in;
    output [27:0] data_out_;
    assign data_out_ = data__in<<2;
endmodule