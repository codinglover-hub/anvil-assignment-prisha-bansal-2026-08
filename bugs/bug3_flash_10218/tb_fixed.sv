`timescale 1ns/1ps

module tb_fixed;
  localparam logic [1:0] EscalateSt = 2'b10;

  logic clk_i = 1'b0;
  logic rst_ni = 1'b0;
  logic [1:0] state_invalid_error = 2'b00;
  logic token_if_fsm_err_i = 1'b0;
  logic esc_scrap_state0_i = 1'b0;
  logic esc_scrap_state1_i = 1'b0;
  logic [1:0] state_o;

  always #5 clk_i = ~clk_i;

  lc_ctrl_fsm_fixed dut (.*);

  initial begin
    repeat (2) @(negedge clk_i);
    rst_ni = 1'b1;
    @(negedge clk_i);

    // Both error and escalation are asserted.
    token_if_fsm_err_i = 1'b1;
    esc_scrap_state0_i = 1'b1;

    @(negedge clk_i);

    if (state_o != EscalateSt)
      $fatal(1,
        "FAIL: expected EscalateSt, got %b", state_o);

    // Remove global request but keep local error asserted.
    esc_scrap_state0_i = 1'b0;
    @(negedge clk_i);

    if (state_o != EscalateSt)
      $fatal(1,
        "FAIL: FSM left EscalateSt, got %b", state_o);

    $display(
      "PASS: global escalation wins and EscalateSt is retained.");
    $finish;
  end
endmodule
