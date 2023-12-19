module main;

    initial begin
        #5;
        $display("At %04d, A",$time);
        #10;
        $display("At %04d, B",$time);
        #10;
        $display("At %04d, C",$time);
    end

    initial begin
        #7;
        $display("At %04d, X",$time);
        #10;
        $display("At %04d, Y",$time);
        #10;
        $display("At %04d, Z",$time);
    end
endmodule
