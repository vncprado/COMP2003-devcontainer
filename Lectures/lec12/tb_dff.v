`timescale 1ns/1ns

// parameter delay = 2;
module main;
    logic q, qbar, d, clk;

    //d_latch_gate d_latch(q, qbar, d, clk);
    //d_latch_behavior test_d_latch(q, qbar, d, clk);
    dff test_d_ff(q, d, clk);

    initial begin
        $monitor("t=%04d q=%b d=%b clk=%b",
            $time, q, d, clk); 
    end 

    initial begin
    $dumpfile("dff.vcd");
    $dumpvars(0, main);
        d = 0; clk = 0; #5;
        d = 0; clk = 1; #5;
        d = 0; clk = 0; #5;
        d = 1; clk = 0; #5;
        d = 1; clk = 1; #5;
        d = 1; clk = 0; #5;
        d = 0; clk = 0; #5;
        d = 0; clk = 1; #5;
        d = 1; clk = 1; #5;
        d = 0; clk = 1; #5;
        $finish;
    end
endmodule
