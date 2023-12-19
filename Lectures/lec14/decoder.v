module decoder #(parameter N=2) (
    output logic [2**N-1 : 0 ] d,
    input logic [N-1:0] sel );

    assign d = 1 << sel;
endmodule
