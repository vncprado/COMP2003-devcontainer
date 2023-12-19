module behave_odd_even( output logic nx, input logic x, clk, reset );
    logic st; // store the state

    assign nx = st;
    always_ff @(posedge clk) begin
        if ( reset ) st <= 0;
        else st <= x ^ st;
    end
endmodule

module main;
    logic  nx, x, clk, reset;

    task automatic clk_in( logic in );
        x = in;
        clk = 0; # 5; clk = 1; # 5;
    endtask

    behave_odd_even dut( nx, x, clk, reset);

    initial
        $monitor( "t=%04d clk=%b x=%b nx=%b", $time, clk, x, nx );

    initial begin
        $dumpfile("odd_even_behave.vcd");
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
