`timescale 1ns / 1ns

module main; // no inputs/outputs
    logic a, b, y; // inputs and outputs for testing our module

    integer all_inputs, i; // Values for module input 

    and_gate testing(y, a, b); // dut, device under testing, our module

    assign {a,b} = all_inputs[1:0]; // connecting the values to the inputs

    initial begin
        $dumpfile("and_gate.vcd"); // waveform output
        $dumpvars(0, testing); // dut we want to save, dumpvars(); to save all.
        i = 0;
        repeat (4) begin
            all_inputs = i;
            #10;
            $display("t=%04d a=%b b=%b y=%b", $time, a, b, y);
            i = i + 1;
        end
    end
endmodule
