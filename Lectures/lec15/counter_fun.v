module counter #(parameter N=8) (
    output logic [N-1:0] count,
    input logic clk, reset
);

    always_ff @(posedge clk) begin
        if ( reset ) count <= #2 0;
        else count <= #2 (count + 3);
    end
endmodule
