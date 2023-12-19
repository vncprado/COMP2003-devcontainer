module main;
    parameter N=6;
    parameter M=16; 

    logic [N-1:0] addr;
    logic [M-1:0] din, dout;
    logic clk, we;

    ram #(N,M) dut( clk, we, addr, din, dout);

    task automatic write_mem( input logic [N-1:0] adr, input [M-1:0] data );
        we = 1; // enable write
        addr = adr; // set the memory address
        din = data; // set the data values
        clk = 0; #5; clk = 1; #5; // clock the register file
        we = 0; // disable write
    endtask

    task automatic read_mem(input logic [N-1:0] adr, output [M-1:0] data );
        we = 0;  // select read
        addr = adr; // select memory to read
        clk = 0; #5; clk = 1; #5; // clock register file
        data = dout; // get value
    endtask

    initial begin
        integer index;
        logic [M-1:0] data_v;

        // write a test pattern to first 10 memory locations
        for( index=0; index < 10; index = index + 1 ) begin
            write_mem( index, index+1 );
        end
        $display("Memory Contents");
        // Read the memory
        for( index=0; index < 10; index = index + 1 ) begin
            read_mem( index, data_v );
            $display( "Mem[%0d] = %4x", index, data_v );
        end
    end
endmodule
