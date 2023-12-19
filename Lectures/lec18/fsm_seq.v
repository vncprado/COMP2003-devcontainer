// FSM to Generate 5, 15, 45, 135...

module controller(
  output as_ctl_t as_ctl,
  output shift_ctl_t shift_ctl,
  output logic r1_ld, r0_ld,
  input clk, reset
);
    enum logic [2:0] { S0, S1, S2, S3, S4, S5 } st;

    task automatic ctrl(as_ctl_t as, shift_ctl_t sh, logic r1, logic r0 );
        as_ctl = as; shift_ctl = sh; r1_ld = r1; r0_ld = r0;
    endtask

    always_comb begin
        case( st ) 
            S0: ctrl(AS_A, SH_ONE, 0, 1 );     // R0 <= 1
            S1: ctrl(AS_A, SH_ONE, 1, 0 );     // R1 <= R0
            S2: ctrl(AS_A, SH_LEFT, 0, 1 );    // R0 <= 2*R0
            S3: ctrl(AS_ADD, SH_LEFT, 0, 1 );  // R0 <= 2*R0 + R1
            S4: ctrl(AS_A, SH_LEFT, 1, 1 );    // R1 <= R0; R0 <= 2*R0
            S5: ctrl(AS_ADD, SH_PASS, 0, 1 );  // R0 <= R0 + R1
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
                S4: st <= S5;
                S5: st <= S4;
            endcase
        end
    end
endmodule
