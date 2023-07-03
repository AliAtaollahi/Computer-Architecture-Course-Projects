`timescale 1ns/1ns
module Reg_file(clk,RegWrite,read_reg1,read_reg2,write_reg,write_data,read_data1,read_data2);
    input clk,RegWrite;
    input [4:0]read_reg1,read_reg2,write_reg;
    input [31:0]write_data;
    output reg [31:0]read_data1,read_data2;

    reg [31:0] regs [0:31];
    always @(posedge clk) begin
        if(RegWrite)begin
            regs[write_reg]=write_data;
        end
    end
    always @(read_reg1,read_reg2,regs[read_reg1],regs[read_reg2])begin
         read_data1=regs[read_reg1];
        read_data2=regs[read_reg2];
    end
    assign regs[0]=32'd0;
    //assign regs[3]=32'd3;
endmodule