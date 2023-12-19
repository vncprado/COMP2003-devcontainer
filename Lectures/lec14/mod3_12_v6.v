module mod3_12( output logic y, input logic [3:0] v );
    always_comb begin
        if ( v % 3 == 0 ) begin
            y = 0;
        end
        else begin 
            y = 1;
        end
    end
endmodule
