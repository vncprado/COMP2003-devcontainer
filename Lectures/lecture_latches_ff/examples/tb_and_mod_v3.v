`timescale 1ns / 1ns

module main;
    logic a,b;
    logic y;
    integer all_inputs, i; // 32 bits by default

    // connect module to be tested
    and_gate testing( y, a, b);
    // {} performs concatenation of the nets
    assign {a,b} = all_inputs[1:0]; // bit by bit assignment
    // a is bit 1, b is bit 0

    // apply all possible test inputs (2**n)
    initial begin
	$dumpfile("test.vcd");
	$dumpvars(0, main);
        i = 0;
        repeat ( 10 ) begin
            all_inputs = i;
            #10; // delay 10 units (10 ns in this case)
            $display("all_inputs=%b", all_inputs[4:0]);
            $display("t=%03d a=%b b=%b y=%b", $time,a, b, y);
            // the inputs to testing are changed here
            i = i + 1;
        end
        $finish;
    end
endmodule
