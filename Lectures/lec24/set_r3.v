module controller(
    output alu_ctl_t op,
    output shift_amt_t sh,
    output reg_sel_t d, n, m,
    output logic dw,
    input logic cn, cz, cc, cv,
    input clk, reset
);
    enum logic {S0, S1} st;

    task automatic ctrl(
        alu_ctl_t alu, shift_amt_t amt, reg_sel_t rd, rn, rm, logic w
    );
        op = alu; sh = amt; d = rd; n = rn; m = rm; dw = w;
    endtask

    always_comb begin
        case( st ) 
            // reset r3 to 0
            S0: ctrl(OP_EOR, 0, 3, 3, 3, 1 );  // R[3] <= R[3] ^ R[3]
            // output r3 via alu's b
            S1: ctrl(OP_B_PAS, 0, 0, 0, 3, 0 ); // output R[3]
        endcase
    end

    always_ff @(posedge clk) begin
        if ( reset ) st <= S0;
        else begin
            case( st )
                S0: st <= S1;
                S1: st <= S1;
            endcase
        end
    end
endmodule
