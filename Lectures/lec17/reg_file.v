// defined in test bench here just for example
//typedef logic [15:0] reg16_t;
//typedef logic [2:0] reg_sel_t;

module reg_file(
    output reg16_t rn, rm, input reg16_t rd,
    input reg_sel_t n, m, d,
    input logic dw, reset, clk
);
    reg16_t R[7:0]; // registers
    integer i;

    // two read registers
    // each register is independent
    assign rn = R[n];
    assign rm = R[m];
    
    // one write register, write can occur in parallel
    always_ff @(posedge clk) begin
        if ( reset ) begin
            for( i = 0; i < $size(R); i++) begin
                R[i] <= 0;
            end
        end
        else if ( dw ) R[d] <= rd;
    end

endmodule
