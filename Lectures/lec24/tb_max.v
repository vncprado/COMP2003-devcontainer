`include "armish_dp.v"
`include "max.v"

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

    task max_test( input reg16_t a, b, c, integer max_cycles );

        $display( "testing max(%0d,%0d,%0d)", a, b, c );
        reset = 1;
        clock_cycle;
        reset = 0;
        DP.rf.R[0] = a;  // a
        DP.rf.R[1] = b;  // b
        DP.rf.R[2] = c;  // c
        display_state;
        while ( max_cycles > 0 && !done ) begin
            clock_cycle;
            display_state;
            $display( "R[0]=%d R[1]=%0d R[2]=%0d",
                DP.rf.R[0], DP.rf.R[1], DP.rf.R[2] );
            max_cycles = max_cycles - 1;
        end
        if ( !done ) begin
            $display("The simulation did not finish correctly");
        end
    endtask

    initial begin
        max_test( 1, 2, 3, 15 ); // maximum cycles is 15
        max_test( 2, 1, 3, 15 ); // maximum cycles is 15
        max_test( 3, 1, 2, 15 ); // maximum cycles is 15
        $finish;
    end
endmodule
