`timescale 1ns / 1ns

module rs_latch(output logic q, qb, input logic r, s );
    nand reset_g( q, qb, r);
    nand set_g( qb, q, s);
endmodule

module main;

    logic r, s, qb, q;

    rs_latch dut( q, qb, r, s);

    task apply_test(input logic expect_q, expect_qb);
        logic failed;
        begin
            failed = 0;
            if ( q !== expect_q ) begin
                $display( "expecting q=%b found %b", expect_q, q );
                failed = failed | 1;
            end
            if ( qb !== expect_qb ) begin
                $display( "expecting qb=%b found %b", expect_qb, qb );
                failed = failed | 1;
            end
            if ( failed === 1 ) begin 
                $display( "\n\nTest failed");
                $finish;
            end
        end
    endtask

    initial begin
        $display("nand rs-latch test");
        r=1; s=0;
        #5 $display("test1"); apply_test(0, 1);
        #5 $display("r=%b s=%b q=%b qb=%b", r, s, q, qb);
        r=1; s=1; // stable configuration
        #5 $display("test2"); apply_test(0, 1);
        #5 $display("r=%b s=%b q=%b qb=%b", r, s, q, qb);
        r=0; s=1; // stable configuration
        #5 $display("test3"); apply_test(1, 0);
        #5 $display("r=%b s=%b q=%b qb=%b", r, s, q, qb);
        r=1; s=1;
        #5 $display("test4"); apply_test(1, 0);
        #5 $display("r=%b s=%b q=%b qb=%b", r, s, q, qb);
        r=0; s=0; // illegal configuration
        #5 $display("test5"); apply_test(1, 1);
        #5 $display( "r=%b s=%b q=%b qb=%b", r, s, q, qb);
        r=0; s=1;
        #5 $display("test6"); apply_test(1, 0);
        #5 $display( "r=%b s=%b q=%b qb=%b", r, s, q, qb);
        $display("\n\nTest passed");
    end
endmodule
