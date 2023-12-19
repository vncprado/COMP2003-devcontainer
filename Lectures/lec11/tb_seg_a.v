`timescale 1ns/1ns

module main;
    logic a, b, c, d;
    logic out_a;

    integer all_inputs, i;

    seg_a DUT(out_a, a, b, c, d);
    assign {a, b, c, d} = all_inputs;

    initial begin
        i = 0;
        # 10 $display("t=%04d abc xyz", $time);
        repeat (16) begin
            all_inputs = i;
            # 10 $display("t=%04d %b%b%b%b %b", $time, a, b, c, d, out_a);

            i = i + 1;
        end
    end
endmodule