module controller(
    output alu_ctl_t op,
    output shift_amt_t sh,
    output reg_sel_t d, n, m,
    output logic dw,
    output logic done,
    input logic cn, cz, cc, cv,
    input clk, reset
);
    enum logic [1:0] {S0, S1, S2, S3} st;

    task automatic ctrl(
        alu_ctl_t alu, shift_amt_t amt, reg_sel_t rd, rn, rm, logic w
    );
        op = alu; sh = amt; d = rd; n = rn; m = rm; dw = w;
    endtask

    always_comb begin
        case( st ) 
            S0: ctrl(OP_ORR, 0, 0, 0, 0, 0 ); // R[0] | R[0], check z
            S1: ctrl(OP_ADD, 0, 2, 2, 0, 1 ); // R[2] = R[2] + R[0]
            S2: ctrl(OP_SUB, 0, 0, 0, 1, 1 ); // R[0] = R[0] - R[1], check z
            S3: ctrl(OP_B_PAS, 0, 0, 0, 2, 0 ); // done, output R[2]
        endcase
    end

    always_ff @(posedge clk) begin
        if ( reset ) st <= S0;
        else begin
            case( st )
                S0: st <= cz ? S3 : S1;
                S1: st <= S2;
                S2: st <= cz ? S3 : S1;
                S3: st <= S3;
            endcase
        end
    end

    assign done = S3 == st;
endmodule
