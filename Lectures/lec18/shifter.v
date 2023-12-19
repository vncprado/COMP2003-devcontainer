module shifter(
    output reg16_t out,
    input reg16_t in,
    input shift_ctl_t ctl
);

    always_comb begin
        case( ctl )
            SH_PASS: out = in;
            SH_LEFT: out = in << 1;
            SH_ONE: out = 1;
            SH_ONES: out = 16'hffff;
        endcase
    end
endmodule
