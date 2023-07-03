`timescale 1ns/1ns
`include "ALU_CU.v"
`define IF 4'b0000
`define ID 4'b0001
`define LOAD1 4'b0010
`define LOAD2 4'b0011
`define JUMP 4'b0100
`define STORE 4'b0101
`define BRANCHZ 4'b0110
`define CTYPE1 4'b0111
`define CTYPE2 4'b1000
`define ADDI 4'b1001
`define SUBI 4'b1010
`define ANDI 4'b1011
`define ORI 4'b1100
`define WRITE 4'b1101

`timescale 1ns/1ns
module CU(clk,rst,opc,func,zero,mem_read,mem_write,PCld,IorD,IRWrite,writeRegSel,MemToReg,writeRegEn,PCSrc,ALUSrcA,ALUSrcB,ALU_control);
    input clk,rst;
    input [3:0]opc;
    input [8:0]func;
    input zero;
    output reg mem_read,mem_write;
    output PCld;
    output reg IorD,IRWrite;
    output writeRegSel;
    output reg MemToReg;
    output writeRegEn;
    output reg [1:0]PCSrc;
    output reg ALUSrcA;
    output reg [1:0]ALUSrcB;


    output[2:0]ALU_control;

    reg PCWrite,PCWriteCond,WriteCond,regDst,RegWrite;
    wire notnoop,ALUCoWr;
    reg [2:0]ALUop;

    reg[3:0]ps,ns;

    always@(ps)begin
		ns=`IF;
		case(ps)
			`IF: ns=`ID;
			`ID: begin
                case (opc)
                    4'b0000: ns=`LOAD1;
                    4'b0001: ns=`STORE;
                    4'B0010: ns=`JUMP;
                    4'b0100: ns=`BRANCHZ;
                    4'b1000: ns=`CTYPE1;
                    4'b1100: ns=`ADDI;
                    4'b1101: ns=`SUBI;
                    4'b1110: ns=`ANDI;
                    4'b1111: ns=`ORI;
                    default: ns=`LOAD1;
                endcase
            end
			`LOAD1: ns=`LOAD2;
            `LOAD2: ns=`IF;
            `STORE: ns=`IF;
            `JUMP: ns=`IF;
            `BRANCHZ: ns=`IF;
            `CTYPE1: ns=`CTYPE2;
            `CTYPE2: ns=`IF;
            `ADDI: ns=`WRITE;
            `SUBI: ns=`WRITE;
            `ANDI: ns=`WRITE;
            `ORI: ns=`WRITE;
            `WRITE: ns=`IF;
		endcase
	end

    ALU_CU alucu(.ALUop(ALUop),.func(func),.op(ALU_control),.notnoop(notnoop),.ALUCoWr(ALUCoWr));
    
    always@(ps)begin
		{mem_read,mem_write,IorD,IRWrite,MemToReg,PCSrc,ALUSrcA,ALUSrcB,PCWrite,PCWriteCond,WriteCond,regDst,RegWrite}=15'd0;
		case(ps)
			`IF: begin
                IorD=1'b0;
                mem_read=1'b1;
                ALUSrcA=1'b0;
                ALUSrcB=2'b01;
                ALUop=3'b000;
                PCSrc=2'b00;
                PCWrite=1'b1;
                IRWrite=1'b1;
            end
			`LOAD1: begin
                IorD=1'b1;
                mem_read=1'b1;
            end
            `LOAD2: begin
                regDst=1'b0;
                MemToReg=1'b1;
                RegWrite=1'b1;
            end
            `STORE: begin
                IorD=1'b1;
                mem_write=1'b1;
            end
            `JUMP: begin
                PCSrc=2'b01;
                PCWrite=1'b1;
            end
            `BRANCHZ: begin
                ALUop=3'b001;
                ALUSrcA=1'b1;
                ALUSrcB=2'b00;
                PCSrc=2'b10;
                PCWriteCond=1'b1;
            end
            `CTYPE1: begin
                ALUSrcA=1'b1;
                ALUSrcB=2'b00;
                ALUop=3'b010;
            end
            `CTYPE2: begin
                regDst=1'b1;
                MemToReg=1'b0;
                WriteCond=1'b1;
                RegWrite=1'b0;
                ALUop=3'b010;
            end
            `ADDI: begin
                ALUSrcA=1'b1;
                ALUSrcB=2'b10;
                ALUop=3'b000;
            end
            `SUBI: begin
                ALUSrcA=1'b1;
                ALUSrcB=2'b10;
                ALUop=3'b001;
            end
            `ANDI: begin
                ALUSrcA=1'b1;
                ALUSrcB=2'b10;
                ALUop=3'b011;
            end
            `ORI: begin
                ALUSrcA=1'b1;
                ALUSrcB=2'b10;
                ALUop=3'b100;
            end
            `WRITE: begin
                MemToReg=1'b0;
                RegWrite=1'b1;
                regDst=1'b0;
            end
		endcase
	end

    assign PCld=(PCWriteCond&zero)|PCWrite;
    assign writeRegEn=(WriteCond&notnoop)|RegWrite;
    assign writeRegSel=regDst&ALUCoWr;

    always @(posedge clk , posedge rst) begin
		if(rst) begin
			 #1 ps <= `IF;
		end else begin
			 #1 ps <= ns;
		end
	end

endmodule