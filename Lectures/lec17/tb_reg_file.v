
typedef logic [15:0] reg16_t;
typedef logic [2:0] reg_sel_t;

module main;
    reg16_t rn, rm, rd;
    reg_sel_t n, m, d, rsel;
    logic dw, reset, clk;
    reg16_t data_v;
    integer index;

    reg_file dut( rn, rm, rd, n, m, d, dw, reset, clk);

    task automatic reset_reg;
       reset = 1; clk = 0; #5; clk = 1; #5; reset = 0;
    endtask

    task automatic write_rd( input reg_sel_t sel, input reg16_t data );
        dw = 1; // enable write
        d = sel; // select target register
        rd = data; // set the data values
        clk = 0; #5; clk = 1; #5; // clock the register file
        dw = 0; // disable register write
    endtask

    task automatic read_rn( input reg_sel_t sel, output reg16_t data );
        n = sel; // select register to read
        clk = 0; #5; clk = 1; #5; // clock register file
        data = rn; // get value
    endtask

    task automatic read_rm( input reg_sel_t sel, output reg16_t data );
        m = sel;
        clk = 0; #5; clk = 1; #5;
        data = rm;
    endtask

    initial begin
        reset_reg;
        // write all the registers with 1,2, .. 8
        for( index=0; index < 1<<$bits(d); index = index + 1 ) begin
            write_rd( index, index*2 );
        end
        $display("Register N");
        // output values for using register n
        for( index=0; index < 1<<$bits(n); index = index + 1 ) begin
            read_rn( index, data_v );
            $display( "Rn[%0d] = %4x", index, data_v );
        end
        $display("Register M");
        for( index=0; index < 1<<$bits(m); index = index + 1 ) begin
            read_rm( index, data_v );
            $display( "Rm[%0d] = %4x", index, data_v );
        end
        
        index = 2;
        data_v = 11;
        $display("Writting at address %d -> %d", index, data_v);
        write_rd( index, data_v);
        $display("Reading using N at address %d", index);
        read_rn( index, data_v );
        $display( "Rn[%0d] = %4x", index, data_v );
        $display("Reading using M at address %d", index);
        read_rm( index, data_v );
        $display( "Rm[%0d] = %4x", index, data_v );
    end
endmodule
