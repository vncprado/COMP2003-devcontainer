module controller(
  output as_ctl_t as_ctl,
  output shift_ctl_t shift_ctl,
  output logic r1_ld, r0_ld,
  input clk, reset
);
    enum logic [1:0] { S0, S1, S2 } st;

    task automatic ctrl(as_ctl_t as,
                        shift_ctl_t sh,
                        logic r1,
                        logic r0 );
                        
        as_ctl = as; shift_ctl = sh; r1_ld = r1; r0_ld = r0;
    endtask

    always_comb begin
        case( st ) 
            S0: ctrl(AS_A, SH_ONE, 0, 1 ); // R0 <= 1
            S1: ctrl(AS_A, SH_ONE, 1, 0 ); // R1 <= R0
            S2: ctrl(AS_A, SH_ONE, 0, 0 );
        endcase
    end

    always_ff @(posedge clk) begin
        if ( reset ) st <= S0;
        else begin
            case( st )
                S0: st <= S1;
                S1: st <= S2;
                S2: st <= S2;
            endcase
        end
    end
endmodule
