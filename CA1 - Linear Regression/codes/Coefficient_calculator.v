module Coefficient_calculator(clk,rst,en,co,x_in,y_in,all_ready,mean_ready,b1,b0);
    input clk,rst,en,co;
    input [19:0]x_in,y_in;
    output all_ready,mean_ready;
    output [19:0]b1,b0;

    wire ldx,ldy,ldx_sum,ldy_sum,select1,ldx_mean,ldy_mean,ldssxx,ldssxy,ldb0,ldb1;

    Coefficient_calculator_DP dp(clk,rst,x_in,y_in,ldx,ldy,ldx_sum,ldy_sum,select1,ldx_mean,ldy_mean,ldssxx,ldssxy,ldb0,ldb1,b1,b0);
    Coefficient_calculator_CU cu(clk,rst,en,co,ldx,ldy,ldx_sum,ldy_sum,ldx_mean,select1,mean_ready,ldssxx,ldssxy,ldb1,ldb0,all_ready);
    
endmodule