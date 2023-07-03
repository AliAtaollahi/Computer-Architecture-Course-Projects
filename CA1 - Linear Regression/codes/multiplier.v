module multiplier #(parameter N)(a,b,out);
	input signed [N-1:0]a,b;
	output signed [2*N-1:0]out;

	assign out=a*b;

endmodule