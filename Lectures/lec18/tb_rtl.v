`include "seq_gen.v"

module main;
    reg16_t out;
    logic clk, reset;
    as_ctl_t as_ctl;
    shift_ctl_t shift_ctl;
    logic r1_ld, r0_ld;

    seq_gen_dp dut(out, clk, reset, as_ctl, shift_ctl, r1_ld, r0_ld);

    task automatic display_state(string msg);
        $display("%10s t=%03d R0=%4x R1=%4x as_ctl=%b shift_ctl=%b r1_ld=%b r0_ld=%b reset=%b out=%b",
            msg, $time, dut.r0_v, dut.r1_v, as_ctl, shift_ctl, r1_ld, r0_ld, reset, out);
    endtask

    task clock_cycle;
        clk = 0; #5;
        clk = 1; #5;
    endtask

    task automatic ctrl(as_ctl_t as, shift_ctl_t sh, logic r1, logic r0, logic r );
        reset <= r; as_ctl <= as; shift_ctl <= sh; r1_ld <= r1; r0_ld <= r0;
    endtask

    task automatic reset_reg;
        reset = 1;
        clock_cycle;
        reset = 0;
    endtask

    initial begin
        ctrl( AS_A, SH_ONE, 0, 0, 1); // reset
        clock_cycle;
        display_state("reset");
        ctrl( AS_A, SH_ONE, 0, 1, 0); // r0 <= 1
        clock_cycle;
        display_state("r0 <= 1");
        ctrl( AS_A, SH_ONE, 1, 0, 0); // R1 <= R0
        clock_cycle;
        display_state("R1 <= R0");
        $finish;
    end

endmodule
