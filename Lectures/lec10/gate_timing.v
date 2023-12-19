`timescale 1ns / 1ns  // define the time units

module timing_g(output logic y, input logic a, b, c, d );
    wire n1, n2;

    and #2  g1(n1, a, b);
    or #3   g2(n2, n1, c);
    and #2  g3(y, n2, d);
endmodule

module main;
    logic a,b,c,d, y; 

    task apply_test(input [3:0] test_vec);
        begin
            {a,b,c,d} = test_vec;
            $display("d: t=%04d a=%b b=%b c=%b d=%b y=%b",
                $time, a, b, c, d, y);
            #10; // delay 10 units (10ns in this case)
        end
    endtask

    timing_g dut(y, a, b, c, d);

    initial begin
        $dumpfile("gate_timing.vcd");
        $dumpvars(0, dut);
        // trigged on change of monitored variable
        $monitor("m: t=%04d a=%b b=%b c=%b d=%b n1=%b n2=%b y=%b",
            $time, a, b, c, d, dut.n1, dut.n2, y);
        $display("first path setup");
        apply_test( 4'b1101 );
        $display("first path change");
        apply_test( 4'b0101 );
        #10;
        $display("second path setup");
        apply_test( 4'b1101 );
        $display("second path change");
        apply_test( 4'b1100 );

        $finish; // terminate the simulation
    end
endmodule
