`timescale 1ns/1ns
module reg__file (write_data, read_reg1, read_reg2, write_reg, RegWrite, reset, clock, rd_data1, rd_data2);
    input [31:0] write_data;
    input [4:0] read_reg1, read_reg2, write_reg;
    input RegWrite, reset, clock;
    output [31:0] rd_data1, rd_data2;
    
    reg [31:0] regs [0:31];
    integer i;
    always @(posedge clock)begin
        if (reset == 1'b1)begin
            for (i = 0; i<32 ; i = i+1)
                regs[i] <= 32'd0;
        end
        else if (RegWrite == 1'b1)begin
                regs[write_reg] <= write_data;
        end
    end
    assign rd_data1 = regs[read_reg1];
    assign rd_data2 = regs[read_reg2];
endmodule
