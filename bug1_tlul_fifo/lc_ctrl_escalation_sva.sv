// Separate checker example for Bug 3 (not used by this Bug 1 runner).
module lc_ctrl_escalation_sva #(
    parameter logic [1:0] EscalateSt = 2'b10
) (
    input logic clk_i,
    input logic rst_ni,
    input logic [1:0] state_o,
    input logic [1:0] state_invalid_error,
    input logic token_if_fsm_err_i,
    input logic esc_scrap_state0_i,
    input logic esc_scrap_state1_i
);
    default clocking cb @(posedge clk_i); endclocking
    assert property (disable iff (!rst_ni)
        ((esc_scrap_state0_i || esc_scrap_state1_i) &&
         ((|state_invalid_error) || token_if_fsm_err_i))
        |=> (state_o == EscalateSt));
endmodule
