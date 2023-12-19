`timescale 1ns / 1ns  // define the time units

module D_latch_behavior (input D, input Enable, output reg Q, output reg Qbar);
    always @ (D or Enable)
     if(Enable)
     begin
         Q <= D;
         Qbar <= ~D;
     end
endmodule

module D_FF(input D, input clk, output Q);
	wire q1, nclk;
	assign nclk = ~clk;
	D_latch_behavior d_latch1(D, nclk, q1, Qbar1);
	D_latch_behavior d_latch2(q1, clk, Q, Qbar2);
endmodule

module main;
	wire d, clk, q;
	D_FF testing(d, clk, q);
    //D_latch_behavior testing(d, clk, q, qbar);
	integer all_inputs, i;
	
	assign {d, clk} = all_inputs[1:0];
	initial begin
		$dumpfile("test_D_ff.vcd");
		$dumpvars(0, main);
		i = 0;
		repeat( 8 ) begin
    		$display("t=%04d d=%b clk=%b q=%b", $time, d, clk, q);
			all_inputs = i;
			#5;
		    i = i + 1;
		end
		$finish;
	end
endmodule
