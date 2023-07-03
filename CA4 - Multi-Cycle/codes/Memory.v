`timescale 1ns/1ns//changed
module Memory(clk,mem_read,mem_write,addr,write_data,read_data);
    input clk,mem_read,mem_write;
    input [11:0]addr;//12 bit
    input [15:0]write_data;//16 bit
    output [15:0]read_data;//16 bit
    initial begin
        $readmemb("memory.mem",mem);
    end
    reg [15:0] mem [((1<<12)-1):0];
    assign #1 read_data=(mem_read)?mem[addr]:read_data;
    always @(posedge clk) begin
        if(mem_write)begin
            mem[addr]=write_data;
        end
    end
endmodule