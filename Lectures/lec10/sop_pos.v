`timescale 1ns / 1ns

module sop_pos(output logic y, z, input logic a, b, c);

    assign y = ~a & ~b & c | ~a & b & ~c | a & ~b & ~c | a & b & c;
    
    assign z = (~a | ~b | c) & (~a | b | ~c) & (a | ~b | ~c) & (a | b | c);

endmodule

module main;
    logic a, b, c, y;
    logic [2:0] bits;
    
    task apply_test(input [2:0] test_vec);
        begin
            {a, b, c} = test_vec;
            #10;
            $display("t=%04d vec=%03b y=%b z=%b", $time, test_vec, y, z);
        end
    endtask
    
    sop_pos testing(y, z, a, b, c);
    
    initial begin
        $dumpfile("sop_pos.vcd");
        $dumpvars(0, testing);
        bits = 0;
        repeat ( 8 ) begin
            apply_test( bits );
            bits = bits + 1;
        end
        $finish;
    end            
endmodule
