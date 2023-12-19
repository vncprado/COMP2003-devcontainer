module mod3_12( output logic y, input logic [3:0] v );
    always_comb begin
        case ( v ) 
            0,3,6,9,12,15: y = 0;
            default: y = 1;
        endcase
    end
endmodule
