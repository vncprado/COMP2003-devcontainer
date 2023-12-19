module seg_a(output logic out_a, input logic a, b, c, d);

    assign out_a = c | a | b&d | ~b&~d;
    //assign out_a = a | b&d | ~a&c | ~a&~b&~d;

endmodule