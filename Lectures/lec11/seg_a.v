module seg_a(output logic out_a, input logic a, b, c, d);

    logic n_a, n_b, n_c, n_d;
    logic i_0, i_1, i_2, i_3;

    not (n_a, a);
    not (n_b, b);
    not (n_c, c);
    not (n_d, d);

    and a_0(i_0, a, n_b, n_c);
    and a_1(i_1, n_a, c);
    and a_2(i_2, n_a, b, d);
    and a_3(i_3, n_d, n_b, n_a);

    or (out_a, i_0, i_1, i_2, i_3);

endmodule