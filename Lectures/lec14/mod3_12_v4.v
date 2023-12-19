module mod3_12( output logic y, input logic [3:0] v );
    integer m;

    always_comb begin
        m = v % 3;
        y = m == 1 || m == 2;
    end
endmodule
