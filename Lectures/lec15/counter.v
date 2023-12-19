module nbit_dff #(parameter N=8) (
    output logic [N-1:0] q,
    input logic [N-1:0] d,
    input logic clk, reset );

    always_ff @(posedge clk) begin
        if ( reset ) begin
            q <= 0;
        end
        else begin
            q <= d;
        end
    end
endmodule

module next( output logic [2:0] nx, input logic [2:0] st);
    always_comb begin
        case( st )
            3'b000 : nx = 3'b011;
            3'b001 : nx = 3'b100;
            3'b011 : nx = 3'b110;
            3'b100 : nx = 3'b000;
            3'b110 : nx = 3'b001;
            default: nx = 3'bxxx;
        endcase
    end
endmodule

module counter( output logic [2:0] cnt, input logic clk, reset );
    logic [2:0] nxt;

    nbit_dff #(3) state( cnt, nxt, clk, reset );
    next nf ( nxt, cnt );
endmodule

module main;
    logic  [2:0] cnt;
    logic clk, reset;

    task do_clk;
        clk = 0; # 5;
        clk = 1; # 5;
    endtask

    counter dut( cnt, clk, reset);

    initial
        $monitor( "t=%04d clk=%b cnt=%b nxt=%b", $time, clk, cnt, dut.nxt );

    initial begin
        $dumpvars();
        reset = 1;
        do_clk();
        reset = 0;
        repeat ( 6 ) begin
            do_clk();
        end
    end
endmodule
