module Coefficient_calculator_DP(clk,rst,x_in,y_in,ldx,ldy,ldx_sum,ldy_sum,select1,ldx_mean,ldy_mean,ldssxx,ldssxy,ldb0,ldb1,b1,b0);
    input clk,rst;
    input [19:0]x_in,y_in;
    input ldx,ldy,ldx_sum,ldy_sum,select1,ldx_mean,ldy_mean,ldssxx,ldssxy,ldb0,ldb1;
    output [19:0]b1,b0;
    
    wire [19:0]xreg,yreg;
    wire [27:0]xsum,ysum;
    wire [27:0]sumxout,sumyout;
    wire [47:0]ssxx,ssxy,partialsum1,partialsum2;
    wire [19:0]divider1out,divider2out;
    wire[19:0]b1reg,b2reg,xisubmean,yisubmean;
    wire[39:0]multr1,multr2,multr3;

    register  #(20)x_reg(.clk(clk),.rst(rst),.ld(ldx),.pi(x_in),.po(xreg));
    register #(20)y_reg(.clk(clk),.rst(rst),.ld(ldy),.pi(y_in),.po(yreg));
    
    register #(28)x_sum_reg(.clk(clk),.rst(rst),.ld(ldx_sum),.pi(sumxout),.po(xsum));
    register #(28)y_sum_reg(.clk(clk),.rst(rst),.ld(ldy_sum),.pi(sumyout),.po(ysum));

    register #(20)x_mean_reg(.clk(clk),.rst(rst),.ld(ldx_mean),.pi(divider1out[19:0]),.po(xmean));
    register #(20)y_mean_reg(.clk(clk),.rst(rst),.ld(ldy_mean),.pi(divider1out[19:0]),.po(ymean));

    register #(20)b1_reg(.clk(clk),.rst(rst),.ld(ldb1),.pi(divider2out[29:10]),.po(b1reg));
    register #(20)b0_reg(.clk(clk),.rst(rst),.ld(ldb0),.pi(ymean_sub_b1_xmean),.po(b0reg));

    register #(48)ssxx_reg(.clk(clk),.rst(rst),.ld(ldssxx),.pi(partialsum1),.po(ssxx));
    register #(48)ssxy_reg(.clk(clk),.rst(rst),.ld(ldssxy),.pi(partialsum2),.po(ssxy));

    adder #(28)addx(.a({8'd0,xreg}),.b(xsum),.ci(1'b0),.out(sumxout));
    adder #(28)addy(.a({8'd0,yreg}),.b(ysum),.ci(1'b0),.out(sumyout));

    multiplexer #(28)mux(.a(xsum),b(ysum),.sel(select1),.out(xorysum));

    divider #(28) mean_div(.a(xorysum),.b(28'd150),.out(divider1out));

    subtractor #(20) subx(.a(xreg),.b(xmean),.out(xisubmean));
    subtractor #(20) suby(.a(yreg),.b(ymean),.out(yisubmean));

    multiplier #(20) mult1(.a(yisubmean),.b(xisubmean),.out(multr1));
    multiplier #(20) mult2(.a(xisubmean),.b(xisubmean),.out(multr2));

    adder #(48) addpartial1(.a({8'd0,multr1}),.b(ssxy),.out(partialsum1));
    adder #(48) addpartial2(.a({8'd0,multr2}),.b(ssxx),.out(partialsum2));

    divider #(48) divideforb1(.a(ssxy),.b(ssxx),.out(divider2out));

    multiplier #(20) mult3(.a(b1reg),.b(xmean),.out(multr3));

    subtractor #(20) sub_for_b0(.a(ymean),.b(multr3[29:10]),.out(ymean_sub_b1_xmean));

endmodule