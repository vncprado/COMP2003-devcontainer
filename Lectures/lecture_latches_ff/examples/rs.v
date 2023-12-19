//https://www.xilinx.com/support/documentation/university/Vivado-Teaching/HDL-Design/2013x/Nexys4/Verilog/docs-pdf/lab5.pdf
`timescale 1ns / 1ns  // define the time units

module RS(input r, s, output q, qb);
	wire qi, qbi;
	
	assign #2 qi = q;
	assign #2 qbi = qb;
	assign #2 q = ~(r | qb);
	assign #2 qb = ~(s | q);
	
endmodule

module SR_latch_dataflow (input R, input S, output Q, output Qbar);
    assign #2 Q_i = Q;
    assign #2 Qbar_i = Qbar;
    assign #2 Q = ~ (R | Qbar);
    assign #2 Qbar = ~ (S | Q);
endmodule 

module SR_latch_gate (input R, input S, output Q, output Qbar);
nor (Q, R, Qbar);
nor (Qbar, S, Q);
endmodule 

module main;
	logic q, qb, r, s;
	SR_latch_gate testing(r, s, q, qb);
//	SR_latch_dataflow testing(r, s, q, qb);
//	RS testing(r, s, q, qb);
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
