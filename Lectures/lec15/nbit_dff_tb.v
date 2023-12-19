parameter SIZE = 8;

module main;
    logic [SIZE-1:0] q, d;
    logic clk,reset;

    nbit_dff #(8) dut( q, d, clk, reset );

    task automatic load_data( logic [SIZE-1:0] din );
        d = din;
        clk = 0; #5; clk = 1; #5;
    endtask

    task automatic reset_reg;
        reset = 1; clk = 0;
        #5; clk = 1; #5;
        reset = 0;
    endtask

    initial begin
        $monitor("t=%04d q=%b d=%b clk=%b reset=%b",
            $time, q, d, clk, reset); 
    end

    initial begin
        $dumpfile("nbit_dff.vcd");
        $dumpvars(0, main);
        d = 8'hff; 
        reset_reg; // test rest
        #10; 
        load_data( 8'b01010101 ); // try loading a value
        load_data( 8'b10101010 ); // try a different value
        reset = 1;
        load_data( 8'b10101010 );// loading a value with reset
        reset = 0;
        load_data( 8'hab ); 
        $finish;
    end
endmodule
