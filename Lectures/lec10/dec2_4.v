`timescale 1ns / 1ns

module dec2_4(output logic d0, d1, d2, d3, input logic a, b);

    logic a_not, b_not;
    
    not (a_not, a);
    not (b_not, b);

    and d0_gate(d0, a_not, b_not);
    and d1_gate(d1, a_not, b);
    and d2_gate(d2, a, b_not);
    and d3_gate(d3, a, b);
endmodule


module main; // no inputs/outputs
    logic a, b, d0, d1, d2, d3;

    integer all_inputs, i;

    dec2_4 testing(d0, d1, d2, d3, a, b); // dut, device under testing

    assign {a,b} = all_inputs[1:0];

    initial begin
        $dumpfile("dec2_4.vcd");
        $dumpvars(0, testing);
        i = 0;
        repeat (4) begin
            all_inputs = i;
            #10;
            $display("t=%04d a=%b b=%b d0=%b d1=%b d2=%b d3=%b", $time, a, b, d0, d1, d2, d3);
            i = i + 1;
        end
    end
endmodule
