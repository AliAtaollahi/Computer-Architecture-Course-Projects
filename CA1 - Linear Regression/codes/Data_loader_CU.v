`define Init 4'b0000
`define Start 4'b0001
`define Read_data 4'b0010
`define Reset_counter1 4'b0011
`define Load_init1 4'b0100
`define Load_data11 4'b0101
`define Load_data12 4'b0110
`define Wait 4'b0111
`define Reset_counter2 4'b1000
`define Load_init2 4'b1001
`define Load_data21 4'b1010
`define Load_data22 4'b1011

module Data_loader_CU(clk,rst,start,all_ready,mean_ready,co,x_write,y_write,x_read,y_read,en_coe,en_err,init_cn,count_en);
    input clk,rst,co,start,mean_ready,all_ready;
    output reg x_write,y_write,x_read,y_read,en_coe,en_err,init_cn,count_en;
    reg[3:0] ps,ns;
    always@(ps,co,start)begin
		ns=Init;
		case(ps)
            Init: ns=(start)?Start:Init;
            Start: ns=(~start)?Read_data:Start;
            Read_data: ns= (~co)?Read_data:Reset_counter1;
            Reset_counter1: ns=Load_init1;
            Load_init1:ns=Load_data11;
            Load_data11:ns=Load_data12;
            Load_data12: (~co)?Load_data11:Wait;
            Wait:(all_ready) ? Reset_counter2 : (mean_ready)? Reset_counter1 : Wait;
            Reset_counter2: Load_init2;
            Load_init2:Load_data21;
            Load_data21:Load_data22;
            Load_data22:(~co)?Load_data21:Init;			
		endcase
	end
    
    always@(ps,co,start)begin
		ns=Init;
        {x_write,y_write,x_read,y_read,en_coe,en_err,init_cn,count_en}=8'd0;
		case(ps)
            Start: begin init_cn=1'b1; x_write=1'b1; y_read=1'b1; end
            Read_data: begin x_write=1'b1; y_write=1'b1; count_en=1'b1; end
            Reset_counter1: begin init_cn=1'b1; end
            Load_init1: begin en_coe=1'b1; x_read=1'b1; y_read=1'b1; end
            Load_data11: begin en_coe=1'b1; count_en=1'b1; end
            Load_data12: begin en_coe=1'b1; x_read=1'b1; y_read=1'b1; end
            Wait: begin en_coe=1'b1; end
            Reset_counter2:begin init_cn=1'b1; end 
            Load_init2:begin en_err=1'b1; x_read=1'b1; y_read=1'b1;  end
            Load_data21: begin en_err=1'b1; count_en=1'b1; end
            Load_data22:begin en_err=1'b1; x_read=1'b1; y_read=1'b1; end
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