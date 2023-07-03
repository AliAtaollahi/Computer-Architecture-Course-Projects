module forward_u(IDEX_Rs, IDEX__Rt, EXmem__reg__write, EXmem__Rd, MEMWB_reg__write, MEMWB_Rd, forward_A, forward_B);
    input [4:0] IDEX_Rs, IDEX__Rt;
    input EXmem__reg__write, MEMWB_reg__write;
    input [4:0] EXmem__Rd, MEMWB_Rd;
    output reg [1:0] forward_A, forward_B;

    always @(IDEX_Rs, IDEX__Rt, EXmem__reg__write, EXmem__Rd, MEMWB_reg__write, MEMWB_Rd) begin
        forward_A <= 2'd0; forward_B <= 2'd0;
        if ((EXmem__reg__write == 1'b1)&&(EXmem__Rd != 5'd0)&&(IDEX_Rs == EXmem__Rd))
            forward_A <= 2'd2;
        else if ((MEMWB_reg__write == 1'b1)&&(IDEX_Rs == MEMWB_Rd)&&(MEMWB_Rd != 5'd0))
            forward_A <= 2'd1;
        if ((EXmem__reg__write == 1'b1) && (EXmem__Rd!= 5'd0) && (IDEX__Rt == EXmem__Rd))
            forward_B <= 2'd2;
        else if ((MEMWB_reg__write == 1'b1)&&( IDEX__Rt == MEMWB_Rd)&&(MEMWB_Rd != 5'd0))
            forward_B <= 2'd1;
    end
endmodule