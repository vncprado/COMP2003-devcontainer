`include "seq_gen.v"
`include "fsm_set_r0_r1.v"

module main;
    reg16_t seq_out;
    logic clk, reset;
    as_ctl_t as_ctl;
    shift_ctl_t shift_ctl;
    logic r1_ld, r0_ld;

    task clock_cycle;
        clk = 0; #5;
        clk = 1; #5;
    endtask

    task automatic display_state(string msg);
        $display("%6s state=%d R0=%4x R1=%4x as=%b sh=%b r0_ld=%b r1_ld=%b reset=%b",
            msg, CTL.st, DP.r0_v, DP.r1_v, as_ctl, shift_ctl, r0_ld, r1_ld, reset);
    endtask

    seq_gen_dp DP(seq_out, clk, reset, as_ctl, shift_ctl, r1_ld, r0_ld);
    controller CTL( as_ctl, shift_ctl, r1_ld, r0_ld, clk, reset);

    initial begin
        reset = 1;
        clock_cycle;
        display_state("reset");
        reset = 0;
        clock_cycle;
        display_state("R0<=1");
        clock_cycle;
        display_state("R1<=R0");
        clock_cycle;
        display_state("IDLE");
        clock_cycle;
        display_state("IDLE");
        $finish;
    end

endmodule
