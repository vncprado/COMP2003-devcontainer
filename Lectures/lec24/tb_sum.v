`include "armish_dp.v"
`include "sum.v"

module main;
    reg16_t out;
    logic cn, cz, cc, cv;
    alu_ctl_t op;
    shift_amt_t sh;
    reg_sel_t d, n, m;
    logic dw, done, reset, clk;
    integer max_cycles = 16; // maximum allowed

    controller CTL(op, sh, d, n, m, dw, done, cn, cz, cc, cv, clk, reset);
    armish_datapath DP( out, cn, cz, cc, cv, op, sh, d, n, m, dw, clk, reset);

    task clock_cycle;
        clk = 0; #5; clk = 1; #5;
    endtask

    task display_state;
        $display("T=%04d st=S%d out=%x op=%5s sh=%3d NZCV=%4b Rn=%x Rm=%x sh_out=%x",
            $time, CTL.st, out, op_str(op), sh,
            {cn, cz, cc, cv}, DP.Rn, DP.Rm, DP.sh_out);
    endtask

    initial begin
        reset = 1;
        clock_cycle;
        reset = 0;
        DP.rf.R[2] = 0;  // result = 0
        DP.rf.R[1] = 1;  // constant 1
        DP.rf.R[0] = 4;  // N
        display_state;
        while ( max_cycles > 0 && !done ) begin
            clock_cycle;
            display_state;
            $display( "R[0] = %0d R[2] = %0d", DP.rf.R[0], DP.rf.R[2] );
            max_cycles = max_cycles - 1;
        end
        if ( !done ) begin
            $display("The simulation did not finish correctly");
        end
        $finish;
    end
endmodule
