`timescale 1ns / 1ns

module not_gate(output logic y, input logic a);

    supply1 vdd;
    supply0 gnd;
    wire o;

           //(drain, source, channel)
    pmos p1 (o, vdd, a);
    nmos n1 (o, gnd, a);

    assign y = o;
endmodule

// Testbench in the same file
module main;
    logic a, y;

    not_gate testing(y, a);

    initial begin

        a = 0;
        #10;
        $display("t=%04d a=%b y=%b", $time, a, y);
        a = 1;
        #10;
        $display("t=%04d a=%b y=%b", $time, a, y);
        $finish;
    end
endmodule
    
