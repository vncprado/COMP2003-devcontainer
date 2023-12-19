/* declare module that adds 3 to three bits */
module three_plus_three(output logic x, y, z,
			input logic a, b, c);
	assign x = a & ~b & ~c | ~a & c | ~a & b;
	assign y = ~b & ~c | b & c;
	assign z = ~c;
endmodule

`timescale 1ns / 1ns  // define the time units
module main;
	logic x, y, z, a, b, c;
	
	three_plus_three testing(x, y, z, a, b, c);

	initial begin
		$dumpfile("test.vcd");
		$dumpvars(0, main);
		a = 1; b = 1; c = 1;
		#10; // delay 10 units (10ns in this case)
		// $display is a task used to display current state
		// $time is the current simulation time
		$display("t=%04d a=%b b=%b c=%b", $time, a, b, c);
		$display("t=%04d x=%b y=%b z=%b", $time, x, y, z);
		$finish; // terminate the simulation
    	end
endmodule
