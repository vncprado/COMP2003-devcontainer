module main;
    parameter N=3;
    logic [N-1:0] count;
    logic clk = 0; // initialize clk to 0
    logic reset;

    counter #(N) cnt( count, clk, reset );

    always #5 clk = ~clk; // repeat forever

    initial begin 
        $dumpfile("counter.vcd");
        $dumpvars(0, main);
        $monitor("%04d count=%b clk=%b",$time, count, clk);
        reset = 1;
        #7;
        reset = 0;
        #100 $finish;
    end
endmodule
