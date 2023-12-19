module d_latch( output logic q, input logic d, clk);
    always_latch begin
        if ( clk ) q <= #delay d;
    end
endmodule
