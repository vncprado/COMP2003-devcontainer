typedef enum logic [1:0] { S0=0, S1=1, S2=3, S3=2 } seq_t;

module seq4(
    output seq_t s,
    input logic clk, reset
);

    always_ff @(posedge clk) begin
        if ( reset ) s <= 0;
        else
            case(s)
                S0: s <= S1;
                S1: s <= S2;
                S2: s <= S3;
                S3: s <= S0;
            endcase
    end
endmodule
