`timescale 1ns / 1ns  // define the time units

module D_latch_behavior (input D, input Enable, output reg Q, output reg Qbar);
    always @ (D or Enable)
     if(Enable)
     begin
         Q <= D;
         Qbar <= ~D;
     end
endmodule


module D_latch_gate (input logic D, clk, output reg Q, output reg Qbar);
    wire nandqi, nandqbi, notd;
    not (notd, D);
    and nandqb(nandqbi, clk, D);
    and nandqb(nandqi, clk, notd);
	nor (Q, nandqi, Qbar);
	nor (Qbar, nandqbi, Q);
endmodule 

module main;
	logic d, clk, q, qbar;
	D_latch_gate testing(d, clk, q, qbar);
    //D_latch_behavior testing(d, clk, q, qbar);
	integer all_inputs, i;
	
	assign {d, clk} = all_inputs[1:0];
	initial begin
		$dumpfile("test_D_latch.vcd");
		$dumpvars(0, main);
		i = 0;
		repeat( 8 ) begin
    		$display("t=%04d d=%b clk=%b q=%b qbar=%b", $time, d, clk, q, qbar  );
			all_inputs = i;
			#5;
		    i = i + 1;
		end
		$finish;
	end
endmodule
