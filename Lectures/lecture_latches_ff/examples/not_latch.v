`timescale 1ns / 1ns  // define the time units

module not_latch_gate (input R, input S, output Q, output Qbar);

wire Qi = Q;
wire Qbari = Qbar;
assign R = Qbari;
assign S = Qi;
not (Q, R);
not (Qbar, S);
endmodule 

module main;
	logic q, qb, r, s;
	not_latch_gate testing(r, s, q, qb);
	integer all_inputs, i;
	
	assign {r,s} = all_inputs[1:0];
	initial begin
		$dumpfile("test.vcd");
		$dumpvars(0, main);
		i = 0;
		repeat( 8 ) begin
    			$display("t=%04d r=%b s=%b q=%b qb=%b", $time, r, s, q, qb  );
			all_inputs = i;
			#5;
		    i = i + 1;
		end
		$display("t=%04d r=%b s=%b", $time, r, s);
		$finish;
	end
endmodule
