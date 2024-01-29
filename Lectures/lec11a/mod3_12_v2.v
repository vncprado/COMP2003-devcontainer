module mod3_12( output logic y, input logic [3:0] v );

    always_comb begin
        casez ( v ) //v //= abcd
            4'b010?: y = 1; //~a&b~c
            4'b0?01: y = 1; //~a~cd
            4'b?101: y = 1;
            4'b01?1: y = 1;
            4'b?010: y = 1;
            4'b1?10: y = 1;
            4'b101?: y = 1;
            4'b10?0: y = 1;
            default: y = 0;
        endcase
    end
endmodule
