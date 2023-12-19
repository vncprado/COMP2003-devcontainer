`timescale 1ns/1ns

module main;

    logic q, not_q;

    not_bistable dut(q, not_q);

    initial begin
        #10 $display("time=%04d q=%b not_q=%b", $time, q, not_q);
    end
endmodule
