`timescale 1ns/1ns
module ALU(A,B,control,zero,Y);
    input signed[31:0]A,B;
    input [2:0]control;
    output zero;
    output reg signed[31:0]Y;

    always @(A,B,control) begin
		#1 Y = 32'd0;
		case (control)
			3'd0: Y = A&B;
			3'd1: Y = A|B;
			3'd2: Y = A+B;
			3'd6: Y = A-B;
			3'd7: Y = (A<B)?32'd1:32'd0;
			default : Y = 32'd0;
		endcase
	end
    assign zero = ~|Y;

endmodule