parameter delay = 2;

module main;
    logic q, d, clk;

    d_latch dut( q, d, clk );

    initial begin
        $monitor("t=%04d q=%b d=%b clk=%b",
            $time, q, d, clk); 
    end

    initial begin
        d = 0; clk = 1; #5;
        d = 1; clk = 1; #5;
        d = 0; clk = 1; #5;
        d = 1; clk = 1; #5;
        d = 0; clk = 1; #5;
        d = 1; clk = 1; #5;
        d = 0; clk = 1; #5;
        d = 1; clk = 1; #5;
        d = 1; clk = 1; #5;
        d = 0; clk = 1; #5;
        $finish;
    end
endmodule
