module mux2_1_assign(output logic m, input logic a, b, sel);
    assign m = ~sel & a | sel & b;
endmodule

module mux_2_1_cond(output logic m, input logic a, b, sel);
    // b if sel is 1, otherwise a
    assign m = sel ? b : a;
    // this expression comes from C-language
endmodule

module mux_2_1_behave(output logic m, input logic a, b, sel);
    always_comb begin // a, b, sel trigger block
        if ( sel ) 
            m = b;
        else
            m = a;
    end
endmodule
