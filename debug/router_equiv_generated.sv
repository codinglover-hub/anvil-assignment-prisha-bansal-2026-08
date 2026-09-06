/* verilator lint_off UNOPTFLAT */
/* verilator lint_off WIDTHTRUNC */
/* verilator lint_off WIDTHEXPAND */
/* verilator lint_off WIDTHCONCAT */
module router_core (
  input logic[0:0] clk_i,
  input logic[0:0] rst_ni,
  output logic[0:0] _in0_beat_ack,
  input logic[0:0] _in0_beat_valid,
  input logic[33:0] _in0_beat_0,
  output logic[0:0] _in1_beat_ack,
  input logic[0:0] _in1_beat_valid,
  input logic[33:0] _in1_beat_0,
  input logic[0:0] _out0_beat_ack,
  output logic[0:0] _out0_beat_valid,
  output logic[33:0] _out0_beat_0,
  input logic[0:0] _out1_beat_ack,
  output logic[0:0] _out1_beat_valid,
  output logic[33:0] _out1_beat_0
);
  logic[0:0] lock0_q;
  logic[0:0] lock1_q;
  logic[0:0] owner0_q;
  logic[0:0] owner1_q;
  logic[33:0] packet0_q;
  logic[33:0] packet1_q;
  logic[0:0] rr0_q;
  logic[0:0] rr1_q;
  logic[0:0] valid0_q;
  logic[0:0] valid1_q;
  always_ff @(posedge clk_i or negedge rst_ni) begin : _proc_transition
    if (~rst_ni) begin
      lock0_q <= '0;
      lock1_q <= '0;
      owner0_q <= '0;
      owner1_q <= '0;
      rr0_q <= '0;
      rr1_q <= '0;
    end
  end
  logic[33:0] thread_0_wire$26;
  logic[33:0] thread_0_wire$24;
  logic[0:0] thread_0_wire$23;
  logic[0:0] thread_0_wire$21;
  logic[33:0] thread_0_wire$20;
  logic[0:0] thread_0_wire$19;
  logic[0:0] thread_0_wire$17;
  logic[33:0] thread_0_wire$15;
  logic[33:0] thread_0_wire$13;
  logic[0:0] thread_0_wire$12;
  logic[0:0] thread_0_wire$10;
  logic[33:0] thread_0_wire$9;
  logic[0:0] thread_0_wire$8;
  logic[0:0] thread_0_wire$6;
  logic[33:0] thread_0_wire$4;
  logic[0:0] thread_0_wire$3;
  logic[33:0] thread_0_wire$1;
  logic[0:0] thread_0_wire$0;
  assign thread_0_wire$0 = _in0_beat_valid;
  assign thread_0_wire$1 = _in0_beat_0;
  localparam logic[0:0] thread_0_wire$2 = 1'b1;
  assign thread_0_wire$3 = _in1_beat_valid;
  assign thread_0_wire$4 = _in1_beat_0;
  localparam logic[0:0] thread_0_wire$5 = 1'b1;
  assign thread_0_wire$6 = valid0_q;
  localparam logic[0:0] thread_0_wire$7 = 1'b1;
  assign thread_0_wire$8 = thread_0_wire$6 == thread_0_wire$7;
  assign thread_0_wire$9 = packet0_q;
  assign thread_0_wire$10 = thread_0_wire$9[1 +: 1];
  localparam logic[0:0] thread_0_wire$11 = 1'b0;
  assign thread_0_wire$12 = thread_0_wire$10 == thread_0_wire$11;
  assign thread_0_wire$13 = packet0_q;
  localparam logic[0:0] thread_0_wire$14 = 1'b0;
  assign thread_0_wire$15 = packet0_q;
  localparam logic[0:0] thread_0_wire$16 = 1'b0;
  assign thread_0_wire$17 = valid1_q;
  localparam logic[0:0] thread_0_wire$18 = 1'b1;
  assign thread_0_wire$19 = thread_0_wire$17 == thread_0_wire$18;
  assign thread_0_wire$20 = packet1_q;
  assign thread_0_wire$21 = thread_0_wire$20[1 +: 1];
  localparam logic[0:0] thread_0_wire$22 = 1'b0;
  assign thread_0_wire$23 = thread_0_wire$21 == thread_0_wire$22;
  assign thread_0_wire$24 = packet1_q;
  localparam logic[0:0] thread_0_wire$25 = 1'b0;
  assign thread_0_wire$26 = packet1_q;
  localparam logic[0:0] thread_0_wire$27 = 1'b0;
  for (genvar i = 0; i < 22; i ++) begin : EVENTS0
    logic event_current;
    end
  logic _init_0;
  logic _thread_0_event_counter_19_1_q, _thread_0_event_counter_19_1_n;
  logic _thread_0_event_counter_18_1_q, _thread_0_event_counter_18_1_n;
  logic _thread_0_event_syncstate_16_q, _thread_0_event_syncstate_16_n;
  logic _thread_0_event_syncstate_14_q, _thread_0_event_syncstate_14_n;
  logic _thread_0_event_counter_10_1_q, _thread_0_event_counter_10_1_n;
  logic _thread_0_event_syncstate_8_q, _thread_0_event_syncstate_8_n;
  logic _thread_0_event_syncstate_6_q, _thread_0_event_syncstate_6_n;
  logic _thread_0_event_counter_2_1_q, _thread_0_event_counter_2_1_n;
  logic _thread_0_event_counter_1_1_q, _thread_0_event_counter_1_1_n;
  assign EVENTS0[21].event_current = EVENTS0[0].event_current && thread_0_wire$0;
  assign EVENTS0[20].event_current = EVENTS0[1].event_current && thread_0_wire$3;
  assign EVENTS0[19].event_current = _thread_0_event_counter_19_1_q;
  assign _thread_0_event_counter_19_1_n = EVENTS0[18].event_current;
  assign EVENTS0[18].event_current = _thread_0_event_counter_18_1_q;
  assign _thread_0_event_counter_18_1_n = EVENTS0[17].event_current;
  assign EVENTS0[17].event_current = EVENTS0[16].event_current || EVENTS0[14].event_current || EVENTS0[11].event_current;
  assign EVENTS0[16].event_current = (EVENTS0[15].event_current || _thread_0_event_syncstate_16_q) && _out0_beat_ack;
    assign _thread_0_event_syncstate_16_n = (EVENTS0[15].event_current || _thread_0_event_syncstate_16_q) && !_out0_beat_ack;
  assign EVENTS0[15].event_current = EVENTS0[12].event_current && thread_0_wire$23;
  assign EVENTS0[14].event_current = (EVENTS0[13].event_current || _thread_0_event_syncstate_14_q) && _out1_beat_ack;
    assign _thread_0_event_syncstate_14_n = (EVENTS0[13].event_current || _thread_0_event_syncstate_14_q) && !_out1_beat_ack;
  assign EVENTS0[13].event_current = EVENTS0[12].event_current && !thread_0_wire$23;
  assign EVENTS0[12].event_current = EVENTS0[10].event_current && thread_0_wire$19;
  assign EVENTS0[11].event_current = EVENTS0[10].event_current && !thread_0_wire$19;
  assign EVENTS0[10].event_current = _thread_0_event_counter_10_1_q;
  assign _thread_0_event_counter_10_1_n = EVENTS0[9].event_current;
  assign EVENTS0[9].event_current = EVENTS0[8].event_current || EVENTS0[6].event_current || EVENTS0[3].event_current;
  assign EVENTS0[8].event_current = (EVENTS0[7].event_current || _thread_0_event_syncstate_8_q) && _out0_beat_ack;
    assign _thread_0_event_syncstate_8_n = (EVENTS0[7].event_current || _thread_0_event_syncstate_8_q) && !_out0_beat_ack;
  assign EVENTS0[7].event_current = EVENTS0[4].event_current && thread_0_wire$12;
  assign EVENTS0[6].event_current = (EVENTS0[5].event_current || _thread_0_event_syncstate_6_q) && _out1_beat_ack;
    assign _thread_0_event_syncstate_6_n = (EVENTS0[5].event_current || _thread_0_event_syncstate_6_q) && !_out1_beat_ack;
  assign EVENTS0[5].event_current = EVENTS0[4].event_current && !thread_0_wire$12;
  assign EVENTS0[4].event_current = EVENTS0[2].event_current && thread_0_wire$8;
  assign EVENTS0[3].event_current = EVENTS0[2].event_current && !thread_0_wire$8;
  assign EVENTS0[2].event_current = _thread_0_event_counter_2_1_q;
  assign _thread_0_event_counter_2_1_n = EVENTS0[1].event_current;
  assign EVENTS0[1].event_current = _thread_0_event_counter_1_1_q;
  assign _thread_0_event_counter_1_1_n = EVENTS0[0].event_current;
  assign EVENTS0[0].event_current = _init_0 || EVENTS0[19].event_current;
  assign _in1_beat_ack = EVENTS0[20].event_current;
  assign _in0_beat_ack = EVENTS0[21].event_current;
  assign _out1_beat_valid = (EVENTS0[5].event_current || _thread_0_event_syncstate_6_q) || (EVENTS0[13].event_current || _thread_0_event_syncstate_14_q);
  assign _out0_beat_valid = (EVENTS0[7].event_current || _thread_0_event_syncstate_8_q) || (EVENTS0[15].event_current || _thread_0_event_syncstate_16_q);
  logic[0:0] _out0_beat_valid_selector_q, _out0_beat_valid_selector_n;
  assign _out0_beat_0 = (_out0_beat_valid_selector_n == 1'd0) ? thread_0_wire$13 : (_out0_beat_valid_selector_n == 1'd1) ? thread_0_wire$24 : '0;
  logic[0:0] _out1_beat_valid_selector_q, _out1_beat_valid_selector_n;
  assign _out1_beat_0 = (_out1_beat_valid_selector_n == 1'd0) ? thread_0_wire$15 : (_out1_beat_valid_selector_n == 1'd1) ? thread_0_wire$26 : '0;
  always_comb begin: _thread_0_selector
    _out0_beat_valid_selector_n = _out0_beat_valid_selector_q;
    if ((EVENTS0[7].event_current || _thread_0_event_syncstate_8_q)) _out0_beat_valid_selector_n = 1'd0;
    if ((EVENTS0[15].event_current || _thread_0_event_syncstate_16_q)) _out0_beat_valid_selector_n = 1'd1;
    _out1_beat_valid_selector_n = _out1_beat_valid_selector_q;
    if ((EVENTS0[5].event_current || _thread_0_event_syncstate_6_q)) _out1_beat_valid_selector_n = 1'd0;
    if ((EVENTS0[13].event_current || _thread_0_event_syncstate_14_q)) _out1_beat_valid_selector_n = 1'd1;
  end
  always_ff @(posedge clk_i or negedge rst_ni) begin : _thread_0_selector_trans
    if (~rst_ni) begin
      _out0_beat_valid_selector_q <= '0;
      _out1_beat_valid_selector_q <= '0;
    end else begin
      _out0_beat_valid_selector_q <= _out0_beat_valid_selector_n;
      _out1_beat_valid_selector_q <= _out1_beat_valid_selector_n;
    end
  end
  always_ff @(posedge clk_i or negedge rst_ni) begin : _thread_0_st_transition
    if (~rst_ni) begin
      _init_0 <= 1'b1;
      packet0_q <= '0;
      packet1_q <= '0;
      valid0_q <= '0;
      valid1_q <= '0;
      _thread_0_event_counter_19_1_q <= '0;
      _thread_0_event_counter_18_1_q <= '0;
      _thread_0_event_syncstate_16_q <= '0;
      _thread_0_event_syncstate_14_q <= '0;
      _thread_0_event_counter_10_1_q <= '0;
      _thread_0_event_syncstate_8_q <= '0;
      _thread_0_event_syncstate_6_q <= '0;
      _thread_0_event_counter_2_1_q <= '0;
      _thread_0_event_counter_1_1_q <= '0;
    end else begin
      if (EVENTS0[21].event_current) begin
        valid0_q[0 +: 1] <= thread_0_wire$2;
        packet0_q[0 +: 34] <= thread_0_wire$1;
      end
      if (EVENTS0[20].event_current) begin
        valid1_q[0 +: 1] <= thread_0_wire$5;
        packet1_q[0 +: 34] <= thread_0_wire$4;
      end
      if (EVENTS0[16].event_current) begin
        valid1_q[0 +: 1] <= thread_0_wire$25;
      end
      if (EVENTS0[14].event_current) begin
        valid1_q[0 +: 1] <= thread_0_wire$27;
      end
      if (EVENTS0[8].event_current) begin
        valid0_q[0 +: 1] <= thread_0_wire$14;
      end
      if (EVENTS0[6].event_current) begin
        valid0_q[0 +: 1] <= thread_0_wire$16;
      end
      _init_0 <= 1'b0;
      _thread_0_event_counter_19_1_q <= _thread_0_event_counter_19_1_n;
      _thread_0_event_counter_18_1_q <= _thread_0_event_counter_18_1_n;
      _thread_0_event_syncstate_16_q <= _thread_0_event_syncstate_16_n;
      _thread_0_event_syncstate_14_q <= _thread_0_event_syncstate_14_n;
      _thread_0_event_counter_10_1_q <= _thread_0_event_counter_10_1_n;
      _thread_0_event_syncstate_8_q <= _thread_0_event_syncstate_8_n;
      _thread_0_event_syncstate_6_q <= _thread_0_event_syncstate_6_n;
      _thread_0_event_counter_2_1_q <= _thread_0_event_counter_2_1_n;
      _thread_0_event_counter_1_1_q <= _thread_0_event_counter_1_1_n;
    end
  end
endmodule
module router_equiv (
  input logic[0:0] clk_i,
  input logic[0:0] rst_ni,
  output logic[0:0] _in0_beat_ack,
  input logic[0:0] _in0_beat_valid,
  input logic[33:0] _in0_beat_0,
  output logic[0:0] _in1_beat_ack,
  input logic[0:0] _in1_beat_valid,
  input logic[33:0] _in1_beat_0,
  input logic[0:0] _out0_beat_ack,
  output logic[0:0] _out0_beat_valid,
  output logic[33:0] _out0_beat_0,
  input logic[0:0] _out1_beat_ack,
  output logic[0:0] _out1_beat_valid,
  output logic[33:0] _out1_beat_0
);
  router_core _spawn_0 (
    .clk_i,
    .rst_ni
    ,._in0_beat_valid (_in0_beat_valid)
    ,._in0_beat_ack (_in0_beat_ack)
    ,._in0_beat_0 (_in0_beat_0)
    ,._in1_beat_valid (_in1_beat_valid)
    ,._in1_beat_ack (_in1_beat_ack)
    ,._in1_beat_0 (_in1_beat_0)
    ,._out0_beat_valid (_out0_beat_valid)
    ,._out0_beat_ack (_out0_beat_ack)
    ,._out0_beat_0 (_out0_beat_0)
    ,._out1_beat_valid (_out1_beat_valid)
    ,._out1_beat_ack (_out1_beat_ack)
    ,._out1_beat_0 (_out1_beat_0)
  );
  always_ff @(posedge clk_i or negedge rst_ni) begin : _proc_transition
    if (~rst_ni) begin
    end
  end
  for (genvar i = 0; i < 2; i ++) begin : EVENTS0
    logic event_current;
    end
  logic _init_0;
  logic _thread_0_event_counter_1_1_q, _thread_0_event_counter_1_1_n;
  assign EVENTS0[1].event_current = _thread_0_event_counter_1_1_q;
  assign _thread_0_event_counter_1_1_n = EVENTS0[0].event_current;
  assign EVENTS0[0].event_current = _init_0 || EVENTS0[1].event_current;
  always_ff @(posedge clk_i or negedge rst_ni) begin : _thread_0_st_transition
    if (~rst_ni) begin
      _init_0 <= 1'b1;
      _thread_0_event_counter_1_1_q <= '0;
    end else begin
      _init_0 <= 1'b0;
      _thread_0_event_counter_1_1_q <= _thread_0_event_counter_1_1_n;
    end
  end
endmodule
