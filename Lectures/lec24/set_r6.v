module controller(
    output alu_ctl_t op,
    output shift_amt_t sh,
    output reg_sel_t d, n, m,
    output logic dw,
    input logic cn, cz, cc, cv,
    input clk, reset
);
    enum logic [2:0] {S0, S1, S2, S3, S4} st;

    task automatic ctrl(
        alu_ctl_t alu, shift_amt_t amt, reg_sel_t rd, rn, rm, logic w
    );
        op = alu; sh = amt; d = rd; n = rn; m = rm; dw = w;
    endtask

    always_comb begin
        case( st ) 
            S0: ctrl(OP_EOR, 0, 6, 6, 6, 1 );   // R[6] <= R[6] ^ R[6]
            S1: ctrl(OP_B_INV, 0, 6, 6, 6, 1 ); // R[6] <= ~R[6]
            S2: ctrl(OP_B_PAS, 1, 6, 6, 6, 1 ); // R[6] <= R[6] << 1
            S3: ctrl(OP_B_INV, 0, 6, 6, 6, 1 ); // R[6] <= ~R[6]
            S4: ctrl(OP_B_PAS, 0, 0, 0, 6, 0 ); // output R[6]
        endcase
    end

    always_ff @(posedge clk) begin
        if ( reset ) st <= S0;
        else begin
            case( st )
                S0: st <= S1;
                S1: st <= S2;
                S2: st <= S3;
                S3: st <= S4;
                S4: st <= S4;
            endcase
        end
    end
endmodule
