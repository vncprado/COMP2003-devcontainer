`include "armish_dp.v"
`include "set_r3.v"

module main;
    reg16_t out;
    logic cn, cz, cc, cv;
    alu_ctl_t op;
    shift_amt_t sh;
    reg_sel_t d, n, m;
    logic dw, reset, clk;

    controller CTL( op, sh, d, n, m, dw, cn, cz, cc, cv, clk, reset);
    armish_datapath DP( out, cn, cz, cc, cv, op, sh, d, n, m, dw, clk, reset);

    `include "run_sim.v"

    initial begin
        run_sim(1);
    end

endmodule
