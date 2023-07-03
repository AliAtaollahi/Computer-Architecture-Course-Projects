`timescale 1ns/1ns
module Data_mem(clk,mem_read,mem_write,addr,write_data,read_data);
    input clk,mem_read,mem_write;
    input [31:0]addr;
    input [31:0]write_data;
    output [31:0]read_data;
    initial begin
        $readmemb("Data_mem.mem",mem);
    end
    reg [7:0] mem [((1<<20)-1):0];
    assign #1 read_data=(mem_read)?{mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]}:read_data;
    always @(posedge clk) begin
        if(mem_write)begin
            {mem[addr+3], mem[addr+2], mem[addr+1], mem[addr]}=write_data;
        end
    end
endmodule