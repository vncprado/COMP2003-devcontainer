`timescale 1ns / 1ns

module main; // no inputs/outputs
    logic a, b, y;

    integer all_inputs, i;

    and_gate testing(y, a, b); // dut, device under testing

    assign {a,b} = all_inputs[1:0];

    initial begin
        $dumpfile("and_gate.vcd");
        $dumpvars(0, testing);
        i = 0;
        repeat (4) begin
            all_inputs = i;
            #10;
            $display("t=%04d a=%b b=%b y=%b", $time, a, b, y);
            i = i + 1;
        end
    end
endmodule
