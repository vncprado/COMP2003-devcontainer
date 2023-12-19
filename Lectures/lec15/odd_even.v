module dff( output logic q, input logic d, clk, reset);
    always_ff @(posedge clk) begin
        q <= reset ? 0 : d;
    end
endmodule

module odd_even( output logic nx, input logic x, clk, reset );
    logic q;

    xor next( nx, q, x);
    dff st( q, nx,  clk, reset );
endmodule

module main;
    logic  nx, x, clk, reset;

    task automatic clk_in( logic in );
        x = in;
        clk = 0; # 5; clk = 1; # 5;
    endtask

    odd_even dut( nx, x, clk, reset);

    initial
        $monitor( "t=%04d clk=%b x=%b q=%b nx=%b", $time, clk, x, dut.q, nx );

    initial begin
        $dumpfile("odd_even.vcd");
        $dumpvars(0, main);
        reset = 1;
        clk_in( 0 );
        reset = 0;
        clk_in( 0 );
        clk_in( 1 );
        clk_in( 1 );
        clk_in( 0 );
        clk_in( 0 );
        clk_in( 1 );
        clk_in( 0 );
    end
endmodule
