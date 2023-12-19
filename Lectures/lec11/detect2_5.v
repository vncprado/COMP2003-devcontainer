module detect2_5(output logic y, input logic a, b, c);
//    assign y = a ^ b;

//    xor #2 x1(y, a, b);

    logic o1, o2, nota, notb;
    not #2 n1(nota, a);
    not #2 n2(notb, b);
    and #2 a1(o1, nota, b);
    and #2 a2(o2, notb, a);
    or #2 or1(y, o1, o2);
endmodule
