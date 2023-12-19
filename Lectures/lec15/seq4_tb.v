module main;
    logic [1:0] s;
    logic clk, reset;

    seq4 dut( s, clk, reset);

    task automatic check_next( logic [1:0] expected );
        begin
            clk = 0; #5; clk = 1; #5;
            if ( s === expected )
                $display("s=%b matches", s );
            else
                $display( "s=%b does not match %b", s, expected);
        end
    endtask

    initial begin
        $dumpfile("seq4.vcd");
        $dumpvars(0, main);
        reset = 1; check_next( 0 );
        reset = 0; check_next( 1 );
        check_next( 3 );
        check_next( 2 );
        check_next( 0 );
    end
endmodule
