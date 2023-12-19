`timescale 1ns/1ns

module bitwise_and(output logic [3:0] y, input logic [3:0] a, b);

    assign y = a&b;

endmodule

module main;
    logic [3:0] A, B, Y;
    
    bitwise_and dut(Y, A, B);
    
    initial begin
        $dumpfile("bitwise_and.vcd");
        $dumpvars(0, dut);
        A = 0;
        B = 1;
        repeat (16) begin
            #10;
            $display("t=%04d a=%b b=%b y=%b", $time, A, B, Y);
            A = A + 1;
        end
        $finish;
    end
endmodule
