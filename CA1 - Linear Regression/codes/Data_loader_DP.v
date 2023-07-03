module Data_loader_DP(clk,rst,count_en,init_cn,x_write,y_write,x_read,y_read,data_in,counter_out,x_out,y_out,co);
    input clk,rst,count_en,init_cn;
    input x_write,y_write,x_read,y_read;
    input [39:0]data_in;
    output [7:0] counter_out;
    output [19:0]x_out,y_out;
    output co;

    wire [19:0]x_in=data[39:20],y_in=data[19:0];
    counter150 cntt(.clk(clk),.rst(rst),.init_cn(init_cn),.count_en(count_en),.co(co),.out(counter_out));
    memory x_mem (.data_in(x_in),.clk(clk),.data_out(x_out),.addr(counter_out),.write(x_write),.read(x_read));
    memory y_mem (.data_in(y_in),.clk(clk),.data_out(y_out),.addr(counter_out),.write(y_write),.read(y_read));

endmodule