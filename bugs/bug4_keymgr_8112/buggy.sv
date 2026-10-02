module keymgr_bug (
    input  logic       clk_i,
    input  logic       rst_ni,
    input  logic [2:0] op_i,

    output logic       disable_o,
    output logic       stuck_o
);

    typedef enum logic [2:0] {
        OpAdvance   = 3'h0,
        OpGenID     = 3'h1,
        OpGenSW     = 3'h2,
        OpGenHW     = 3'h3,
        OpDisable   = 3'h4
    } op_e;

    op_e op;

    assign op = op_e'(op_i);

    // BUG:
    // Reserved values should behave like Disable,
    // but this only recognizes exactly OpDisable.
    assign disable_o = (op == OpDisable);

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (!rst_ni)
            stuck_o <= 1'b0;
        else if (op_i != OpDisable && op_i >= 3'h5)
            stuck_o <= 1'b1;
    end

endmodule
