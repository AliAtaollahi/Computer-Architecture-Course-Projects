`timescale 1ns/1ns
module data_mem(addr, write_data,mem_read,mem_write,clk,read_data, max, max_index);
    input clk,mem_read,mem_write;
    input [31:0]addr;
    input [31:0]write_data;
    output [31:0]read_data;
    output [31:0] max_index, max;
    reg [7:0] mem [((1<<15)-1):0];
    initial begin
        $readmemb("Data_mem.mem",mem);
    end
    assign max = {mem[2003], mem[2002], mem[2001], mem[2000]};
    assign max_index = {mem[2007], mem[2006], mem[2005], mem[2004]};
    
    assign #1 read_data=(mem_read)?{mem[addr+3],mem[addr+2],mem[addr+1],mem[addr]}:read_data;
    always @(posedge clk) begin
        if(mem_write)begin
            {mem[addr+3], mem[addr+2], mem[addr+1], mem[addr]}=write_data;
        end
    end
endmodule