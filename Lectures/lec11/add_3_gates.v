module add_3(output logic x, y, z, input logic a, b, c);

    logic n_a, n_b, n_c;
    logic i_0, i_1, i_2, i_3, i_4; 

    not (n_a, a);
    not (n_b, b);
    not (n_c, c);

    
    and a_0(i_0, a, n_b, n_c);
    and a_1(i_1, n_a, c);
    and a_2(i_2, n_a, b);
    and a_3(i_3, n_b, n_c);
    and a_4(i_4, b, c);

    or (x, i_0, i_1, i_2);  // x = a&~b&~c | ~a&c | ~a&b
    or (y, i_3, i_4);       // y = ~b&~c | b&c

    buf (z, n_c);           // z = ~c
endmodule
