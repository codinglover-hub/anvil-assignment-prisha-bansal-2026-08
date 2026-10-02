module keymgr_fixed (
    input  logic       clk_i,
    input  logic       rst_ni,
    input  logic [2:0] op_i,

    output logic       disable_o,
    output logic       stuck_o
);

    assign disable_o = (op_i == 3'h4) || (op_i >= 3'h5);

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (!rst_ni)
            stuck_o <= 1'b0;
        else if (op_i >= 3'h5)
            stuck_o <= 1'b0;
    end

endmodule
