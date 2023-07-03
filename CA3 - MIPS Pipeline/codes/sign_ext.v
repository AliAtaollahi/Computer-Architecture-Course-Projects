`timescale 1ns/1ns
module sign_ext (data__in, data_out_);
    input [15:0] data__in;
    output [31:0] data_out_;
    assign data_out_ = {{16{data__in[15]}}, data__in};
endmodule