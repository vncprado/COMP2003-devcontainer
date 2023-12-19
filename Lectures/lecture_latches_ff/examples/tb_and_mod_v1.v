`timescale 1ns / 1ns  // define the time units

module main; // main has no outside connections
    logic a,b, y; // used to connect components

    // instantiate and connect module to be tested
    // this statement is declarative
    and_gate testing( y, a, b);

    // initial blocks are executed at the start of simulation
    initial begin
	$dumpfile("test.vcd");
	$dumpvars(0, main);
        a = 0; b = 0;
        #5; // delay 10 units (10ns in this case)
        // $display is a task used to display current state
        // $time is the current simulation time
        $display("t=%04d a=%b b=%b y=%b", $time, a, b, y);
        // %04d display $time with 4 decimal digits 
        // the leading 0 means that leading zeros are displayed
        // %b display binary values, 0 or 1

        a = 0; b = 1; // change a and b at time 10
        #5; // delay 5ns 
        // time is now 15ns
        $display("t=%04d a=%b b=%b y=%b", $time, a, b, y);

        a = 1; b = 0;
        // delay can appear at the start 
        #3 $display("t=%04d a=%b b=%b y=%b", $time, a, b, y);

        a = 1; b = 1; // a = 1 is not required
        #6 $display("t=%04d a=%b b=%b y=%b", $time, a, b, y);

        $finish; // terminate the simulation
    end
endmodule
