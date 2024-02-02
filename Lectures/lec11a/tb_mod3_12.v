`timescale 1ns / 1ns


module main;
    logic [3:0] v;
    logic y, expected;
    integer all_inputs, i; // 32 bits by default

    // connect module to be tested
    mod3_12 dut( y, v);
    assign v = all_inputs[3:0]; // bit by bit assignment
    // a is bit 1, b is bit 0

    initial begin
        i = 0;
        repeat ( 16 ) begin
            all_inputs = i;
            #10; // delay 10 units (10 ns in this case)
            expected = v % 3 != 0;
            $display("t=%03d  v=%04b y=%b expected=%b", $time,v, y,expected);
            // check result
            if ( expected != y ) begin
                $display("expected does not match");
            end
            // the inputs to testing are changed here
            i = i + 1;
        end
        $finish;
    end
endmodule
