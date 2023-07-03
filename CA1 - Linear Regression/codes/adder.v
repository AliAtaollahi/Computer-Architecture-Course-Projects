module adder #(parameter N)(a,b,ci,out,co);
	input [N-1:0]a,b;
	input ci;
	output [N-1:0]out;
	output co;

	assign {co,out}=a+b+ci;

endmodule