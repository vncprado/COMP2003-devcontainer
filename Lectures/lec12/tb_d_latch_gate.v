`timescale 1ns/1ns
parameter delay = 2;
module main;
    logic q, qbar, d, clk;

    //d_latch_gate d_latch(q, qbar, d, clk);
    d_latch_gate dut(.q(q), .qbar(), .d(d), .clk(clk));

    initial begin
        $monitor("t=%04d q=%b qbar=%b d=%b clk=%b",
            $time, q, qbar, d, clk); 
    end 

    initial begin
        $dumpfile("d_latch_gate.vcd");
        $dumpvars(0, main);
        d = 0; clk = 0; #delay;
        d = 0; clk = 1; #delay;
        d = 1; clk = 1; #delay;
        d = 1; clk = 1; #delay;
        d = 0; clk = 1; #delay;
        d = 1; clk = 1; #delay;
        d = 0; clk = 1; #delay;
        d = 0; clk = 0; #delay;
        d = 1; clk = 0; #delay;
        d = 0; clk = 0; #delay;
        $finish;
    end
endmodule
