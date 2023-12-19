module not_bistable(output logic q, not_q);//, input logic s); output doesnt work internal setting works

    wire iq, inot_q;
    assign iq = 0;
    not l1(iq, inot_q);
    not l2(inot_q, iq);

    assign q = iq;
    assign not_q = inot_q;
endmodule
