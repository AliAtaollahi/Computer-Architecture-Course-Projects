`timescale 1ns/1ns
module inst_mem(addr,inst);
    input [31:0]addr;
    output reg[31:0]inst;
    reg [7:0] mem [((1<<15)-1):0];
    initial begin
        $readmemb("inst_mem.mem",mem);
    end
    
    assign inst={mem[addr+3], mem[addr+2], mem[addr+1], mem[addr]};
endmodule