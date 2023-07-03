`timescale 1ns/1ns// changed
module Reg_file(clk,RegWrite,read_reg1,read_reg2,write_reg,write_data,read_data1,read_data2);
    input clk,RegWrite;
    input [2:0]read_reg1,read_reg2,write_reg;// 3 bit
    input [15:0]write_data;// 15 bit
    output reg [15:0]read_data1,read_data2;

    reg [15:0] regs [0:7];
    always @(posedge clk) begin
        if(RegWrite)begin
            regs[write_reg]=write_data;
        end
    end
    always @(read_reg1,read_reg2,regs[read_reg1],regs[read_reg2])begin
         read_data1=regs[read_reg1];
        read_data2=regs[read_reg2];
    end
    assign regs[0]=16'd0;
endmodule