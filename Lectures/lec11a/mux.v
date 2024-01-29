module mux #(parameter K=4) (
    output logic [K-1:0] out,
    input logic [K-1:0] a, b,
    input logic s);

    assign out = s ? b : a;
endmodule

