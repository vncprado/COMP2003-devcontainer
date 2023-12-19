module shift_reg(
    output logic [2:0] sh,
    input logic sin, clk
);

    always_ff @(posedge clk) begin
        sh[0] <= sin;
        sh[1] <= sh[0];
        sh[2] <= sh[1];
    end
endmodule
