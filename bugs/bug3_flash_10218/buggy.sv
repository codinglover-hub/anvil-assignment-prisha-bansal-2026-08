module lc_ctrl_fsm_buggy (
    input  logic       clk_i,
    input  logic       rst_ni,
    input  logic [1:0] state_invalid_error,
    input  logic       token_if_fsm_err_i,
    input  logic       esc_scrap_state0_i,
    input  logic       esc_scrap_state1_i,
    output logic [1:0] state_o
);
  localparam logic [1:0] IdleSt     = 2'b00;
  localparam logic [1:0] InvalidSt  = 2'b01;
  localparam logic [1:0] EscalateSt = 2'b10;

  logic [1:0] fsm_state_q, fsm_state_d;
  logic state_invalid_error_o;

  always_comb begin
    fsm_state_d = fsm_state_q;
    state_invalid_error_o = 1'b0;

    // BUG: local FSM error has priority over global escalation.
    if ((|state_invalid_error) | token_if_fsm_err_i) begin
      fsm_state_d = InvalidSt;
      state_invalid_error_o = 1'b1;
    end else if (esc_scrap_state0_i || esc_scrap_state1_i) begin
      fsm_state_d = EscalateSt;
    end
  end

  always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni)
      fsm_state_q <= IdleSt;
    else
      fsm_state_q <= fsm_state_d;
  end

  assign state_o = fsm_state_q;
endmodule
