module dff( output logic q, input logic d, clk);
    always_ff @(posedge clk) begin
        q <= d;
    end
endmodule

module shift_reg(
    output logic [2:0] sh,
    input logic sin, clk
);

    dff bit0( sh[0], sin, clk);
    dff bit1( sh[1], sh[0], clk);
    dff bit2( sh[2], sh[1], clk);
endmodule
