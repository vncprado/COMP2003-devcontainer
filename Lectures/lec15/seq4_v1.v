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

module seq4( output logic [1:0] cur,
             input logic clk, reset );
    logic [1:0] next;

    always_comb begin
        case(cur)
            2'b00: next = 2'b01;
            2'b01: next = 2'b11;
            2'b11: next = 2'b10;
            2'b10: next = 2'b00;
        endcase
    end

    nbit_dff #(2) st( cur, next, clk, reset);
endmodule
