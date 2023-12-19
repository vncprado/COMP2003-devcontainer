module dff( output logic q, input logic d, clk);
    always_ff @(posedge clk) begin
        q <= #delay d;
    end
endmodule
