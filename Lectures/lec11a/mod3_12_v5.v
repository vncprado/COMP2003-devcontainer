module mod3_12( output logic y, input logic [3:0] v );
    assign y = v % 3 != 0;
endmodule
