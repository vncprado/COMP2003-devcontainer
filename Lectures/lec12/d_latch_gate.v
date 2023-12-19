module d_latch_gate(output reg q, qbar,
                    input logic d, clk);

    wire i_nand_q, i_nand_qbar, notd;

    not(notd, d);
    and nandqb(i_nand_qbar, clk, d);
    and nandq(i_nand_q, clk, notd);

    nor (q, i_nand_q, qbar);
    nor (qbar, i_nand_qbar, qbar);

endmodule

