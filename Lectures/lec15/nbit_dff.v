module nbit_dff #(parameter N=8) (
    output logic [N-1:0] q,
    input logic [N-1:0] d,
    input logic clk, reset );

    always_ff @(posedge clk) begin
        if ( reset ) begin
            q <= 0;
        end
        else begin
            q <= d;
        end
    end
endmodule
