`timescale 1ns/1ns

module main;

    logic q, nq, s, r;

    sr_latch test_sr(q, nq, s, r);

    initial begin
        $dumpfile("sr_latch.vcd");
        $dumpvars(0, main);
        s = 0; r = 1; 
        #5 $display("time=%04d s=%b r=%b q=%b nq=%b", $time, s, r, q, nq);
        s = 0; r = 0; 
        #5 $display("time=%04d s=%b r=%b q=%b nq=%b", $time, s, r, q, nq);
        s = 1; r = 0; 
        #5 $display("time=%04d s=%b r=%b q=%b nq=%b", $time, s, r, q, nq);
        s = 0; r = 0; 
        #5 $display("time=%04d s=%b r=%b q=%b nq=%b", $time, s, r, q, nq);
        s = 1; r = 1; 
        #5 $display("time=%04d s=%b r=%b q=%b nq=%b", $time, s, r, q, nq);
        s = 1; r = 0; 
        #5 $display("time=%04d s=%b r=%b q=%b nq=%b", $time, s, r, q, nq);
        s = 0; r = 0; 
        #5 $display("time=%04d s=%b r=%b q=%b nq=%b", $time, s, r, q, nq);
    end
endmodule
