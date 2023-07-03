module alu(A,B,control,Y,zero);
    input signed[31:0]A,B;
    input [2:0]control;
    
    output reg signed[31:0]Y;
    output zero;

    always @(A,B,control) begin
		Y = 32'd0;
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