module ld_reg(
    output reg16_t q,
    input reg16_t d,
    input logic clk, reset, ld
);

    always_ff @(posedge clk) begin
        if ( reset ) begin
            q <= 0;
        end
        else begin
            if ( ld ) q <= d;
        end
    end
endmodule
