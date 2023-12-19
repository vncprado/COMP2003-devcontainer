module main;
    logic [2:0] sh;
    logic sin, clk;

    task automatic shift_data_in( integer data, nbits );
        while ( nbits > 0 ) begin
            sin = data & 1'b1;
            data = data >> 1;
            clk = 0; #5; clk = 1; #5;
            nbits = nbits - 1;
        end
    endtask

    shift_reg dut( sh, sin, clk );

    initial begin 
        $dumpfile("shift_reg.vcd");
        $dumpvars(0, main);
        $monitor("%04d sh=%b sin=%b clk=%b",$time, sh, sin, clk);
        shift_data_in( 3'b000, 3 ); // shift in 0 0 0
        shift_data_in( 3'b100, 3 ); // shift in 0 0 1
        shift_data_in( 3'b011, 3 ); // shift in 1 1 0
        shift_data_in( 3'b010, 3 ); // shift in 0 1 1
        $finish;
    end
endmodule
