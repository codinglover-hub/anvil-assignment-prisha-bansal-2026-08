/* verilator lint_off UNOPTFLAT */
/* verilator lint_off WIDTHTRUNC */
/* verilator lint_off WIDTHEXPAND */
/* verilator lint_off WIDTHCONCAT */
module input0_router (
  input logic[0:0] clk_i,
  input logic[0:0] rst_ni,
  output logic[0:0] _in0_beat_ack,
  input logic[0:0] _in0_beat_valid,
  input logic[33:0] _in0_beat_0,
  input logic[0:0] _to_out0_beat_ack,
  output logic[0:0] _to_out0_beat_valid,
  output logic[33:0] _to_out0_beat_0,
  input logic[0:0] _to_out1_beat_ack,
  output logic[0:0] _to_out1_beat_valid,
  output logic[33:0] _to_out1_beat_0
);
  logic[0:0] dest0_q;
  logic[33:0] packet0_q;
  logic[0:0] valid0_q;
  always_ff @(posedge clk_i or negedge rst_ni) begin : _proc_transition
    if (~rst_ni) begin
    end
  end
  logic[33:0] thread_0_wire$12;
  logic[33:0] thread_0_wire$10;
  logic[0:0] thread_0_wire$9;
  logic[0:0] thread_0_wire$7;
  logic[0:0] thread_0_wire$5;
  logic[33:0] thread_0_wire$4;
  logic[0:0] thread_0_wire$3;
  logic[0:0] thread_0_wire$2;
  logic[0:0] thread_0_wire$0;
  assign thread_0_wire$0 = valid0_q;
  localparam logic[0:0] thread_0_wire$1 = 1'b0;
  assign thread_0_wire$2 = thread_0_wire$0 == thread_0_wire$1;
  assign thread_0_wire$3 = _in0_beat_valid;
  assign thread_0_wire$4 = _in0_beat_0;
  assign thread_0_wire$5 = thread_0_wire$4[32 +: 1];
  localparam logic[0:0] thread_0_wire$6 = 1'b1;
  assign thread_0_wire$7 = dest0_q;
  localparam logic[0:0] thread_0_wire$8 = 1'b0;
  assign thread_0_wire$9 = thread_0_wire$7 == thread_0_wire$8;
  assign thread_0_wire$10 = packet0_q;
  localparam logic[0:0] thread_0_wire$11 = 1'b0;
  assign thread_0_wire$12 = packet0_q;
  localparam logic[0:0] thread_0_wire$13 = 1'b0;
  for (genvar i = 0; i < 14; i ++) begin : EVENTS0
    logic event_current;
    end
  logic _init_0;
  logic _thread_0_event_counter_13_1_q, _thread_0_event_counter_13_1_n;
  logic _thread_0_event_counter_11_1_q, _thread_0_event_counter_11_1_n;
  logic _thread_0_event_counter_7_1_q, _thread_0_event_counter_7_1_n;
  logic _thread_0_event_syncstate_5_q, _thread_0_event_syncstate_5_n;
  logic _thread_0_event_syncstate_3_q, _thread_0_event_syncstate_3_n;
  assign EVENTS0[13].event_current = _thread_0_event_counter_13_1_q;
  assign _thread_0_event_counter_13_1_n = EVENTS0[12].event_current;
  assign EVENTS0[12].event_current = EVENTS0[11].event_current || EVENTS0[9].event_current || EVENTS0[7].event_current;
  assign EVENTS0[11].event_current = _thread_0_event_counter_11_1_q;
  assign _thread_0_event_counter_11_1_n = EVENTS0[10].event_current;
  assign EVENTS0[10].event_current = EVENTS0[8].event_current && thread_0_wire$3;
  assign EVENTS0[9].event_current = EVENTS0[8].event_current && !thread_0_wire$3;
  assign EVENTS0[8].event_current = EVENTS0[0].event_current && thread_0_wire$2;
  assign EVENTS0[7].event_current = _thread_0_event_counter_7_1_q;
  assign _thread_0_event_counter_7_1_n = EVENTS0[6].event_current;
  assign EVENTS0[6].event_current = EVENTS0[5].event_current || EVENTS0[3].event_current;
  assign EVENTS0[5].event_current = (EVENTS0[4].event_current || _thread_0_event_syncstate_5_q) && _to_out0_beat_ack;
    assign _thread_0_event_syncstate_5_n = (EVENTS0[4].event_current || _thread_0_event_syncstate_5_q) && !_to_out0_beat_ack;
  assign EVENTS0[4].event_current = EVENTS0[1].event_current && thread_0_wire$9;
  assign EVENTS0[3].event_current = (EVENTS0[2].event_current || _thread_0_event_syncstate_3_q) && _to_out1_beat_ack;
    assign _thread_0_event_syncstate_3_n = (EVENTS0[2].event_current || _thread_0_event_syncstate_3_q) && !_to_out1_beat_ack;
  assign EVENTS0[2].event_current = EVENTS0[1].event_current && !thread_0_wire$9;
  assign EVENTS0[1].event_current = EVENTS0[0].event_current && !thread_0_wire$2;
  assign EVENTS0[0].event_current = _init_0 || EVENTS0[13].event_current;
  assign _in0_beat_ack = EVENTS0[10].event_current;
  assign _to_out1_beat_valid = (EVENTS0[2].event_current || _thread_0_event_syncstate_3_q);
  assign _to_out1_beat_0 = thread_0_wire$12;
  assign _to_out0_beat_valid = (EVENTS0[4].event_current || _thread_0_event_syncstate_5_q);
  assign _to_out0_beat_0 = thread_0_wire$10;
  always_ff @(posedge clk_i or negedge rst_ni) begin : _thread_0_st_transition
    if (~rst_ni) begin
      _init_0 <= 1'b1;
      dest0_q <= '0;
      packet0_q <= '0;
      valid0_q <= '0;
      _thread_0_event_counter_13_1_q <= '0;
      _thread_0_event_counter_11_1_q <= '0;
      _thread_0_event_counter_7_1_q <= '0;
      _thread_0_event_syncstate_5_q <= '0;
      _thread_0_event_syncstate_3_q <= '0;
    end else begin
      if (EVENTS0[10].event_current) begin
        valid0_q[0 +: 1] <= thread_0_wire$6;
        dest0_q[0 +: 1] <= thread_0_wire$5;
        packet0_q[0 +: 34] <= thread_0_wire$4;
      end
      if (EVENTS0[5].event_current) begin
        valid0_q[0 +: 1] <= thread_0_wire$11;
      end
      if (EVENTS0[3].event_current) begin
        valid0_q[0 +: 1] <= thread_0_wire$13;
      end
      _init_0 <= 1'b0;
      _thread_0_event_counter_13_1_q <= _thread_0_event_counter_13_1_n;
      _thread_0_event_counter_11_1_q <= _thread_0_event_counter_11_1_n;
      _thread_0_event_counter_7_1_q <= _thread_0_event_counter_7_1_n;
      _thread_0_event_syncstate_5_q <= _thread_0_event_syncstate_5_n;
      _thread_0_event_syncstate_3_q <= _thread_0_event_syncstate_3_n;
    end
  end
endmodule
module input1_router (
  input logic[0:0] clk_i,
  input logic[0:0] rst_ni,
  output logic[0:0] _in1_beat_ack,
  input logic[0:0] _in1_beat_valid,
  input logic[33:0] _in1_beat_0,
  input logic[0:0] _to_out0_beat_ack,
  output logic[0:0] _to_out0_beat_valid,
  output logic[33:0] _to_out0_beat_0,
  input logic[0:0] _to_out1_beat_ack,
  output logic[0:0] _to_out1_beat_valid,
  output logic[33:0] _to_out1_beat_0
);
  logic[0:0] dest1_q;
  logic[33:0] packet1_q;
  logic[0:0] valid1_q;
  always_ff @(posedge clk_i or negedge rst_ni) begin : _proc_transition
    if (~rst_ni) begin
    end
  end
  logic[33:0] thread_0_wire$12;
  logic[33:0] thread_0_wire$10;
  logic[0:0] thread_0_wire$9;
  logic[0:0] thread_0_wire$7;
  logic[0:0] thread_0_wire$5;
  logic[33:0] thread_0_wire$4;
  logic[0:0] thread_0_wire$3;
  logic[0:0] thread_0_wire$2;
  logic[0:0] thread_0_wire$0;
  assign thread_0_wire$0 = valid1_q;
  localparam logic[0:0] thread_0_wire$1 = 1'b0;
  assign thread_0_wire$2 = thread_0_wire$0 == thread_0_wire$1;
  assign thread_0_wire$3 = _in1_beat_valid;
  assign thread_0_wire$4 = _in1_beat_0;
  assign thread_0_wire$5 = thread_0_wire$4[32 +: 1];
  localparam logic[0:0] thread_0_wire$6 = 1'b1;
  assign thread_0_wire$7 = dest1_q;
  localparam logic[0:0] thread_0_wire$8 = 1'b0;
  assign thread_0_wire$9 = thread_0_wire$7 == thread_0_wire$8;
  assign thread_0_wire$10 = packet1_q;
  localparam logic[0:0] thread_0_wire$11 = 1'b0;
  assign thread_0_wire$12 = packet1_q;
  localparam logic[0:0] thread_0_wire$13 = 1'b0;
  for (genvar i = 0; i < 14; i ++) begin : EVENTS0
    logic event_current;
    end
  logic _init_0;
  logic _thread_0_event_counter_13_1_q, _thread_0_event_counter_13_1_n;
  logic _thread_0_event_counter_11_1_q, _thread_0_event_counter_11_1_n;
  logic _thread_0_event_counter_7_1_q, _thread_0_event_counter_7_1_n;
  logic _thread_0_event_syncstate_5_q, _thread_0_event_syncstate_5_n;
  logic _thread_0_event_syncstate_3_q, _thread_0_event_syncstate_3_n;
  assign EVENTS0[13].event_current = _thread_0_event_counter_13_1_q;
  assign _thread_0_event_counter_13_1_n = EVENTS0[12].event_current;
  assign EVENTS0[12].event_current = EVENTS0[11].event_current || EVENTS0[9].event_current || EVENTS0[7].event_current;
  assign EVENTS0[11].event_current = _thread_0_event_counter_11_1_q;
  assign _thread_0_event_counter_11_1_n = EVENTS0[10].event_current;
  assign EVENTS0[10].event_current = EVENTS0[8].event_current && thread_0_wire$3;
  assign EVENTS0[9].event_current = EVENTS0[8].event_current && !thread_0_wire$3;
  assign EVENTS0[8].event_current = EVENTS0[0].event_current && thread_0_wire$2;
  assign EVENTS0[7].event_current = _thread_0_event_counter_7_1_q;
  assign _thread_0_event_counter_7_1_n = EVENTS0[6].event_current;
  assign EVENTS0[6].event_current = EVENTS0[5].event_current || EVENTS0[3].event_current;
  assign EVENTS0[5].event_current = (EVENTS0[4].event_current || _thread_0_event_syncstate_5_q) && _to_out0_beat_ack;
    assign _thread_0_event_syncstate_5_n = (EVENTS0[4].event_current || _thread_0_event_syncstate_5_q) && !_to_out0_beat_ack;
  assign EVENTS0[4].event_current = EVENTS0[1].event_current && thread_0_wire$9;
  assign EVENTS0[3].event_current = (EVENTS0[2].event_current || _thread_0_event_syncstate_3_q) && _to_out1_beat_ack;
    assign _thread_0_event_syncstate_3_n = (EVENTS0[2].event_current || _thread_0_event_syncstate_3_q) && !_to_out1_beat_ack;
  assign EVENTS0[2].event_current = EVENTS0[1].event_current && !thread_0_wire$9;
  assign EVENTS0[1].event_current = EVENTS0[0].event_current && !thread_0_wire$2;
  assign EVENTS0[0].event_current = _init_0 || EVENTS0[13].event_current;
  assign _in1_beat_ack = EVENTS0[10].event_current;
  assign _to_out1_beat_valid = (EVENTS0[2].event_current || _thread_0_event_syncstate_3_q);
  assign _to_out1_beat_0 = thread_0_wire$12;
  assign _to_out0_beat_valid = (EVENTS0[4].event_current || _thread_0_event_syncstate_5_q);
  assign _to_out0_beat_0 = thread_0_wire$10;
  always_ff @(posedge clk_i or negedge rst_ni) begin : _thread_0_st_transition
    if (~rst_ni) begin
      _init_0 <= 1'b1;
      dest1_q <= '0;
      packet1_q <= '0;
      valid1_q <= '0;
      _thread_0_event_counter_13_1_q <= '0;
      _thread_0_event_counter_11_1_q <= '0;
      _thread_0_event_counter_7_1_q <= '0;
      _thread_0_event_syncstate_5_q <= '0;
      _thread_0_event_syncstate_3_q <= '0;
    end else begin
      if (EVENTS0[10].event_current) begin
        valid1_q[0 +: 1] <= thread_0_wire$6;
        dest1_q[0 +: 1] <= thread_0_wire$5;
        packet1_q[0 +: 34] <= thread_0_wire$4;
      end
      if (EVENTS0[5].event_current) begin
        valid1_q[0 +: 1] <= thread_0_wire$11;
      end
      if (EVENTS0[3].event_current) begin
        valid1_q[0 +: 1] <= thread_0_wire$13;
      end
      _init_0 <= 1'b0;
      _thread_0_event_counter_13_1_q <= _thread_0_event_counter_13_1_n;
      _thread_0_event_counter_11_1_q <= _thread_0_event_counter_11_1_n;
      _thread_0_event_counter_7_1_q <= _thread_0_event_counter_7_1_n;
      _thread_0_event_syncstate_5_q <= _thread_0_event_syncstate_5_n;
      _thread_0_event_syncstate_3_q <= _thread_0_event_syncstate_3_n;
    end
  end
endmodule
module output0_arbiter (
  input logic[0:0] clk_i,
  input logic[0:0] rst_ni,
  output logic[0:0] _from_in0_beat_ack,
  input logic[0:0] _from_in0_beat_valid,
  input logic[33:0] _from_in0_beat_0,
  output logic[0:0] _from_in1_beat_ack,
  input logic[0:0] _from_in1_beat_valid,
  input logic[33:0] _from_in1_beat_0,
  input logic[0:0] _out0_beat_ack,
  output logic[0:0] _out0_beat_valid,
  output logic[33:0] _out0_beat_0
);
  logic[0:0] lock0_q;
  logic[0:0] owner0_q;
  logic[33:0] packet0_q;
  logic[33:0] packet1_q;
  logic[0:0] rr0_q;
  logic[0:0] valid0_q;
  logic[0:0] valid1_q;
  always_ff @(posedge clk_i or negedge rst_ni) begin : _proc_transition
    if (~rst_ni) begin
    end
  end
  logic[0:0] thread_0_wire$87;
  logic[0:0] thread_0_wire$85;
  logic[33:0] thread_0_wire$84;
  logic[33:0] thread_0_wire$82;
  logic[0:0] thread_0_wire$81;
  logic[0:0] thread_0_wire$79;
  logic[0:0] thread_0_wire$76;
  logic[0:0] thread_0_wire$74;
  logic[33:0] thread_0_wire$73;
  logic[33:0] thread_0_wire$71;
  logic[0:0] thread_0_wire$70;
  logic[0:0] thread_0_wire$68;
  logic[0:0] thread_0_wire$65;
  logic[0:0] thread_0_wire$63;
  logic[33:0] thread_0_wire$62;
  logic[33:0] thread_0_wire$59;
  logic[0:0] thread_0_wire$56;
  logic[0:0] thread_0_wire$54;
  logic[33:0] thread_0_wire$53;
  logic[33:0] thread_0_wire$50;
  logic[0:0] thread_0_wire$49;
  logic[0:0] thread_0_wire$47;
  logic[0:0] thread_0_wire$46;
  logic[0:0] thread_0_wire$45;
  logic[0:0] thread_0_wire$43;
  logic[0:0] thread_0_wire$42;
  logic[0:0] thread_0_wire$40;
  logic[0:0] thread_0_wire$36;
  logic[0:0] thread_0_wire$34;
  logic[33:0] thread_0_wire$33;
  logic[33:0] thread_0_wire$32;
  logic[0:0] thread_0_wire$31;
  logic[0:0] thread_0_wire$29;
  logic[0:0] thread_0_wire$25;
  logic[0:0] thread_0_wire$23;
  logic[33:0] thread_0_wire$22;
  logic[33:0] thread_0_wire$21;
  logic[0:0] thread_0_wire$20;
  logic[0:0] thread_0_wire$18;
  logic[0:0] thread_0_wire$17;
  logic[0:0] thread_0_wire$15;
  logic[0:0] thread_0_wire$14;
  logic[0:0] thread_0_wire$12;
  logic[33:0] thread_0_wire$10;
  logic[0:0] thread_0_wire$9;
  logic[0:0] thread_0_wire$8;
  logic[0:0] thread_0_wire$6;
  logic[33:0] thread_0_wire$4;
  logic[0:0] thread_0_wire$3;
  logic[0:0] thread_0_wire$2;
  logic[0:0] thread_0_wire$0;
  assign thread_0_wire$0 = valid0_q;
  localparam logic[0:0] thread_0_wire$1 = 1'b0;
  assign thread_0_wire$2 = thread_0_wire$0 == thread_0_wire$1;
  assign thread_0_wire$3 = _from_in0_beat_valid;
  assign thread_0_wire$4 = _from_in0_beat_0;
  localparam logic[0:0] thread_0_wire$5 = 1'b1;
  assign thread_0_wire$6 = valid1_q;
  localparam logic[0:0] thread_0_wire$7 = 1'b0;
  assign thread_0_wire$8 = thread_0_wire$6 == thread_0_wire$7;
  assign thread_0_wire$9 = _from_in1_beat_valid;
  assign thread_0_wire$10 = _from_in1_beat_0;
  localparam logic[0:0] thread_0_wire$11 = 1'b1;
  assign thread_0_wire$12 = lock0_q;
  localparam logic[0:0] thread_0_wire$13 = 1'b1;
  assign thread_0_wire$14 = thread_0_wire$12 == thread_0_wire$13;
  assign thread_0_wire$15 = owner0_q;
  localparam logic[0:0] thread_0_wire$16 = 1'b0;
  assign thread_0_wire$17 = thread_0_wire$15 == thread_0_wire$16;
  assign thread_0_wire$18 = valid0_q;
  localparam logic[0:0] thread_0_wire$19 = 1'b1;
  assign thread_0_wire$20 = thread_0_wire$18 == thread_0_wire$19;
  assign thread_0_wire$21 = packet0_q;
  assign thread_0_wire$22 = packet0_q;
  assign thread_0_wire$23 = thread_0_wire$22[33 +: 1];
  localparam logic[0:0] thread_0_wire$24 = 1'b1;
  assign thread_0_wire$25 = thread_0_wire$23 == thread_0_wire$24;
  localparam logic[0:0] thread_0_wire$26 = 1'b0;
  localparam logic[0:0] thread_0_wire$27 = 1'b0;
  localparam logic[0:0] thread_0_wire$28 = 1'b0;
  assign thread_0_wire$29 = valid1_q;
  localparam logic[0:0] thread_0_wire$30 = 1'b1;
  assign thread_0_wire$31 = thread_0_wire$29 == thread_0_wire$30;
  assign thread_0_wire$32 = packet1_q;
  assign thread_0_wire$33 = packet1_q;
  assign thread_0_wire$34 = thread_0_wire$33[33 +: 1];
  localparam logic[0:0] thread_0_wire$35 = 1'b1;
  assign thread_0_wire$36 = thread_0_wire$34 == thread_0_wire$35;
  localparam logic[0:0] thread_0_wire$37 = 1'b0;
  localparam logic[0:0] thread_0_wire$38 = 1'b0;
  localparam logic[0:0] thread_0_wire$39 = 1'b0;
  assign thread_0_wire$40 = valid0_q;
  localparam logic[0:0] thread_0_wire$41 = 1'b1;
  assign thread_0_wire$42 = thread_0_wire$40 == thread_0_wire$41;
  assign thread_0_wire$43 = valid1_q;
  localparam logic[0:0] thread_0_wire$44 = 1'b1;
  assign thread_0_wire$45 = thread_0_wire$43 == thread_0_wire$44;
  assign thread_0_wire$46 = thread_0_wire$42 & thread_0_wire$45;
  assign thread_0_wire$47 = rr0_q;
  localparam logic[0:0] thread_0_wire$48 = 1'b0;
  assign thread_0_wire$49 = thread_0_wire$47 == thread_0_wire$48;
  assign thread_0_wire$50 = packet0_q;
  localparam logic[0:0] thread_0_wire$51 = 1'b1;
  localparam logic[0:0] thread_0_wire$52 = 1'b0;
  assign thread_0_wire$53 = packet0_q;
  assign thread_0_wire$54 = thread_0_wire$53[33 +: 1];
  localparam logic[0:0] thread_0_wire$55 = 1'b0;
  assign thread_0_wire$56 = thread_0_wire$54 == thread_0_wire$55;
  localparam logic[0:0] thread_0_wire$57 = 1'b1;
  localparam logic[0:0] thread_0_wire$58 = 1'b0;
  assign thread_0_wire$59 = packet1_q;
  localparam logic[0:0] thread_0_wire$60 = 1'b0;
  localparam logic[0:0] thread_0_wire$61 = 1'b0;
  assign thread_0_wire$62 = packet1_q;
  assign thread_0_wire$63 = thread_0_wire$62[33 +: 1];
  localparam logic[0:0] thread_0_wire$64 = 1'b0;
  assign thread_0_wire$65 = thread_0_wire$63 == thread_0_wire$64;
  localparam logic[0:0] thread_0_wire$66 = 1'b1;
  localparam logic[0:0] thread_0_wire$67 = 1'b1;
  assign thread_0_wire$68 = valid0_q;
  localparam logic[0:0] thread_0_wire$69 = 1'b1;
  assign thread_0_wire$70 = thread_0_wire$68 == thread_0_wire$69;
  assign thread_0_wire$71 = packet0_q;
  localparam logic[0:0] thread_0_wire$72 = 1'b0;
  assign thread_0_wire$73 = packet0_q;
  assign thread_0_wire$74 = thread_0_wire$73[33 +: 1];
  localparam logic[0:0] thread_0_wire$75 = 1'b0;
  assign thread_0_wire$76 = thread_0_wire$74 == thread_0_wire$75;
  localparam logic[0:0] thread_0_wire$77 = 1'b1;
  localparam logic[0:0] thread_0_wire$78 = 1'b0;
  assign thread_0_wire$79 = valid1_q;
  localparam logic[0:0] thread_0_wire$80 = 1'b1;
  assign thread_0_wire$81 = thread_0_wire$79 == thread_0_wire$80;
  assign thread_0_wire$82 = packet1_q;
  localparam logic[0:0] thread_0_wire$83 = 1'b0;
  assign thread_0_wire$84 = packet1_q;
  assign thread_0_wire$85 = thread_0_wire$84[33 +: 1];
  localparam logic[0:0] thread_0_wire$86 = 1'b0;
  assign thread_0_wire$87 = thread_0_wire$85 == thread_0_wire$86;
  localparam logic[0:0] thread_0_wire$88 = 1'b1;
  localparam logic[0:0] thread_0_wire$89 = 1'b1;
  for (genvar i = 0; i < 52; i ++) begin : EVENTS0
    logic event_current;
    end
  logic _init_0;
  logic _thread_0_event_counter_43_1_q, _thread_0_event_counter_43_1_n;
  logic _thread_0_event_counter_41_1_q, _thread_0_event_counter_41_1_n;
  logic _thread_0_event_syncstate_40_q, _thread_0_event_syncstate_40_n;
  logic _thread_0_event_counter_36_1_q, _thread_0_event_counter_36_1_n;
  logic _thread_0_event_syncstate_35_q, _thread_0_event_syncstate_35_n;
  logic _thread_0_event_counter_32_1_q, _thread_0_event_counter_32_1_n;
  logic _thread_0_event_syncstate_30_q, _thread_0_event_syncstate_30_n;
  logic _thread_0_event_syncstate_28_q, _thread_0_event_syncstate_28_n;
  logic _thread_0_event_syncstate_24_q, _thread_0_event_syncstate_24_n;
  logic _thread_0_event_syncstate_20_q, _thread_0_event_syncstate_20_n;
  logic _thread_0_event_counter_15_1_q, _thread_0_event_counter_15_1_n;
  logic _thread_0_event_counter_13_1_q, _thread_0_event_counter_13_1_n;
  logic _thread_0_event_counter_8_1_q, _thread_0_event_counter_8_1_n;
  logic _thread_0_event_counter_7_1_q, _thread_0_event_counter_7_1_n;
  logic _thread_0_event_counter_5_1_q, _thread_0_event_counter_5_1_n;
  assign EVENTS0[51].event_current = EVENTS0[41].event_current && thread_0_wire$87;
  assign EVENTS0[50].event_current = EVENTS0[36].event_current && thread_0_wire$76;
  assign EVENTS0[49].event_current = EVENTS0[32].event_current && thread_0_wire$65;
  assign EVENTS0[48].event_current = EVENTS0[32].event_current && thread_0_wire$56;
  assign EVENTS0[47].event_current = EVENTS0[24].event_current && !thread_0_wire$36;
  assign EVENTS0[46].event_current = EVENTS0[24].event_current && thread_0_wire$36;
  assign EVENTS0[45].event_current = EVENTS0[20].event_current && !thread_0_wire$25;
  assign EVENTS0[44].event_current = EVENTS0[20].event_current && thread_0_wire$25;
  assign EVENTS0[43].event_current = _thread_0_event_counter_43_1_q;
  assign _thread_0_event_counter_43_1_n = EVENTS0[42].event_current;
  assign EVENTS0[42].event_current = EVENTS0[41].event_current || EVENTS0[38].event_current || EVENTS0[36].event_current || EVENTS0[32].event_current || EVENTS0[24].event_current || EVENTS0[22].event_current || EVENTS0[20].event_current || EVENTS0[18].event_current;
  assign EVENTS0[41].event_current = _thread_0_event_counter_41_1_q;
  assign _thread_0_event_counter_41_1_n = EVENTS0[40].event_current;
  assign EVENTS0[40].event_current = (EVENTS0[39].event_current || _thread_0_event_syncstate_40_q) && _out0_beat_ack;
    assign _thread_0_event_syncstate_40_n = (EVENTS0[39].event_current || _thread_0_event_syncstate_40_q) && !_out0_beat_ack;
  assign EVENTS0[39].event_current = EVENTS0[37].event_current && thread_0_wire$81;
  assign EVENTS0[38].event_current = EVENTS0[37].event_current && !thread_0_wire$81;
  assign EVENTS0[37].event_current = EVENTS0[33].event_current && !thread_0_wire$70;
  assign EVENTS0[36].event_current = _thread_0_event_counter_36_1_q;
  assign _thread_0_event_counter_36_1_n = EVENTS0[35].event_current;
  assign EVENTS0[35].event_current = (EVENTS0[34].event_current || _thread_0_event_syncstate_35_q) && _out0_beat_ack;
    assign _thread_0_event_syncstate_35_n = (EVENTS0[34].event_current || _thread_0_event_syncstate_35_q) && !_out0_beat_ack;
  assign EVENTS0[34].event_current = EVENTS0[33].event_current && thread_0_wire$70;
  assign EVENTS0[33].event_current = EVENTS0[25].event_current && !thread_0_wire$46;
  assign EVENTS0[32].event_current = _thread_0_event_counter_32_1_q;
  assign _thread_0_event_counter_32_1_n = EVENTS0[31].event_current;
  assign EVENTS0[31].event_current = EVENTS0[30].event_current || EVENTS0[28].event_current;
  assign EVENTS0[30].event_current = (EVENTS0[29].event_current || _thread_0_event_syncstate_30_q) && _out0_beat_ack;
    assign _thread_0_event_syncstate_30_n = (EVENTS0[29].event_current || _thread_0_event_syncstate_30_q) && !_out0_beat_ack;
  assign EVENTS0[29].event_current = EVENTS0[26].event_current && thread_0_wire$49;
  assign EVENTS0[28].event_current = (EVENTS0[27].event_current || _thread_0_event_syncstate_28_q) && _out0_beat_ack;
    assign _thread_0_event_syncstate_28_n = (EVENTS0[27].event_current || _thread_0_event_syncstate_28_q) && !_out0_beat_ack;
  assign EVENTS0[27].event_current = EVENTS0[26].event_current && !thread_0_wire$49;
  assign EVENTS0[26].event_current = EVENTS0[25].event_current && thread_0_wire$46;
  assign EVENTS0[25].event_current = EVENTS0[15].event_current && !thread_0_wire$14;
  assign EVENTS0[24].event_current = (EVENTS0[23].event_current || _thread_0_event_syncstate_24_q) && _out0_beat_ack;
    assign _thread_0_event_syncstate_24_n = (EVENTS0[23].event_current || _thread_0_event_syncstate_24_q) && !_out0_beat_ack;
  assign EVENTS0[23].event_current = EVENTS0[21].event_current && thread_0_wire$31;
  assign EVENTS0[22].event_current = EVENTS0[21].event_current && !thread_0_wire$31;
  assign EVENTS0[21].event_current = EVENTS0[16].event_current && !thread_0_wire$17;
  assign EVENTS0[20].event_current = (EVENTS0[19].event_current || _thread_0_event_syncstate_20_q) && _out0_beat_ack;
    assign _thread_0_event_syncstate_20_n = (EVENTS0[19].event_current || _thread_0_event_syncstate_20_q) && !_out0_beat_ack;
  assign EVENTS0[19].event_current = EVENTS0[17].event_current && thread_0_wire$20;
  assign EVENTS0[18].event_current = EVENTS0[17].event_current && !thread_0_wire$20;
  assign EVENTS0[17].event_current = EVENTS0[16].event_current && thread_0_wire$17;
  assign EVENTS0[16].event_current = EVENTS0[15].event_current && thread_0_wire$14;
  assign EVENTS0[15].event_current = _thread_0_event_counter_15_1_q;
  assign _thread_0_event_counter_15_1_n = EVENTS0[14].event_current;
  assign EVENTS0[14].event_current = EVENTS0[13].event_current || EVENTS0[11].event_current || EVENTS0[9].event_current;
  assign EVENTS0[13].event_current = _thread_0_event_counter_13_1_q;
  assign _thread_0_event_counter_13_1_n = EVENTS0[12].event_current;
  assign EVENTS0[12].event_current = EVENTS0[10].event_current && thread_0_wire$9;
  assign EVENTS0[11].event_current = EVENTS0[10].event_current && !thread_0_wire$9;
  assign EVENTS0[10].event_current = EVENTS0[8].event_current && thread_0_wire$8;
  assign EVENTS0[9].event_current = EVENTS0[8].event_current && !thread_0_wire$8;
  assign EVENTS0[8].event_current = _thread_0_event_counter_8_1_q;
  assign _thread_0_event_counter_8_1_n = EVENTS0[7].event_current;
  assign EVENTS0[7].event_current = _thread_0_event_counter_7_1_q;
  assign _thread_0_event_counter_7_1_n = EVENTS0[6].event_current;
  assign EVENTS0[6].event_current = EVENTS0[5].event_current || EVENTS0[3].event_current || EVENTS0[1].event_current;
  assign EVENTS0[5].event_current = _thread_0_event_counter_5_1_q;
  assign _thread_0_event_counter_5_1_n = EVENTS0[4].event_current;
  assign EVENTS0[4].event_current = EVENTS0[2].event_current && thread_0_wire$3;
  assign EVENTS0[3].event_current = EVENTS0[2].event_current && !thread_0_wire$3;
  assign EVENTS0[2].event_current = EVENTS0[0].event_current && thread_0_wire$2;
  assign EVENTS0[1].event_current = EVENTS0[0].event_current && !thread_0_wire$2;
  assign EVENTS0[0].event_current = _init_0 || EVENTS0[43].event_current;
  assign _from_in0_beat_ack = EVENTS0[4].event_current;
  assign _from_in1_beat_ack = EVENTS0[12].event_current;
  assign _out0_beat_valid = (EVENTS0[19].event_current || _thread_0_event_syncstate_20_q) || (EVENTS0[23].event_current || _thread_0_event_syncstate_24_q) || (EVENTS0[27].event_current || _thread_0_event_syncstate_28_q) || (EVENTS0[29].event_current || _thread_0_event_syncstate_30_q) || (EVENTS0[34].event_current || _thread_0_event_syncstate_35_q) || (EVENTS0[39].event_current || _thread_0_event_syncstate_40_q);
  logic[2:0] _out0_beat_valid_selector_q, _out0_beat_valid_selector_n;
  assign _out0_beat_0 = (_out0_beat_valid_selector_n == 3'd0) ? thread_0_wire$21 : (_out0_beat_valid_selector_n == 3'd1) ? thread_0_wire$32 : (_out0_beat_valid_selector_n == 3'd2) ? thread_0_wire$59 : (_out0_beat_valid_selector_n == 3'd3) ? thread_0_wire$50 : (_out0_beat_valid_selector_n == 3'd4) ? thread_0_wire$71 : (_out0_beat_valid_selector_n == 3'd5) ? thread_0_wire$82 : '0;
  always_comb begin: _thread_0_selector
    _out0_beat_valid_selector_n = _out0_beat_valid_selector_q;
    if ((EVENTS0[19].event_current || _thread_0_event_syncstate_20_q)) _out0_beat_valid_selector_n = 3'd0;
    if ((EVENTS0[23].event_current || _thread_0_event_syncstate_24_q)) _out0_beat_valid_selector_n = 3'd1;
    if ((EVENTS0[27].event_current || _thread_0_event_syncstate_28_q)) _out0_beat_valid_selector_n = 3'd2;
    if ((EVENTS0[29].event_current || _thread_0_event_syncstate_30_q)) _out0_beat_valid_selector_n = 3'd3;
    if ((EVENTS0[34].event_current || _thread_0_event_syncstate_35_q)) _out0_beat_valid_selector_n = 3'd4;
    if ((EVENTS0[39].event_current || _thread_0_event_syncstate_40_q)) _out0_beat_valid_selector_n = 3'd5;
  end
  always_ff @(posedge clk_i or negedge rst_ni) begin : _thread_0_selector_trans
    if (~rst_ni) begin
      _out0_beat_valid_selector_q <= '0;
    end else begin
      _out0_beat_valid_selector_q <= _out0_beat_valid_selector_n;
    end
  end
  always_ff @(posedge clk_i or negedge rst_ni) begin : _thread_0_st_transition
    if (~rst_ni) begin
      _init_0 <= 1'b1;
      lock0_q <= '0;
      owner0_q <= '0;
      packet0_q <= '0;
      packet1_q <= '0;
      rr0_q <= '0;
      valid0_q <= '0;
      valid1_q <= '0;
      _thread_0_event_counter_43_1_q <= '0;
      _thread_0_event_counter_41_1_q <= '0;
      _thread_0_event_syncstate_40_q <= '0;
      _thread_0_event_counter_36_1_q <= '0;
      _thread_0_event_syncstate_35_q <= '0;
      _thread_0_event_counter_32_1_q <= '0;
      _thread_0_event_syncstate_30_q <= '0;
      _thread_0_event_syncstate_28_q <= '0;
      _thread_0_event_syncstate_24_q <= '0;
      _thread_0_event_syncstate_20_q <= '0;
      _thread_0_event_counter_15_1_q <= '0;
      _thread_0_event_counter_13_1_q <= '0;
      _thread_0_event_counter_8_1_q <= '0;
      _thread_0_event_counter_7_1_q <= '0;
      _thread_0_event_counter_5_1_q <= '0;
    end else begin
      if (EVENTS0[51].event_current) begin
        owner0_q[0 +: 1] <= thread_0_wire$89;
        lock0_q[0 +: 1] <= thread_0_wire$88;
      end
      if (EVENTS0[50].event_current) begin
        owner0_q[0 +: 1] <= thread_0_wire$78;
        lock0_q[0 +: 1] <= thread_0_wire$77;
      end
      if (EVENTS0[49].event_current) begin
        owner0_q[0 +: 1] <= thread_0_wire$67;
        lock0_q[0 +: 1] <= thread_0_wire$66;
      end
      if (EVENTS0[48].event_current) begin
        owner0_q[0 +: 1] <= thread_0_wire$58;
        lock0_q[0 +: 1] <= thread_0_wire$57;
      end
      if (EVENTS0[47].event_current) begin
        valid1_q[0 +: 1] <= thread_0_wire$39;
      end
      if (EVENTS0[46].event_current) begin
        lock0_q[0 +: 1] <= thread_0_wire$38;
        valid1_q[0 +: 1] <= thread_0_wire$37;
      end
      if (EVENTS0[45].event_current) begin
        valid0_q[0 +: 1] <= thread_0_wire$28;
      end
      if (EVENTS0[44].event_current) begin
        lock0_q[0 +: 1] <= thread_0_wire$27;
        valid0_q[0 +: 1] <= thread_0_wire$26;
      end
      if (EVENTS0[40].event_current) begin
        valid1_q[0 +: 1] <= thread_0_wire$83;
      end
      if (EVENTS0[35].event_current) begin
        valid0_q[0 +: 1] <= thread_0_wire$72;
      end
      if (EVENTS0[30].event_current) begin
        valid0_q[0 +: 1] <= thread_0_wire$52;
        rr0_q[0 +: 1] <= thread_0_wire$51;
      end
      if (EVENTS0[28].event_current) begin
        valid1_q[0 +: 1] <= thread_0_wire$61;
        rr0_q[0 +: 1] <= thread_0_wire$60;
      end
      if (EVENTS0[12].event_current) begin
        valid1_q[0 +: 1] <= thread_0_wire$11;
        packet1_q[0 +: 34] <= thread_0_wire$10;
      end
      if (EVENTS0[4].event_current) begin
        valid0_q[0 +: 1] <= thread_0_wire$5;
        packet0_q[0 +: 34] <= thread_0_wire$4;
      end
      _init_0 <= 1'b0;
      _thread_0_event_counter_43_1_q <= _thread_0_event_counter_43_1_n;
      _thread_0_event_counter_41_1_q <= _thread_0_event_counter_41_1_n;
      _thread_0_event_syncstate_40_q <= _thread_0_event_syncstate_40_n;
      _thread_0_event_counter_36_1_q <= _thread_0_event_counter_36_1_n;
      _thread_0_event_syncstate_35_q <= _thread_0_event_syncstate_35_n;
      _thread_0_event_counter_32_1_q <= _thread_0_event_counter_32_1_n;
      _thread_0_event_syncstate_30_q <= _thread_0_event_syncstate_30_n;
      _thread_0_event_syncstate_28_q <= _thread_0_event_syncstate_28_n;
      _thread_0_event_syncstate_24_q <= _thread_0_event_syncstate_24_n;
      _thread_0_event_syncstate_20_q <= _thread_0_event_syncstate_20_n;
      _thread_0_event_counter_15_1_q <= _thread_0_event_counter_15_1_n;
      _thread_0_event_counter_13_1_q <= _thread_0_event_counter_13_1_n;
      _thread_0_event_counter_8_1_q <= _thread_0_event_counter_8_1_n;
      _thread_0_event_counter_7_1_q <= _thread_0_event_counter_7_1_n;
      _thread_0_event_counter_5_1_q <= _thread_0_event_counter_5_1_n;
    end
  end
endmodule
module output1_arbiter (
  input logic[0:0] clk_i,
  input logic[0:0] rst_ni,
  output logic[0:0] _from_in0_beat_ack,
  input logic[0:0] _from_in0_beat_valid,
  input logic[33:0] _from_in0_beat_0,
  output logic[0:0] _from_in1_beat_ack,
  input logic[0:0] _from_in1_beat_valid,
  input logic[33:0] _from_in1_beat_0,
  input logic[0:0] _out1_beat_ack,
  output logic[0:0] _out1_beat_valid,
  output logic[33:0] _out1_beat_0
);
  logic[0:0] lock1_q;
  logic[0:0] owner1_q;
  logic[33:0] packet0_q;
  logic[33:0] packet1_q;
  logic[0:0] rr1_q;
  logic[0:0] valid0_q;
  logic[0:0] valid1_q;
  always_ff @(posedge clk_i or negedge rst_ni) begin : _proc_transition
    if (~rst_ni) begin
    end
  end
  logic[0:0] thread_0_wire$87;
  logic[0:0] thread_0_wire$85;
  logic[33:0] thread_0_wire$84;
  logic[33:0] thread_0_wire$82;
  logic[0:0] thread_0_wire$81;
  logic[0:0] thread_0_wire$79;
  logic[0:0] thread_0_wire$76;
  logic[0:0] thread_0_wire$74;
  logic[33:0] thread_0_wire$73;
  logic[33:0] thread_0_wire$71;
  logic[0:0] thread_0_wire$70;
  logic[0:0] thread_0_wire$68;
  logic[0:0] thread_0_wire$65;
  logic[0:0] thread_0_wire$63;
  logic[33:0] thread_0_wire$62;
  logic[33:0] thread_0_wire$59;
  logic[0:0] thread_0_wire$56;
  logic[0:0] thread_0_wire$54;
  logic[33:0] thread_0_wire$53;
  logic[33:0] thread_0_wire$50;
  logic[0:0] thread_0_wire$49;
  logic[0:0] thread_0_wire$47;
  logic[0:0] thread_0_wire$46;
  logic[0:0] thread_0_wire$45;
  logic[0:0] thread_0_wire$43;
  logic[0:0] thread_0_wire$42;
  logic[0:0] thread_0_wire$40;
  logic[0:0] thread_0_wire$36;
  logic[0:0] thread_0_wire$34;
  logic[33:0] thread_0_wire$33;
  logic[33:0] thread_0_wire$32;
  logic[0:0] thread_0_wire$31;
  logic[0:0] thread_0_wire$29;
  logic[0:0] thread_0_wire$25;
  logic[0:0] thread_0_wire$23;
  logic[33:0] thread_0_wire$22;
  logic[33:0] thread_0_wire$21;
  logic[0:0] thread_0_wire$20;
  logic[0:0] thread_0_wire$18;
  logic[0:0] thread_0_wire$17;
  logic[0:0] thread_0_wire$15;
  logic[0:0] thread_0_wire$14;
  logic[0:0] thread_0_wire$12;
  logic[33:0] thread_0_wire$10;
  logic[0:0] thread_0_wire$9;
  logic[0:0] thread_0_wire$8;
  logic[0:0] thread_0_wire$6;
  logic[33:0] thread_0_wire$4;
  logic[0:0] thread_0_wire$3;
  logic[0:0] thread_0_wire$2;
  logic[0:0] thread_0_wire$0;
  assign thread_0_wire$0 = valid0_q;
  localparam logic[0:0] thread_0_wire$1 = 1'b0;
  assign thread_0_wire$2 = thread_0_wire$0 == thread_0_wire$1;
  assign thread_0_wire$3 = _from_in0_beat_valid;
  assign thread_0_wire$4 = _from_in0_beat_0;
  localparam logic[0:0] thread_0_wire$5 = 1'b1;
  assign thread_0_wire$6 = valid1_q;
  localparam logic[0:0] thread_0_wire$7 = 1'b0;
  assign thread_0_wire$8 = thread_0_wire$6 == thread_0_wire$7;
  assign thread_0_wire$9 = _from_in1_beat_valid;
  assign thread_0_wire$10 = _from_in1_beat_0;
  localparam logic[0:0] thread_0_wire$11 = 1'b1;
  assign thread_0_wire$12 = lock1_q;
  localparam logic[0:0] thread_0_wire$13 = 1'b1;
  assign thread_0_wire$14 = thread_0_wire$12 == thread_0_wire$13;
  assign thread_0_wire$15 = owner1_q;
  localparam logic[0:0] thread_0_wire$16 = 1'b0;
  assign thread_0_wire$17 = thread_0_wire$15 == thread_0_wire$16;
  assign thread_0_wire$18 = valid0_q;
  localparam logic[0:0] thread_0_wire$19 = 1'b1;
  assign thread_0_wire$20 = thread_0_wire$18 == thread_0_wire$19;
  assign thread_0_wire$21 = packet0_q;
  assign thread_0_wire$22 = packet0_q;
  assign thread_0_wire$23 = thread_0_wire$22[33 +: 1];
  localparam logic[0:0] thread_0_wire$24 = 1'b1;
  assign thread_0_wire$25 = thread_0_wire$23 == thread_0_wire$24;
  localparam logic[0:0] thread_0_wire$26 = 1'b0;
  localparam logic[0:0] thread_0_wire$27 = 1'b0;
  localparam logic[0:0] thread_0_wire$28 = 1'b0;
  assign thread_0_wire$29 = valid1_q;
  localparam logic[0:0] thread_0_wire$30 = 1'b1;
  assign thread_0_wire$31 = thread_0_wire$29 == thread_0_wire$30;
  assign thread_0_wire$32 = packet1_q;
  assign thread_0_wire$33 = packet1_q;
  assign thread_0_wire$34 = thread_0_wire$33[33 +: 1];
  localparam logic[0:0] thread_0_wire$35 = 1'b1;
  assign thread_0_wire$36 = thread_0_wire$34 == thread_0_wire$35;
  localparam logic[0:0] thread_0_wire$37 = 1'b0;
  localparam logic[0:0] thread_0_wire$38 = 1'b0;
  localparam logic[0:0] thread_0_wire$39 = 1'b0;
  assign thread_0_wire$40 = valid0_q;
  localparam logic[0:0] thread_0_wire$41 = 1'b1;
  assign thread_0_wire$42 = thread_0_wire$40 == thread_0_wire$41;
  assign thread_0_wire$43 = valid1_q;
  localparam logic[0:0] thread_0_wire$44 = 1'b1;
  assign thread_0_wire$45 = thread_0_wire$43 == thread_0_wire$44;
  assign thread_0_wire$46 = thread_0_wire$42 & thread_0_wire$45;
  assign thread_0_wire$47 = rr1_q;
  localparam logic[0:0] thread_0_wire$48 = 1'b0;
  assign thread_0_wire$49 = thread_0_wire$47 == thread_0_wire$48;
  assign thread_0_wire$50 = packet0_q;
  localparam logic[0:0] thread_0_wire$51 = 1'b1;
  localparam logic[0:0] thread_0_wire$52 = 1'b0;
  assign thread_0_wire$53 = packet0_q;
  assign thread_0_wire$54 = thread_0_wire$53[33 +: 1];
  localparam logic[0:0] thread_0_wire$55 = 1'b0;
  assign thread_0_wire$56 = thread_0_wire$54 == thread_0_wire$55;
  localparam logic[0:0] thread_0_wire$57 = 1'b1;
  localparam logic[0:0] thread_0_wire$58 = 1'b0;
  assign thread_0_wire$59 = packet1_q;
  localparam logic[0:0] thread_0_wire$60 = 1'b0;
  localparam logic[0:0] thread_0_wire$61 = 1'b0;
  assign thread_0_wire$62 = packet1_q;
  assign thread_0_wire$63 = thread_0_wire$62[33 +: 1];
  localparam logic[0:0] thread_0_wire$64 = 1'b0;
  assign thread_0_wire$65 = thread_0_wire$63 == thread_0_wire$64;
  localparam logic[0:0] thread_0_wire$66 = 1'b1;
  localparam logic[0:0] thread_0_wire$67 = 1'b1;
  assign thread_0_wire$68 = valid0_q;
  localparam logic[0:0] thread_0_wire$69 = 1'b1;
  assign thread_0_wire$70 = thread_0_wire$68 == thread_0_wire$69;
  assign thread_0_wire$71 = packet0_q;
  localparam logic[0:0] thread_0_wire$72 = 1'b0;
  assign thread_0_wire$73 = packet0_q;
  assign thread_0_wire$74 = thread_0_wire$73[33 +: 1];
  localparam logic[0:0] thread_0_wire$75 = 1'b0;
  assign thread_0_wire$76 = thread_0_wire$74 == thread_0_wire$75;
  localparam logic[0:0] thread_0_wire$77 = 1'b1;
  localparam logic[0:0] thread_0_wire$78 = 1'b0;
  assign thread_0_wire$79 = valid1_q;
  localparam logic[0:0] thread_0_wire$80 = 1'b1;
  assign thread_0_wire$81 = thread_0_wire$79 == thread_0_wire$80;
  assign thread_0_wire$82 = packet1_q;
  localparam logic[0:0] thread_0_wire$83 = 1'b0;
  assign thread_0_wire$84 = packet1_q;
  assign thread_0_wire$85 = thread_0_wire$84[33 +: 1];
  localparam logic[0:0] thread_0_wire$86 = 1'b0;
  assign thread_0_wire$87 = thread_0_wire$85 == thread_0_wire$86;
  localparam logic[0:0] thread_0_wire$88 = 1'b1;
  localparam logic[0:0] thread_0_wire$89 = 1'b1;
  for (genvar i = 0; i < 51; i ++) begin : EVENTS0
    logic event_current;
    end
  logic _init_0;
  logic _thread_0_event_counter_42_1_q, _thread_0_event_counter_42_1_n;
  logic _thread_0_event_counter_40_1_q, _thread_0_event_counter_40_1_n;
  logic _thread_0_event_syncstate_39_q, _thread_0_event_syncstate_39_n;
  logic _thread_0_event_counter_35_1_q, _thread_0_event_counter_35_1_n;
  logic _thread_0_event_syncstate_34_q, _thread_0_event_syncstate_34_n;
  logic _thread_0_event_counter_31_1_q, _thread_0_event_counter_31_1_n;
  logic _thread_0_event_syncstate_29_q, _thread_0_event_syncstate_29_n;
  logic _thread_0_event_syncstate_27_q, _thread_0_event_syncstate_27_n;
  logic _thread_0_event_syncstate_23_q, _thread_0_event_syncstate_23_n;
  logic _thread_0_event_syncstate_19_q, _thread_0_event_syncstate_19_n;
  logic _thread_0_event_counter_14_1_q, _thread_0_event_counter_14_1_n;
  logic _thread_0_event_counter_12_1_q, _thread_0_event_counter_12_1_n;
  logic _thread_0_event_counter_7_1_q, _thread_0_event_counter_7_1_n;
  logic _thread_0_event_counter_5_1_q, _thread_0_event_counter_5_1_n;
  assign EVENTS0[50].event_current = EVENTS0[40].event_current && thread_0_wire$87;
  assign EVENTS0[49].event_current = EVENTS0[35].event_current && thread_0_wire$76;
  assign EVENTS0[48].event_current = EVENTS0[31].event_current && thread_0_wire$65;
  assign EVENTS0[47].event_current = EVENTS0[31].event_current && thread_0_wire$56;
  assign EVENTS0[46].event_current = EVENTS0[23].event_current && !thread_0_wire$36;
  assign EVENTS0[45].event_current = EVENTS0[23].event_current && thread_0_wire$36;
  assign EVENTS0[44].event_current = EVENTS0[19].event_current && !thread_0_wire$25;
  assign EVENTS0[43].event_current = EVENTS0[19].event_current && thread_0_wire$25;
  assign EVENTS0[42].event_current = _thread_0_event_counter_42_1_q;
  assign _thread_0_event_counter_42_1_n = EVENTS0[41].event_current;
  assign EVENTS0[41].event_current = EVENTS0[40].event_current || EVENTS0[37].event_current || EVENTS0[35].event_current || EVENTS0[31].event_current || EVENTS0[23].event_current || EVENTS0[21].event_current || EVENTS0[19].event_current || EVENTS0[17].event_current;
  assign EVENTS0[40].event_current = _thread_0_event_counter_40_1_q;
  assign _thread_0_event_counter_40_1_n = EVENTS0[39].event_current;
  assign EVENTS0[39].event_current = (EVENTS0[38].event_current || _thread_0_event_syncstate_39_q) && _out1_beat_ack;
    assign _thread_0_event_syncstate_39_n = (EVENTS0[38].event_current || _thread_0_event_syncstate_39_q) && !_out1_beat_ack;
  assign EVENTS0[38].event_current = EVENTS0[36].event_current && thread_0_wire$81;
  assign EVENTS0[37].event_current = EVENTS0[36].event_current && !thread_0_wire$81;
  assign EVENTS0[36].event_current = EVENTS0[32].event_current && !thread_0_wire$70;
  assign EVENTS0[35].event_current = _thread_0_event_counter_35_1_q;
  assign _thread_0_event_counter_35_1_n = EVENTS0[34].event_current;
  assign EVENTS0[34].event_current = (EVENTS0[33].event_current || _thread_0_event_syncstate_34_q) && _out1_beat_ack;
    assign _thread_0_event_syncstate_34_n = (EVENTS0[33].event_current || _thread_0_event_syncstate_34_q) && !_out1_beat_ack;
  assign EVENTS0[33].event_current = EVENTS0[32].event_current && thread_0_wire$70;
  assign EVENTS0[32].event_current = EVENTS0[24].event_current && !thread_0_wire$46;
  assign EVENTS0[31].event_current = _thread_0_event_counter_31_1_q;
  assign _thread_0_event_counter_31_1_n = EVENTS0[30].event_current;
  assign EVENTS0[30].event_current = EVENTS0[29].event_current || EVENTS0[27].event_current;
  assign EVENTS0[29].event_current = (EVENTS0[28].event_current || _thread_0_event_syncstate_29_q) && _out1_beat_ack;
    assign _thread_0_event_syncstate_29_n = (EVENTS0[28].event_current || _thread_0_event_syncstate_29_q) && !_out1_beat_ack;
  assign EVENTS0[28].event_current = EVENTS0[25].event_current && thread_0_wire$49;
  assign EVENTS0[27].event_current = (EVENTS0[26].event_current || _thread_0_event_syncstate_27_q) && _out1_beat_ack;
    assign _thread_0_event_syncstate_27_n = (EVENTS0[26].event_current || _thread_0_event_syncstate_27_q) && !_out1_beat_ack;
  assign EVENTS0[26].event_current = EVENTS0[25].event_current && !thread_0_wire$49;
  assign EVENTS0[25].event_current = EVENTS0[24].event_current && thread_0_wire$46;
  assign EVENTS0[24].event_current = EVENTS0[14].event_current && !thread_0_wire$14;
  assign EVENTS0[23].event_current = (EVENTS0[22].event_current || _thread_0_event_syncstate_23_q) && _out1_beat_ack;
    assign _thread_0_event_syncstate_23_n = (EVENTS0[22].event_current || _thread_0_event_syncstate_23_q) && !_out1_beat_ack;
  assign EVENTS0[22].event_current = EVENTS0[20].event_current && thread_0_wire$31;
  assign EVENTS0[21].event_current = EVENTS0[20].event_current && !thread_0_wire$31;
  assign EVENTS0[20].event_current = EVENTS0[15].event_current && !thread_0_wire$17;
  assign EVENTS0[19].event_current = (EVENTS0[18].event_current || _thread_0_event_syncstate_19_q) && _out1_beat_ack;
    assign _thread_0_event_syncstate_19_n = (EVENTS0[18].event_current || _thread_0_event_syncstate_19_q) && !_out1_beat_ack;
  assign EVENTS0[18].event_current = EVENTS0[16].event_current && thread_0_wire$20;
  assign EVENTS0[17].event_current = EVENTS0[16].event_current && !thread_0_wire$20;
  assign EVENTS0[16].event_current = EVENTS0[15].event_current && thread_0_wire$17;
  assign EVENTS0[15].event_current = EVENTS0[14].event_current && thread_0_wire$14;
  assign EVENTS0[14].event_current = _thread_0_event_counter_14_1_q;
  assign _thread_0_event_counter_14_1_n = EVENTS0[13].event_current;
  assign EVENTS0[13].event_current = EVENTS0[12].event_current || EVENTS0[10].event_current || EVENTS0[8].event_current;
  assign EVENTS0[12].event_current = _thread_0_event_counter_12_1_q;
  assign _thread_0_event_counter_12_1_n = EVENTS0[11].event_current;
  assign EVENTS0[11].event_current = EVENTS0[9].event_current && thread_0_wire$9;
  assign EVENTS0[10].event_current = EVENTS0[9].event_current && !thread_0_wire$9;
  assign EVENTS0[9].event_current = EVENTS0[7].event_current && thread_0_wire$8;
  assign EVENTS0[8].event_current = EVENTS0[7].event_current && !thread_0_wire$8;
  assign EVENTS0[7].event_current = _thread_0_event_counter_7_1_q;
  assign _thread_0_event_counter_7_1_n = EVENTS0[6].event_current;
  assign EVENTS0[6].event_current = EVENTS0[5].event_current || EVENTS0[3].event_current || EVENTS0[1].event_current;
  assign EVENTS0[5].event_current = _thread_0_event_counter_5_1_q;
  assign _thread_0_event_counter_5_1_n = EVENTS0[4].event_current;
  assign EVENTS0[4].event_current = EVENTS0[2].event_current && thread_0_wire$3;
  assign EVENTS0[3].event_current = EVENTS0[2].event_current && !thread_0_wire$3;
  assign EVENTS0[2].event_current = EVENTS0[0].event_current && thread_0_wire$2;
  assign EVENTS0[1].event_current = EVENTS0[0].event_current && !thread_0_wire$2;
  assign EVENTS0[0].event_current = _init_0 || EVENTS0[42].event_current;
  assign _from_in0_beat_ack = EVENTS0[4].event_current;
  assign _from_in1_beat_ack = EVENTS0[11].event_current;
  assign _out1_beat_valid = (EVENTS0[18].event_current || _thread_0_event_syncstate_19_q) || (EVENTS0[22].event_current || _thread_0_event_syncstate_23_q) || (EVENTS0[26].event_current || _thread_0_event_syncstate_27_q) || (EVENTS0[28].event_current || _thread_0_event_syncstate_29_q) || (EVENTS0[33].event_current || _thread_0_event_syncstate_34_q) || (EVENTS0[38].event_current || _thread_0_event_syncstate_39_q);
  logic[2:0] _out1_beat_valid_selector_q, _out1_beat_valid_selector_n;
  assign _out1_beat_0 = (_out1_beat_valid_selector_n == 3'd0) ? thread_0_wire$21 : (_out1_beat_valid_selector_n == 3'd1) ? thread_0_wire$32 : (_out1_beat_valid_selector_n == 3'd2) ? thread_0_wire$59 : (_out1_beat_valid_selector_n == 3'd3) ? thread_0_wire$50 : (_out1_beat_valid_selector_n == 3'd4) ? thread_0_wire$71 : (_out1_beat_valid_selector_n == 3'd5) ? thread_0_wire$82 : '0;
  always_comb begin: _thread_0_selector
    _out1_beat_valid_selector_n = _out1_beat_valid_selector_q;
    if ((EVENTS0[18].event_current || _thread_0_event_syncstate_19_q)) _out1_beat_valid_selector_n = 3'd0;
    if ((EVENTS0[22].event_current || _thread_0_event_syncstate_23_q)) _out1_beat_valid_selector_n = 3'd1;
    if ((EVENTS0[26].event_current || _thread_0_event_syncstate_27_q)) _out1_beat_valid_selector_n = 3'd2;
    if ((EVENTS0[28].event_current || _thread_0_event_syncstate_29_q)) _out1_beat_valid_selector_n = 3'd3;
    if ((EVENTS0[33].event_current || _thread_0_event_syncstate_34_q)) _out1_beat_valid_selector_n = 3'd4;
    if ((EVENTS0[38].event_current || _thread_0_event_syncstate_39_q)) _out1_beat_valid_selector_n = 3'd5;
  end
  always_ff @(posedge clk_i or negedge rst_ni) begin : _thread_0_selector_trans
    if (~rst_ni) begin
      _out1_beat_valid_selector_q <= '0;
    end else begin
      _out1_beat_valid_selector_q <= _out1_beat_valid_selector_n;
    end
  end
  always_ff @(posedge clk_i or negedge rst_ni) begin : _thread_0_st_transition
    if (~rst_ni) begin
      _init_0 <= 1'b1;
      lock1_q <= '0;
      owner1_q <= '0;
      packet0_q <= '0;
      packet1_q <= '0;
      rr1_q <= '0;
      valid0_q <= '0;
      valid1_q <= '0;
      _thread_0_event_counter_42_1_q <= '0;
      _thread_0_event_counter_40_1_q <= '0;
      _thread_0_event_syncstate_39_q <= '0;
      _thread_0_event_counter_35_1_q <= '0;
      _thread_0_event_syncstate_34_q <= '0;
      _thread_0_event_counter_31_1_q <= '0;
      _thread_0_event_syncstate_29_q <= '0;
      _thread_0_event_syncstate_27_q <= '0;
      _thread_0_event_syncstate_23_q <= '0;
      _thread_0_event_syncstate_19_q <= '0;
      _thread_0_event_counter_14_1_q <= '0;
      _thread_0_event_counter_12_1_q <= '0;
      _thread_0_event_counter_7_1_q <= '0;
      _thread_0_event_counter_5_1_q <= '0;
    end else begin
      if (EVENTS0[50].event_current) begin
        owner1_q[0 +: 1] <= thread_0_wire$89;
        lock1_q[0 +: 1] <= thread_0_wire$88;
      end
      if (EVENTS0[49].event_current) begin
        owner1_q[0 +: 1] <= thread_0_wire$78;
        lock1_q[0 +: 1] <= thread_0_wire$77;
      end
      if (EVENTS0[48].event_current) begin
        owner1_q[0 +: 1] <= thread_0_wire$67;
        lock1_q[0 +: 1] <= thread_0_wire$66;
      end
      if (EVENTS0[47].event_current) begin
        owner1_q[0 +: 1] <= thread_0_wire$58;
        lock1_q[0 +: 1] <= thread_0_wire$57;
      end
      if (EVENTS0[46].event_current) begin
        valid1_q[0 +: 1] <= thread_0_wire$39;
      end
      if (EVENTS0[45].event_current) begin
        lock1_q[0 +: 1] <= thread_0_wire$38;
        valid1_q[0 +: 1] <= thread_0_wire$37;
      end
      if (EVENTS0[44].event_current) begin
        valid0_q[0 +: 1] <= thread_0_wire$28;
      end
      if (EVENTS0[43].event_current) begin
        lock1_q[0 +: 1] <= thread_0_wire$27;
        valid0_q[0 +: 1] <= thread_0_wire$26;
      end
      if (EVENTS0[39].event_current) begin
        valid1_q[0 +: 1] <= thread_0_wire$83;
      end
      if (EVENTS0[34].event_current) begin
        valid0_q[0 +: 1] <= thread_0_wire$72;
      end
      if (EVENTS0[29].event_current) begin
        valid0_q[0 +: 1] <= thread_0_wire$52;
        rr1_q[0 +: 1] <= thread_0_wire$51;
      end
      if (EVENTS0[27].event_current) begin
        valid1_q[0 +: 1] <= thread_0_wire$61;
        rr1_q[0 +: 1] <= thread_0_wire$60;
      end
      if (EVENTS0[11].event_current) begin
        valid1_q[0 +: 1] <= thread_0_wire$11;
        packet1_q[0 +: 34] <= thread_0_wire$10;
      end
      if (EVENTS0[4].event_current) begin
        valid0_q[0 +: 1] <= thread_0_wire$5;
        packet0_q[0 +: 34] <= thread_0_wire$4;
      end
      _init_0 <= 1'b0;
      _thread_0_event_counter_42_1_q <= _thread_0_event_counter_42_1_n;
      _thread_0_event_counter_40_1_q <= _thread_0_event_counter_40_1_n;
      _thread_0_event_syncstate_39_q <= _thread_0_event_syncstate_39_n;
      _thread_0_event_counter_35_1_q <= _thread_0_event_counter_35_1_n;
      _thread_0_event_syncstate_34_q <= _thread_0_event_syncstate_34_n;
      _thread_0_event_counter_31_1_q <= _thread_0_event_counter_31_1_n;
      _thread_0_event_syncstate_29_q <= _thread_0_event_syncstate_29_n;
      _thread_0_event_syncstate_27_q <= _thread_0_event_syncstate_27_n;
      _thread_0_event_syncstate_23_q <= _thread_0_event_syncstate_23_n;
      _thread_0_event_syncstate_19_q <= _thread_0_event_syncstate_19_n;
      _thread_0_event_counter_14_1_q <= _thread_0_event_counter_14_1_n;
      _thread_0_event_counter_12_1_q <= _thread_0_event_counter_12_1_n;
      _thread_0_event_counter_7_1_q <= _thread_0_event_counter_7_1_n;
      _thread_0_event_counter_5_1_q <= _thread_0_event_counter_5_1_n;
    end
  end
endmodule
module Top (
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
  logic[0:0] _r00_left_beat_ack;
  logic[0:0] _r00_left_beat_valid;
  logic[33:0] _r00_left_beat_0;
  logic[0:0] _r01_left_beat_ack;
  logic[0:0] _r01_left_beat_valid;
  logic[33:0] _r01_left_beat_0;
  logic[0:0] _r10_left_beat_ack;
  logic[0:0] _r10_left_beat_valid;
  logic[33:0] _r10_left_beat_0;
  logic[0:0] _r11_left_beat_ack;
  logic[0:0] _r11_left_beat_valid;
  logic[33:0] _r11_left_beat_0;
  input0_router _spawn_0 (
    .clk_i,
    .rst_ni
    ,._in0_beat_valid (_in0_beat_valid)
    ,._in0_beat_ack (_in0_beat_ack)
    ,._in0_beat_0 (_in0_beat_0)
    ,._to_out0_beat_valid (_r00_left_beat_valid)
    ,._to_out0_beat_ack (_r00_left_beat_ack)
    ,._to_out0_beat_0 (_r00_left_beat_0)
    ,._to_out1_beat_valid (_r01_left_beat_valid)
    ,._to_out1_beat_ack (_r01_left_beat_ack)
    ,._to_out1_beat_0 (_r01_left_beat_0)
  );
  input1_router _spawn_1 (
    .clk_i,
    .rst_ni
    ,._in1_beat_valid (_in1_beat_valid)
    ,._in1_beat_ack (_in1_beat_ack)
    ,._in1_beat_0 (_in1_beat_0)
    ,._to_out0_beat_valid (_r10_left_beat_valid)
    ,._to_out0_beat_ack (_r10_left_beat_ack)
    ,._to_out0_beat_0 (_r10_left_beat_0)
    ,._to_out1_beat_valid (_r11_left_beat_valid)
    ,._to_out1_beat_ack (_r11_left_beat_ack)
    ,._to_out1_beat_0 (_r11_left_beat_0)
  );
  output0_arbiter _spawn_2 (
    .clk_i,
    .rst_ni
    ,._from_in0_beat_valid (_r00_left_beat_valid)
    ,._from_in0_beat_ack (_r00_left_beat_ack)
    ,._from_in0_beat_0 (_r00_left_beat_0)
    ,._from_in1_beat_valid (_r10_left_beat_valid)
    ,._from_in1_beat_ack (_r10_left_beat_ack)
    ,._from_in1_beat_0 (_r10_left_beat_0)
    ,._out0_beat_valid (_out0_beat_valid)
    ,._out0_beat_ack (_out0_beat_ack)
    ,._out0_beat_0 (_out0_beat_0)
  );
  output1_arbiter _spawn_3 (
    .clk_i,
    .rst_ni
    ,._from_in0_beat_valid (_r01_left_beat_valid)
    ,._from_in0_beat_ack (_r01_left_beat_ack)
    ,._from_in0_beat_0 (_r01_left_beat_0)
    ,._from_in1_beat_valid (_r11_left_beat_valid)
    ,._from_in1_beat_ack (_r11_left_beat_ack)
    ,._from_in1_beat_0 (_r11_left_beat_0)
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
