module Error_calculator(clk,rst,x_in,y_in,b1,b0,counter_out,e_reg_out,en_err,co,err_ready);
    input clk,rst,en_err,co;
    input [19:0] b1,b0,x_in,y_in;
    output err_ready,
    output [19:0] e_reg_out;
    output [7:0] counter_out;
    input co;
    wire ldx,ldy,e_write,e_read;

    wire init_cn,count_en,x_write,y_write,x_read,y_read;
    Error_calculator_DP err_dp(clk,rst,x_in,y_in,ldx,ldy,b1,b0,e_write,e_read,counter_out,e_reg_out);
    Error_calculator_CU err_cu(clk,rst,ldx,ldy,e_write,e_read,en_err,co,err_ready);
endmodule