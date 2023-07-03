`timescale 1ns/1ns
module ALU(A,B,control,zero,Y);
    input signed[15:0]A,B;//16 bit
    input [2:0]control;//3bit
    output zero;
    output reg signed[15:0]Y;

    always @(A,B,control) begin
		#1 Y = 16'd0;
		case (control)
			3'd0: Y = A&B;
			3'd1: Y = A|B;
			3'd2: Y = A+B;
			3'd3: Y = A-B;
			3'd4: Y = ~B;
			3'd5: Y = A;
			3'd6: Y = B;
			default : Y = 16'd0;
		endcase
	end
    assign zero = ~|Y;

endmodule