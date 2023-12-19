typedef enum logic [1:0] {S0, S1, S2, S3} state_t;

module recognize(
    output state_t st,
    input logic in, clk, reset
);

    always_ff @(posedge clk) begin
        if ( reset ) 
            st <= S0;
        else
            case ( st ) 
                S0: st <= in ? S1 : S0;
                S1: st <= in ? S2 : S0;
                S2: st <= in ? S2 : S3;
                S3: st <= in ? S1 : S0;
            endcase
    end
endmodule
