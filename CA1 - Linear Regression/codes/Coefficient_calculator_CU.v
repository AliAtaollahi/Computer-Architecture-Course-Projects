`define Init 4'd0
`define Start 4'd1
`define Load_data1 4'd2
`define Calc_data1 4'd3
`define Calc_xmean 4'd4
`define Calc_ymean 4'd5
`define Ready_means 4'd6
`define Load_data2 4'd7
`define Calc_data2 4'd8
`define Calc_b1 4'd9
`define Calc_b0 4'd10

module Coefficient_calculator_CU(clk,rst,en,co,ldx,ldy,ldx_sum,ldy_sum,ldx_mean,select1,mean_ready,ldssxx,ldssxy,ldb1,ldb0,all_ready);
    input clk,rst,en,co;
    output ldx,ldy,ldx_sum,ldy_sum,ldx_mean,select1,mean_ready,ldssxx,ldssxy,ldb1,ldb0,all_ready;

    reg [3:0]ps,ns;
    always@(ps,co,start)begin
		ns=Init;
		case(ps)
			Init: ns=(en)?Start:Init;
			Start: ns=Load_data1;
			Load_data1: ns=Calc_data1;
			Calc_data1: ns=(co)?Calc_xmean:Load_data1;
			Calc_xmean: ns=Calc_ymean;
			Calc_ymean: ns=Ready_means;
			Ready_means: ns=Load_data2;
            Load_data2: ns=Calc_data2;
            Calc_data2: ns=(co)?Calc_b1:Load_data2;
            Calc_b1: ns=Calc_b0;
            Calc_b0: ns=Init;
			
		endcase
	end

    always@(ps,co,start)begin
		{ldx,ldy,ldx_sum,ldy_sum,ldx_mean,select1,mean_ready,ldssxx,ldssxy,ldb1,ldb0,all_ready}=12'd0;
		case(ps)
			Init:begin
				all_ready=1'b1;
			end
			Load_data1:begin
				ldx=1'b1;
                ldy=1'b1;
			end
			Calc_data1:begin
				ldx_sum=1'b1;
				ldy_sum=1'b1;
			end
			Calc_xmean:begin
				ldx_mean=1'b1;
				select1=1'b0;
			end
			Calc_ymean:begin
				ldy_mean=1'b1;
				select1=1'b1;
			end
			Ready_means:begin
				mean_ready=1'b1;
			end
            Load_data2:begin
                ldx=1'b1;
                ldy=1'b1;
            end
            Calc_data2:begin
                ldssxx=1'b1;
                ldssxy=1'b1;
            end
            Calc_b1:begin
                ldb1=1'b1;
            end
            Calc_b0:begin
                ldb0:1'b1;
            end

		endcase
	end

    always @(posedge clk , posedge rst) begin
		if(rst) begin
			ps <= Init;
		end else begin
			ps <= ns;
		end
	end

endmodule