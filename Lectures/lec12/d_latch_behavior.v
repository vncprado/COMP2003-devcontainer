module d_latch_behavior(output reg q, qbar, input logic d, clk);
    always @(d, clk) begin
        if (clk) begin
            q <= d;
            qbar <= ~d;
        end
    end
endmodule

