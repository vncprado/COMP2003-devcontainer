module as_alu (
    output reg16_t out,
    input reg16_t a, b,
    input as_ctl_t ctl
);

    always_comb begin
        case( ctl ) 
            AS_ADD : out = a + b;
            AS_SUB : out = a - b;
            AS_A : out = a;
            AS_B : out = b;
        endcase
    end
endmodule
