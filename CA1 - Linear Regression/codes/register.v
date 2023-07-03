module register #(parameter N) (clk,rst,ld,pi,po);
	input clk,rst,ld;
	input[N-1:0]pi;
	output reg[N-1:0]po;

	always @(posedge clk , posedge rst) begin
		if(rst)
			po <= {N{1'b0}};
		else begin
			if(ld==1'b1) po<=pi;
		end
	end
	
endmodule