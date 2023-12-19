`timescale 1ns/1ns

module main;
    logic a, b, c;
    logic x, y, z;
    integer all_inputs, i;

    add_3 dut(x,y,z,a,b,c);

    assign {a,b,c} = all_inputs[2:0];

    initial begin
        i = 0;
        #10 $display("t=%04d abc xyz", $time);
        repeat (8) begin
            all_inputs = i;
            #10 $display("t=%04d %b%b%b %b%b%b", $time, a, b, c, x, y, z);
            i = i + 1;
        end
    end
endmodule
