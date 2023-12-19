module mod3_12(output logic y, input logic [3:0] v);

    always_comb begin
        case ( v )
            4'b0000: y = 0;
            4'b0001: y = 1;
            4'b0010: y = 1;
            4'b0011: y = 0;
            4'b0100: y = 1;
            4'b0101: y = 1;
            4'b0110: y = 0;
            4'b0111: y = 1;
            4'b1000: y = 1;
            4'b1001: y = 0;
            4'b1010: y = 1;
            4'b1011: y = 1;
            4'b1100: y = 0;
            4'b1101: y = 1;
            4'b1110: y = 1;
            4'b1111: y = 0;
        endcase
    end
endmodule

