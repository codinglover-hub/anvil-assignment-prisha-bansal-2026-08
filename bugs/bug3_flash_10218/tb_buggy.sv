`timescale 1ns/1ps

module tb_buggy;
  localparam logic [1:0] InvalidSt  = 2'b01;
  localparam logic [1:0] EscalateSt = 2'b10;

  logic clk_i = 1'b0;
  logic rst_ni = 1'b0;
  logic [1:0] state_invalid_error = 2'b00;
  logic token_if_fsm_err_i = 1'b0;
  logic esc_scrap_state0_i = 1'b0;
  logic esc_scrap_state1_i = 1'b0;
  logic [1:0] state_o;

  always #5 clk_i = ~clk_i;

  lc_ctrl_fsm_buggy dut (.*);

  initial begin
    repeat (2) @(negedge clk_i);
    rst_ni = 1'b1;
    @(negedge clk_i);

    // Simultaneous local error and global escalation.
    token_if_fsm_err_i = 1'b1;
    esc_scrap_state0_i = 1'b1;

    @(negedge clk_i);

    if (state_o == EscalateSt)
      $fatal(1, "TEST SETUP DID NOT REPRODUCE BUG");

    if (state_o != InvalidSt)
      $fatal(1, "Unexpected state: %b", state_o);

    $fatal(1,
      "BUG REPRODUCED: local error overrode global escalation");
  end
endmodule
