module memory (data_in,clk,data_out,addr,write,read);
    input [7:0]addr;
    input reg [19:0]data_in;
    output reg [19:0]data_out;
    input clk,write,read;
    
    reg [19:0] mem [149:0];
    always @(posedge clk) begin
        if(write)
            mem[addr]=data_in;
        else if(read)
            data_out=mem[addr];
        
    end
endmodule