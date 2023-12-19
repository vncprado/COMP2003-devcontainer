`timescale 1ns/1ns

module dff( output logic q, input logic d, clk);
    always_ff @(posedge clk) begin
        q <= #2 d;
    end
endmodule

