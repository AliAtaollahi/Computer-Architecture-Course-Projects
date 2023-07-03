module Error_calculator_DP(clk,rst,x_in,y_in,ldx,ldy,b1,b0,e_write,e_read,counter_out,e_reg_out);
    input clk,rst,x_in,y_in,ldx,ldy,e_write,e_read;
    input [19:0] b1,b0;
    input [7:0] counter_out;
    output reg [19:0] e_reg_out;

    wire [19:0] xreg,yreg;

    wire [39:0] mult1out;

    wire [27:0] adder1out;

    wire[19:0] sub_out;

    register #(20)x_reg(.clk(clk),.rst(rst),.ld(ldx),.pi(x_in),.po(xreg));
    register #(20)y_reg(.clk(clk),.rst(rst),.ld(ldy),.pi(y_in),.po(yreg));

    multiplier #(20) mult1(.a(xreg),.b(b1),.out(mult1out));

    adder #(28) add1(.a({8'd0,b0}),.b({8'd0,mult1out[29:10]}),.ci(1'b0),.out(adder1out));

    subtractor #(20) sub1(.a(adder1out),.b(yreg),.out(sub_out));

    memory e_mem (.data_in(sub_out),.clk(clk),.data_out(e_reg_out),.addr(counter_out),.write(e_write),.read(e_read));

endmodule