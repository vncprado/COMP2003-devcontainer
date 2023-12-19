module seq4( output logic [1:0] s,
             input logic clk, reset );

    always_ff @(posedge clk) begin
        if ( reset ) 
            s <= 0;
        else
            case(s)
                2'b00: s <= 2'b01;
                2'b01: s <= 2'b11;
                2'b11: s <= 2'b10;
                2'b10: s <= 2'b00;
            endcase
    end
endmodule
