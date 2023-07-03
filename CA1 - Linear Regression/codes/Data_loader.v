module Data_loader(start,en_coe,en_err,clk,rst,data_in,x_out,y_out,counter_out,all_ready,mean_ready,co);
    input start,en_coe,en_err,clk,rst;
    input [39:0]data_in;
    output [19:0]x_out,y_out;
    output [7:0] counter_out;
    input all_ready,mean_ready;
    output co;

    wire init_cn,count_en,x_write,y_write,x_read,y_read;
    Data_loader_DP dp(init_cn,count_en,co,counter_out,data_in,rst,clk,x_write,y_write,x_read,y_read,x_out,y_out);
    Data_loader_CU cu(clk,rst,start,all_ready,mean_ready,co,x_write,y_write,x_read,y_read,en_coe,en_err,init_cn,count_en);
endmodule