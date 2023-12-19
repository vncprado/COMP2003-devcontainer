module seven_seg( output logic [6:0] seg, input logic [3:0] digit);
    // {g,f,e,d,c,b,a} == seg
    always_comb begin
        case( digit )
            0: seg = 7'b0111111;
            1: seg = 7'b0000110;
            // digits 2,3,4,5,6,7,8,9 are missing
            default: seg = 7'bxxxxxxx;
        endcase
    end
endmodule
