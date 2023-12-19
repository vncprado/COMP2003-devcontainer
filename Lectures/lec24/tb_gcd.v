`include "armish_dp.v"
`include "gcd.v"

module main;
    reg16_t out;
    logic cn, cz, cc, cv;
    alu_ctl_t op;
    shift_amt_t sh;
    reg_sel_t d, n, m;
    logic dw, done, reset, clk;

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

    task gcd_test( input reg16_t a, b, integer max_cycles );

        $display( "testing gcd(%0d,%0d)", a, b );
        reset = 1;
        clock_cycle;
        reset = 0;
        DP.rf.R[3] = a;  // a
        DP.rf.R[4] = b;  // b
        display_state;
        while ( max_cycles > 0 && !done ) begin
            clock_cycle;
            display_state;
            $display( "R[3] = %0d R[4] = %0d", DP.rf.R[3], DP.rf.R[4] );
            max_cycles = max_cycles - 1;
        end
        if ( !done ) begin
            $display("The simulation did not finish correctly");
        end
    endtask

    initial begin
        gcd_test( 6, 18, 15 ); // maximum cycles is 15
        gcd_test( 4, 6, 15 ); // maximum cycles is 15
        $finish;
    end
endmodule
