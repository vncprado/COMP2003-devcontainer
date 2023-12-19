module add_3(output logic x, y, z, input logic a, b, c);
    assign x = a&~b&~c | ~a&c | ~a&b;
    assign y = ~b&~c | b&c;
    assign z = ~c;
endmodule
