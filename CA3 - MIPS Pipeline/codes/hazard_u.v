module hazard_u (IDEX__Rt, IFID__Rs, IFID__Rt, IDEX__mem__read, pc__load, IFID__Ld, hazard);
    input [4:0] IDEX__Rt, IFID__Rs, IFID__Rt;
    input IDEX__mem__read;
    output reg pc__load, IFID__Ld, hazard;
    assign {IFID_Ld,pc_load} = (IDEX__mem__read && ((IDEX__Rt == IFID__Rs) || (IDEX__Rt == IFID__Rt))) ? 2'b00 : 2'b11;
    assign hazard = (IDEX__mem__read && ((IDEX__Rt == IFID__Rs) || (IDEX__Rt== IFID__Rt))) ? 1'b0:1'b1;
    
endmodule