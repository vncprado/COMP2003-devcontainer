module sr_latch(output logic q, nq,
                input logic s, r);
    nor (q, r, nq);
    nor (nq, s, q);
endmodule

