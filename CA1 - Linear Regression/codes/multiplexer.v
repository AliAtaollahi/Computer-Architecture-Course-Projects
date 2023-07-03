module multiplexer #(parameter N)(a,b,sel,out);
	input sel;
	input [N-1:0]a,b;
	output [N-1:0]out;

	assign out=(sel==1'b0)?a:b;

endmodule