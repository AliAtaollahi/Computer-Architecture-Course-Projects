`define Init 3'b000
`define Start 3'b001
`define Load_data1 3'b010
`define Load_data2 3'b011
`define Wait 3'b100
module Error_calculator_CU(clk,rst,ldx,ldy,e_write,e_read,en_err,co,err_ready)
    input clk,rst,en_err,co;
    output reg ldx,ldy,e_write,e_read,err_ready;
    reg[2:0] ps,ns;
	case(ps)
        Init: ns=(en_err)?Start:Init;
        Start: ns=Load_data1;
        Load_data1: ns= Load_data2;
        Load_data2: ns=(~co)?Load_data1:Wait;
        Wait:ns=Init;		
	endcase
    always@(ps,co,start)begin
		ns=Init;
        {ldx,ldy,e_write,e_read,err_ready}=5'd0;
		case(ps)
            Init: begin err_ready=1'b1; end
            Start: begin x_write=1'b1; y_write=1'b1; count_en=1'b1; end
            Load_data1: begin ldx=1'b1;ldy=1'b1; end
            Load_data2: begin  e_write=1'b1; end
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