`include "ALU_CU.v"
`define R_type 6'b000000
`define Addi 6'b001000
`define Slti 6'b001010
`define Lw 6'b100011
`define Sw 6'b101011
`define J 6'b000010
`define Jal 6'b000011
`define Jr 6'b000111
`define Beq 6'b000100
`timescale 1ns/1ns
module CU(opc,func,zero,mem_read,mem_write,RegWrite,RegDst,ALUSrc,MemToReg,PCSrc,Jmp,Jr,selR31,Jal,ALU_control);
    input [5:0]opc,func;
    input zero;
    output reg mem_read,mem_write,RegWrite,RegDst,ALUSrc,MemToReg;
    output PCSrc;
    output reg Jmp,Jr,selR31,Jal;
    output [2:0]ALU_control;

    reg branch;
    reg [1:0]ALUop;

    ALU_CU alucu(.ALUop(ALUop),.func(func),.op(ALU_control));
    always @(opc) begin
        {mem_read,mem_write,RegWrite,RegDst,ALUSrc,MemToReg,Jmp,Jr,selR31,Jal,ALUop}=13'd0;
        case (opc)
            `R_type: begin ALUop=2'b10;RegDst=1'b1;RegWrite=1'b1;ALUSrc=1'b0;mem_read=1'b0;///////////////////////////
                        mem_write=1'b0;MemToReg=1'b0;branch=1'b0;Jmp=1'b0;selR31=1'b0;Jr=1'b0;Jal=1'b0; end
            `Addi: begin ALUop=2'b00;RegDst=1'b0;RegWrite=1'b1;ALUSrc=1'b1;mem_read=1'b0;////////////////////////////
                        mem_write=1'b0;MemToReg=1'b0;branch=1'b0;Jmp=1'b0;selR31=1'b0;Jr=1'b0;Jal=1'b0; end
            `Slti: begin ALUop=2'b11;RegDst=1'b0;RegWrite=1'b1;ALUSrc=1'b1;mem_read=1'b0;////////////////////////////
                        mem_write=1'b0;MemToReg=1'b0;branch=1'b0;Jmp=1'b0;selR31=1'b0;Jr=1'b0;Jal=1'b0; end
            `Lw: begin ALUop=2'b00;RegDst=1'b0;RegWrite=1'b1;ALUSrc=1'b1;mem_read=1'b1;/////////////////////////////
                        mem_write=1'b0;MemToReg=1'b1;branch=1'b0;Jmp=1'b0;selR31=1'b0;Jr=1'b0;Jal=1'b0; end
            `Sw: begin ALUop=2'b00;RegWrite=1'b0;ALUSrc=1'b1;mem_read=1'b0;mem_write=1'b1;branch=1'b0;
                        Jmp=1'b0;Jr=1'b0;branch=1'b0; end///////////////////////////////////
            `J: begin RegWrite=1'b0;mem_read=1'b0;mem_write=1'b0;Jmp=1'b1;Jr=1'b0;branch=1'b0; end////////
            `Jal: begin RegWrite=1'b1;mem_read=1'b0;mem_write=1'b0;Jmp=1'b1;selR31=1'b1;Jr=1'b0;Jal=1'b1;branch=1'b0; end////////
            `Jr: begin Jr=1'b1;RegWrite=1'b0;mem_read=1'b0;mem_write=1'b0;branch=1'b0; end///////////////
            `Beq: begin ALUop=2'b01;RegWrite=1'b0;mem_read=1'b0;ALUSrc=1'b0;mem_write=1'b0;branch=1'b1;Jmp=1'b0;Jr=1'b0; end
        endcase

        
    end

    assign PCSrc = branch & zero;


endmodule