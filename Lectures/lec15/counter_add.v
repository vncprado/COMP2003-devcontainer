module ha( output logic c,s, input logic a,b);
    assign c = a & b;
    assign s = a ^ b;
endmodule

module fa( output logic c,s, input logic a,b, cin);
    assign c = a & b | a & cin | b & cin;
    assign s = a ^ b ^ cin;
endmodule

module adder #(parameter N=4) (
    output [N-1:0] sum,
    input [N-1:0] a, b
);
    logic [N-1:0] carries;
    // least significant bit with 1 on carry in
    ha bits0 ( carries[0], sum[0], a[0], b[0]);

    genvar i;
    generate 
        for( i = 1; i < N; i = i + 1 ) begin : ripple
            fa bits ( carries[i], sum[i], a[i], b[i], carries[i-1] );
        end
    endgenerate
endmodule


module counter #(parameter N=8) (
    output logic [N-1:0] count,
    input logic clk, reset
);
    logic [N-1:0] next;
    logic [N-1:0] one;

    assign one = 1;

    nbit_dff #(N) st( count, next, clk, reset);
    adder #(N) inc( next, count, one);
endmodule
