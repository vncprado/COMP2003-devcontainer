module seq_gen_dp (
    output reg16_t out,
    input logic clk, reset,
    input as_ctl_t as_ctl,
    input shift_ctl_t shift_ctl,
    input logic r1_ld, r0_ld
);

    reg16_t alu_bus, sh_bus, r0_v, r1_v;

    shifter SH( .out(sh_bus), .in(r0_v), .ctl(shift_ctl) );
    ld_reg R1( .q(r1_v), .d(r0_v), .clk(clk), .reset(reset), .ld(r1_ld) );
    as_alu ALU( .out(alu_bus), .a(sh_bus), .b(r1_v), .ctl(as_ctl) );
    ld_reg R0( .q(r0_v), .d(alu_bus), .clk(clk), .reset(reset), .ld(r0_ld) );

    assign out = r0_v;
endmodule
