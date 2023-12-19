module controller(
    output alu_ctl_t op,
    output shift_amt_t sh,
    output reg_sel_t d, n, m,
    output logic dw,
    output logic done,
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
            S0: ctrl(OP_SUB, 0, 0, 3, 4, 1 ); // R[0] &lt;= R[3] - R[4], check z
            S1: ctrl(OP_ORR, 0, 0, 0, 0, 0 ); // R[0] | R[0], check n
            S2: ctrl(OP_SUB, 0, 3, 3, 4, 1 ); // R[3] = R[3] - R[4]
            S3: ctrl(OP_SUB, 0, 4, 4, 3, 1 ); // R[4] = R[4] - R[3]
            S4: ctrl(OP_B_PAS, 0, 0, 0, 3, 0 ); // done, output R[3]
        endcase
    end

    always_ff @(posedge clk) begin
        if ( reset ) st <= S0;
        else begin
            case( st )
                S0: st <= cz ? S4 : S1;
                S1: st <= cn ? S3 : S2;
                S2: st <= S0;
                S3: st <= S0;
                S4: st <= S4;
            endcase
        end
    end

    assign done = S4 == st;
endmodule
