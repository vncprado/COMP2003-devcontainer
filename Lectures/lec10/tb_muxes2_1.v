`timescale 1ns / 1ns

module main;
    logic  out; 
    logic a,b,sel;
    logic ma, mc, mb;
    integer all_ins; // 32 bit integer

    // instantiate the modules under test
    mux2_1_assign g1(ma, a, b, sel);
    mux_2_1_cond g2(mc, a, b, sel);
    mux_2_1_behave g3(mb, a, b, sel);

    assign {sel, a,b} = all_ins[2:0];

    initial begin
        $dumpfile("muxes2_1.vcd");
        $dumpvars(0, g1,g2,g3);
        for( all_ins = 0; all_ins <= 7; all_ins = all_ins + 1)
        begin
            #1; // delay after input change
            $display("sel=%b a=%b b=%b  ma=%b mc=%b mb=%b",
               sel, a, b, ma, mc, mb);
        end
        $finish;
    end
endmodule
