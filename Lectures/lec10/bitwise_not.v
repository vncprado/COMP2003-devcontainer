`timescale 1ns/1ns

module bitwise_not(output logic [3:0] y, input logic [3:0] a);

    assign y = ~a;

endmodule

module main;
    logic [3:0] A, Y;
    
    bitwise_not dut(Y, A);
    
    initial begin
        $dumpfile("bitwise_not.vcd");
        $dumpvars(0, dut);
        A = 0;
        repeat (16) begin
            #10;
            $display("t=%04d a=%b y=%b", $time, A, Y);
            A = A + 1;
        end
        $finish;
    end
endmodule
