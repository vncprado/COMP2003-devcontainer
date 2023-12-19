module main;
    state_t s;
    logic in, clk, reset;

    recognize dut( s, in, clk, reset);

    task automatic check_next( logic din, state_t expected );
        begin
            in = din;
            clk = 0; #5; clk = 1; #5;
            if ( s === expected )
                $display("in=%b s=%b matches", in, s );
            else
                $display( "in=%b s=%b does not match %b", in, s, expected);
        end
    endtask

    initial begin
        $dumpfile("recognize.vcd");
        $dumpvars(0, main);
        reset = 1; check_next( 0, S0 );
        reset = 0;
        check_next( 0, S0 );
        check_next( 1, S1 );
        check_next( 0, S0 );
        check_next( 1, S1 );
        $display("Another test");
        reset = 1; check_next( 0, S0 );
        reset = 0;
        check_next( 1, S1 );
        check_next( 1, S2 );
        check_next( 1, S2 );
        check_next( 0, S3 );
    end
endmodule
