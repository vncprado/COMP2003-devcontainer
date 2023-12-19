`timescale 1ns / 1ns

module main;
    logic a, b, c, f;
    integer all_inputs, i;

    detect2_5 dut (f, a, b, c);

    assign {a,b,c} = all_inputs[2:0];

    initial begin
        $display("t=%04d abc f", $time);
        i = 0;        
        repeat ( 8 ) begin        
            all_inputs = i;       

            #10;
            $display("t=%04d %b%b%b %b", $time, a, b, c, f);
            i = i + 1;
        end
    end
endmodule
    
