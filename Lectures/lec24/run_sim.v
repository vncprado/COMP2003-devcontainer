task clock_cycle;
    clk = 0; #5; clk = 1; #5;
endtask

task display_state;
    $display("T=%04d st=S%d out=%x op=%5s sh=%3d NZCV=%4b Rn=%x Rm=%x sh_out=%x",
        $time, CTL.st, out, op_str(op), sh,
        {cn, cz, cc, cv}, DP.Rn, DP.Rm, DP.sh_out);
endtask

task automatic run_sim( integer next_cnt);
    $write("%-8s","reset");
    reset = 1;
    clock_cycle;
    display_state;
    reset = 0;
    repeat ( next_cnt ) begin
        clock_cycle;
        $write("%-8s","next");
        display_state;
    end
    clock_cycle;
    $write("%-8s","final");
    display_state;
    $finish;
endtask
