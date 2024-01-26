`timescale 1ns / 1ns
module and_gate(output logic y,
                 input logic a, b);

    and #2 gate1(y, a, b);
    //assign y = ~a & b;
    // logic t;
    // assign y = t;
    // always_comb begin
    //     case( {a,b} )
    //         2'b00: t = 0;
    //         2'b01: t = 0;
    //         2'b10: t = 0;
    //         2'b11: t = 1;
    //     endcase
    // end
endmodule 






    //and #2 g1(y, a, b);


    //assign #2 y = a & b;
    //logic t;
    //assign #2 y = t;

    //always_comb begin
    //    case( {a,b} )
    //        2'b00: t = 0;
    //        2'b01: t = 0;
    //        2'b10: t = 0;
    //        2'b11: t = 1;
    //    endcase
    //end