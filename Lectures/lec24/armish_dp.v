typedef logic [15:0] reg16_t; // word in register file
typedef logic signed [4:0] shift_amt_t; // shifter control
typedef enum logic [2:0] {
    OP_ADD, OP_SUB, OP_ORR, OP_AND, OP_EOR, OP_B_NEG, OP_B_INV, OP_B_PAS
} alu_ctl_t; // ALU operations
typedef logic [2:0] reg_sel_t; // register select

// helper to display type of ALU operation
function automatic string op_str( alu_ctl_t op );
    case( op )
        OP_ADD: op_str = "ADD";
        OP_SUB: op_str = "SUB";
        OP_ORR: op_str = "OR";
        OP_AND: op_str = "AND";
        OP_EOR: op_str = "EOR";
        OP_B_NEG: op_str = "B_NEG";
        OP_B_INV: op_str = "B_INV";
        OP_B_PAS: op_str = "B_PAS";
    endcase
endfunction

// sh varies from -16 to 15, negatives shifts right, positive shifts left
module shifter(output reg16_t out, input reg16_t in, input shift_amt_t sh);
    assign out = sh < 0 ? in >>> (-sh) : in << sh;
endmodule

module arm_alu(
    output reg16_t out, output logic n, z, c, v,
    input reg16_t a, b, input alu_ctl_t op
);
    always @(*) begin
        c = 0;
        v = 0;
        case( op )
            OP_ADD: begin
                {c,out} = a + b;
                v = (a[15] == b[15]) && (out[15] != a[15]);
            end
            OP_SUB: begin
                {c,out} = a + {1'b0,~b} + 1;
                v = (a[15] == ~b[15]) && (out[15] != a[15]);
            end
            OP_ORR: out = a | b;
            OP_AND: out = a & b;
            OP_EOR: out = a ^ b;
            OP_B_NEG: {c,out} = {1'b0,~b} + 1;
            OP_B_INV: out = ~b;
            OP_B_PAS: out = b;
        endcase
    end

    assign z = (out == 0);
    assign n = out[15];
endmodule

module reg_file(
    output reg16_t rn, rm, input reg16_t rd,
    input reg_sel_t n, m, d,
    input logic dw, reset, clk
);
    reg16_t R[7:0]; // registers
    integer i;

    // two read registers
    assign rn = R[n];
    assign rm = R[m];
    
    // one write register
    always_ff @(posedge clk) begin
        if ( reset ) begin
            for( i = 0; i < 16; i++) begin
                R[i] <= 0;
            end
        end
        else if ( dw ) R[d] <= rd;
    end
endmodule

module armish_datapath( 
    output reg16_t out,
    output logic cn, cz, cc, cv,
    input alu_ctl_t op,
    input shift_amt_t sh,
    input reg_sel_t d, n, m,
    input logic dw, clk, reset
);
    reg16_t Rd, Rn, Rm;
    reg16_t sh_out;

    arm_alu alu (
        .out(Rd), .n(cn), .z(cz), .c(cc), .v(cv),
        .a(Rn), .b(sh_out), .op( op )
    );

    shifter shft(.out(sh_out), .in(Rm), .sh(sh));

    reg_file  rf(
        .rn(Rn), .rm(Rm), .rd(Rd),
        .n(n), .m(m), .d(d),
        .dw(dw), .reset(reset), .clk(clk)
    );

    assign out = Rd;

endmodule
