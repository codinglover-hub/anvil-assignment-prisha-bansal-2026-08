/* verilator lint_off UNOPTFLAT */
/* verilator lint_off WIDTHTRUNC */
/* verilator lint_off WIDTHEXPAND */
/* verilator lint_off WIDTHCONCAT */
module input0_route (
  input logic[0:0] clk_i,
  input logic[0:0] rst_ni,
  output logic[0:0] _inp_beat_ack,
  input logic[0:0] _inp_beat_valid,
  input logic[33:0] _inp_beat_0,
  input logic[0:0] _to_out0_beat_ack,
  output logic[0:0] _to_out0_beat_valid,
  output logic[33:0] _to_out0_beat_0,
  input logic[0:0] _to_out1_beat_ack,
  output logic[0:0] _to_out1_beat_valid,
  output logic[33:0] _to_out1_beat_0
);
  logic[0:0] dest_q;
  logic[33:0] packet_q;
  logic[0:0] valid_q;
  always_ff @(posedge clk_i or negedge rst_ni) begin : _proc_transition
    if (~rst_ni) begin
    end
  end
  logic[33:0] thread_0_wire$12;
  logic[33:0] thread_0_wire$10;
  logic[0:0] thread_0_wire$9;
  logic[0:0] thread_0_wire$7;
  logic[0:0] thread_0_wire$6;
  logic[0:0] thread_0_wire$4;
  logic[0:0] thread_0_wire$2;
  logic[33:0] thread_0_wire$1;
  logic[0:0] thread_0_wire$0;
  assign thread_0_wire$0 = _inp_beat_valid;
  assign thread_0_wire$1 = _inp_beat_0;
  assign thread_0_wire$2 = thread_0_wire$1[1 +: 1];
  localparam logic[0:0] thread_0_wire$3 = 1'b1;
  assign thread_0_wire$4 = valid_q;
  localparam logic[0:0] thread_0_wire$5 = 1'b1;
  assign thread_0_wire$6 = thread_0_wire$4 == thread_0_wire$5;
  assign thread_0_wire$7 = dest_q;
  localparam logic[0:0] thread_0_wire$8 = 1'b0;
  assign thread_0_wire$9 = thread_0_wire$7 == thread_0_wire$8;
  assign thread_0_wire$10 = packet_q;
  localparam logic[0:0] thread_0_wire$11 = 1'b0;
  assign thread_0_wire$12 = packet_q;
  localparam logic[0:0] thread_0_wire$13 = 1'b0;
  for (genvar i = 0; i < 11; i ++) begin : EVENTS0
    logic event_current;
    end
  logic _init_0;
  logic _thread_0_event_counter_9_1_q, _thread_0_event_counter_9_1_n;
  logic _thread_0_event_syncstate_7_q, _thread_0_event_syncstate_7_n;
  logic _thread_0_event_syncstate_5_q, _thread_0_event_syncstate_5_n;
  logic _thread_0_event_counter_1_1_q, _thread_0_event_counter_1_1_n;
  assign EVENTS0[10].event_current = EVENTS0[0].event_current && thread_0_wire$0;
  assign EVENTS0[9].event_current = _thread_0_event_counter_9_1_q;
  assign _thread_0_event_counter_9_1_n = EVENTS0[8].event_current;
  assign EVENTS0[8].event_current = EVENTS0[7].event_current || EVENTS0[5].event_current || EVENTS0[2].event_current;
  assign EVENTS0[7].event_current = (EVENTS0[6].event_current || _thread_0_event_syncstate_7_q) && _to_out0_beat_ack;
    assign _thread_0_event_syncstate_7_n = (EVENTS0[6].event_current || _thread_0_event_syncstate_7_q) && !_to_out0_beat_ack;
  assign EVENTS0[6].event_current = EVENTS0[3].event_current && thread_0_wire$9;
  assign EVENTS0[5].event_current = (EVENTS0[4].event_current || _thread_0_event_syncstate_5_q) && _to_out1_beat_ack;
    assign _thread_0_event_syncstate_5_n = (EVENTS0[4].event_current || _thread_0_event_syncstate_5_q) && !_to_out1_beat_ack;
  assign EVENTS0[4].event_current = EVENTS0[3].event_current && !thread_0_wire$9;
  assign EVENTS0[3].event_current = EVENTS0[1].event_current && thread_0_wire$6;
  assign EVENTS0[2].event_current = EVENTS0[1].event_current && !thread_0_wire$6;
  assign EVENTS0[1].event_current = _thread_0_event_counter_1_1_q;
  assign _thread_0_event_counter_1_1_n = EVENTS0[0].event_current;
  assign EVENTS0[0].event_current = _init_0 || EVENTS0[9].event_current;
  assign _inp_beat_ack = EVENTS0[10].event_current;
  assign _to_out1_beat_valid = (EVENTS0[4].event_current || _thread_0_event_syncstate_5_q);
  assign _to_out1_beat_0 = thread_0_wire$12;
  assign _to_out0_beat_valid = (EVENTS0[6].event_current || _thread_0_event_syncstate_7_q);
  assign _to_out0_beat_0 = thread_0_wire$10;
  always_ff @(posedge clk_i or negedge rst_ni) begin : _thread_0_st_transition
    if (~rst_ni) begin
      _init_0 <= 1'b1;
      dest_q <= '0;
      packet_q <= '0;
      valid_q <= '0;
      _thread_0_event_counter_9_1_q <= '0;
      _thread_0_event_syncstate_7_q <= '0;
      _thread_0_event_syncstate_5_q <= '0;
      _thread_0_event_counter_1_1_q <= '0;
    end else begin
      if (EVENTS0[10].event_current) begin
        valid_q[0 +: 1] <= thread_0_wire$3;
        dest_q[0 +: 1] <= thread_0_wire$2;
        packet_q[0 +: 34] <= thread_0_wire$1;
      end
      if (EVENTS0[7].event_current) begin
        valid_q[0 +: 1] <= thread_0_wire$11;
      end
      if (EVENTS0[5].event_current) begin
        valid_q[0 +: 1] <= thread_0_wire$13;
      end
      _init_0 <= 1'b0;
      _thread_0_event_counter_9_1_q <= _thread_0_event_counter_9_1_n;
      _thread_0_event_syncstate_7_q <= _thread_0_event_syncstate_7_n;
      _thread_0_event_syncstate_5_q <= _thread_0_event_syncstate_5_n;
      _thread_0_event_counter_1_1_q <= _thread_0_event_counter_1_1_n;
    end
  end
endmodule
module input1_route (
  input logic[0:0] clk_i,
  input logic[0:0] rst_ni,
  output logic[0:0] _inp_beat_ack,
  input logic[0:0] _inp_beat_valid,
  input logic[33:0] _inp_beat_0,
  input logic[0:0] _to_out0_beat_ack,
  output logic[0:0] _to_out0_beat_valid,
  output logic[33:0] _to_out0_beat_0,
  input logic[0:0] _to_out1_beat_ack,
  output logic[0:0] _to_out1_beat_valid,
  output logic[33:0] _to_out1_beat_0
);
  logic[0:0] dest_q;
  logic[33:0] packet_q;
  logic[0:0] valid_q;
  always_ff @(posedge clk_i or negedge rst_ni) begin : _proc_transition
    if (~rst_ni) begin
    end
  end
  logic[33:0] thread_0_wire$12;
  logic[33:0] thread_0_wire$10;
  logic[0:0] thread_0_wire$9;
  logic[0:0] thread_0_wire$7;
  logic[0:0] thread_0_wire$6;
  logic[0:0] thread_0_wire$4;
  logic[0:0] thread_0_wire$2;
  logic[33:0] thread_0_wire$1;
  logic[0:0] thread_0_wire$0;
  assign thread_0_wire$0 = _inp_beat_valid;
  assign thread_0_wire$1 = _inp_beat_0;
  assign thread_0_wire$2 = thread_0_wire$1[1 +: 1];
  localparam logic[0:0] thread_0_wire$3 = 1'b1;
  assign thread_0_wire$4 = valid_q;
  localparam logic[0:0] thread_0_wire$5 = 1'b1;
  assign thread_0_wire$6 = thread_0_wire$4 == thread_0_wire$5;
  assign thread_0_wire$7 = dest_q;
  localparam logic[0:0] thread_0_wire$8 = 1'b0;
  assign thread_0_wire$9 = thread_0_wire$7 == thread_0_wire$8;
  assign thread_0_wire$10 = packet_q;
  localparam logic[0:0] thread_0_wire$11 = 1'b0;
  assign thread_0_wire$12 = packet_q;
  localparam logic[0:0] thread_0_wire$13 = 1'b0;
  for (genvar i = 0; i < 11; i ++) begin : EVENTS0
    logic event_current;
    end
  logic _init_0;
  logic _thread_0_event_counter_9_1_q, _thread_0_event_counter_9_1_n;
  logic _thread_0_event_syncstate_7_q, _thread_0_event_syncstate_7_n;
  logic _thread_0_event_syncstate_5_q, _thread_0_event_syncstate_5_n;
  logic _thread_0_event_counter_1_1_q, _thread_0_event_counter_1_1_n;
  assign EVENTS0[10].event_current = EVENTS0[0].event_current && thread_0_wire$0;
  assign EVENTS0[9].event_current = _thread_0_event_counter_9_1_q;
  assign _thread_0_event_counter_9_1_n = EVENTS0[8].event_current;
  assign EVENTS0[8].event_current = EVENTS0[7].event_current || EVENTS0[5].event_current || EVENTS0[2].event_current;
  assign EVENTS0[7].event_current = (EVENTS0[6].event_current || _thread_0_event_syncstate_7_q) && _to_out0_beat_ack;
    assign _thread_0_event_syncstate_7_n = (EVENTS0[6].event_current || _thread_0_event_syncstate_7_q) && !_to_out0_beat_ack;
  assign EVENTS0[6].event_current = EVENTS0[3].event_current && thread_0_wire$9;
  assign EVENTS0[5].event_current = (EVENTS0[4].event_current || _thread_0_event_syncstate_5_q) && _to_out1_beat_ack;
    assign _thread_0_event_syncstate_5_n = (EVENTS0[4].event_current || _thread_0_event_syncstate_5_q) && !_to_out1_beat_ack;
  assign EVENTS0[4].event_current = EVENTS0[3].event_current && !thread_0_wire$9;
  assign EVENTS0[3].event_current = EVENTS0[1].event_current && thread_0_wire$6;
  assign EVENTS0[2].event_current = EVENTS0[1].event_current && !thread_0_wire$6;
  assign EVENTS0[1].event_current = _thread_0_event_counter_1_1_q;
  assign _thread_0_event_counter_1_1_n = EVENTS0[0].event_current;
  assign EVENTS0[0].event_current = _init_0 || EVENTS0[9].event_current;
  assign _inp_beat_ack = EVENTS0[10].event_current;
  assign _to_out1_beat_valid = (EVENTS0[4].event_current || _thread_0_event_syncstate_5_q);
  assign _to_out1_beat_0 = thread_0_wire$12;
  assign _to_out0_beat_valid = (EVENTS0[6].event_current || _thread_0_event_syncstate_7_q);
  assign _to_out0_beat_0 = thread_0_wire$10;
  always_ff @(posedge clk_i or negedge rst_ni) begin : _thread_0_st_transition
    if (~rst_ni) begin
      _init_0 <= 1'b1;
      dest_q <= '0;
      packet_q <= '0;
      valid_q <= '0;
      _thread_0_event_counter_9_1_q <= '0;
      _thread_0_event_syncstate_7_q <= '0;
      _thread_0_event_syncstate_5_q <= '0;
      _thread_0_event_counter_1_1_q <= '0;
    end else begin
      if (EVENTS0[10].event_current) begin
        valid_q[0 +: 1] <= thread_0_wire$3;
        dest_q[0 +: 1] <= thread_0_wire$2;
        packet_q[0 +: 34] <= thread_0_wire$1;
      end
      if (EVENTS0[7].event_current) begin
        valid_q[0 +: 1] <= thread_0_wire$11;
      end
      if (EVENTS0[5].event_current) begin
        valid_q[0 +: 1] <= thread_0_wire$13;
      end
      _init_0 <= 1'b0;
      _thread_0_event_counter_9_1_q <= _thread_0_event_counter_9_1_n;
      _thread_0_event_syncstate_7_q <= _thread_0_event_syncstate_7_n;
      _thread_0_event_syncstate_5_q <= _thread_0_event_syncstate_5_n;
      _thread_0_event_counter_1_1_q <= _thread_0_event_counter_1_1_n;
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
  logic[0:0] last0_q;
  logic[0:0] last1_q;
  logic[0:0] lock_q;
  logic[0:0] owner_q;
  logic[33:0] packet0_q;
  logic[33:0] packet1_q;
  logic[0:0] rr_q;
  logic[0:0] valid0_q;
  logic[0:0] valid1_q;
  logic[0:0] winner_q;
  always_ff @(posedge clk_i or negedge rst_ni) begin : _proc_transition
    if (~rst_ni) begin
    end
  end
  logic[0:0] thread_0_wire$104;
  logic[0:0] thread_0_wire$103;
  logic[0:0] thread_0_wire$102;
  logic[0:0] thread_0_wire$101;
  logic[0:0] thread_0_wire$100;
  logic[0:0] thread_0_wire$99;
  logic[0:0] thread_0_wire$98;
  logic[0:0] thread_0_wire$96;
  logic[0:0] thread_0_wire$94;
  logic[0:0] thread_0_wire$93;
  logic[0:0] thread_0_wire$92;
  logic[0:0] thread_0_wire$90;
  logic[0:0] thread_0_wire$88;
  logic[0:0] thread_0_wire$87;
  logic[0:0] thread_0_wire$85;
  logic[0:0] thread_0_wire$84;
  logic[0:0] thread_0_wire$82;
  logic[0:0] thread_0_wire$81;
  logic[0:0] thread_0_wire$79;
  logic[0:0] thread_0_wire$78;
  logic[0:0] thread_0_wire$75;
  logic[0:0] thread_0_wire$73;
  logic[0:0] thread_0_wire$72;
  logic[0:0] thread_0_wire$71;
  logic[0:0] thread_0_wire$70;
  logic[0:0] thread_0_wire$69;
  logic[0:0] thread_0_wire$66;
  logic[0:0] thread_0_wire$64;
  logic[0:0] thread_0_wire$63;
  logic[0:0] thread_0_wire$61;
  logic[0:0] thread_0_wire$60;
  logic[0:0] thread_0_wire$59;
  logic[0:0] thread_0_wire$58;
  logic[0:0] thread_0_wire$55;
  logic[0:0] thread_0_wire$53;
  logic[0:0] thread_0_wire$52;
  logic[0:0] thread_0_wire$50;
  logic[0:0] thread_0_wire$49;
  logic[0:0] thread_0_wire$47;
  logic[33:0] thread_0_wire$45;
  logic[0:0] thread_0_wire$44;
  logic[0:0] thread_0_wire$42;
  logic[33:0] thread_0_wire$40;
  logic[0:0] thread_0_wire$39;
  logic[0:0] thread_0_wire$37;
  logic[0:0] thread_0_wire$36;
  logic[0:0] thread_0_wire$34;
  logic[0:0] thread_0_wire$33;
  logic[0:0] thread_0_wire$32;
  logic[0:0] thread_0_wire$31;
  logic[0:0] thread_0_wire$28;
  logic[0:0] thread_0_wire$26;
  logic[0:0] thread_0_wire$25;
  logic[0:0] thread_0_wire$23;
  logic[0:0] thread_0_wire$20;
  logic[0:0] thread_0_wire$18;
  logic[0:0] thread_0_wire$17;
  logic[0:0] thread_0_wire$15;
  logic[0:0] thread_0_wire$14;
  logic[0:0] thread_0_wire$12;
  logic[0:0] thread_0_wire$11;
  logic[0:0] thread_0_wire$10;
  logic[0:0] thread_0_wire$8;
  logic[0:0] thread_0_wire$7;
  logic[33:0] thread_0_wire$5;
  logic[0:0] thread_0_wire$4;
  logic[0:0] thread_0_wire$3;
  logic[33:0] thread_0_wire$1;
  logic[0:0] thread_0_wire$0;
  assign thread_0_wire$0 = _from_in0_beat_valid;
  assign thread_0_wire$1 = _from_in0_beat_0;
  localparam logic[0:0] thread_0_wire$2 = 1'b1;
  assign thread_0_wire$3 = thread_0_wire$1[0 +: 1];
  assign thread_0_wire$4 = _from_in1_beat_valid;
  assign thread_0_wire$5 = _from_in1_beat_0;
  localparam logic[0:0] thread_0_wire$6 = 1'b1;
  assign thread_0_wire$7 = thread_0_wire$5[0 +: 1];
  assign thread_0_wire$8 = lock_q;
  localparam logic[0:0] thread_0_wire$9 = 1'b1;
  assign thread_0_wire$10 = thread_0_wire$8 == thread_0_wire$9;
  assign thread_0_wire$11 = owner_q;
  assign thread_0_wire$12 = valid0_q;
  localparam logic[0:0] thread_0_wire$13 = 1'b1;
  assign thread_0_wire$14 = thread_0_wire$12 == thread_0_wire$13;
  assign thread_0_wire$15 = valid1_q;
  localparam logic[0:0] thread_0_wire$16 = 1'b1;
  assign thread_0_wire$17 = thread_0_wire$15 == thread_0_wire$16;
  assign thread_0_wire$18 = rr_q;
  localparam logic[0:0] thread_0_wire$19 = 1'b0;
  assign thread_0_wire$20 = thread_0_wire$18 == thread_0_wire$19;
  localparam logic[0:0] thread_0_wire$21 = 1'b0;
  localparam logic[0:0] thread_0_wire$22 = 1'b1;
  assign thread_0_wire$23 = (thread_0_wire$20) ? thread_0_wire$21 : thread_0_wire$22;
  localparam logic[0:0] thread_0_wire$24 = 1'b0;
  assign thread_0_wire$25 = (thread_0_wire$17) ? thread_0_wire$23 : thread_0_wire$24;
  assign thread_0_wire$26 = valid1_q;
  localparam logic[0:0] thread_0_wire$27 = 1'b1;
  assign thread_0_wire$28 = thread_0_wire$26 == thread_0_wire$27;
  localparam logic[0:0] thread_0_wire$29 = 1'b1;
  localparam logic[0:0] thread_0_wire$30 = 1'b0;
  assign thread_0_wire$31 = (thread_0_wire$28) ? thread_0_wire$29 : thread_0_wire$30;
  assign thread_0_wire$32 = (thread_0_wire$14) ? thread_0_wire$25 : thread_0_wire$31;
  assign thread_0_wire$33 = (thread_0_wire$10) ? thread_0_wire$11 : thread_0_wire$32;
  assign thread_0_wire$34 = winner_q;
  localparam logic[0:0] thread_0_wire$35 = 1'b0;
  assign thread_0_wire$36 = thread_0_wire$34 == thread_0_wire$35;
  assign thread_0_wire$37 = valid0_q;
  localparam logic[0:0] thread_0_wire$38 = 1'b1;
  assign thread_0_wire$39 = thread_0_wire$37 == thread_0_wire$38;
  assign thread_0_wire$40 = packet0_q;
  localparam logic[0:0] thread_0_wire$41 = 1'b0;
  assign thread_0_wire$42 = valid1_q;
  localparam logic[0:0] thread_0_wire$43 = 1'b1;
  assign thread_0_wire$44 = thread_0_wire$42 == thread_0_wire$43;
  assign thread_0_wire$45 = packet1_q;
  localparam logic[0:0] thread_0_wire$46 = 1'b0;
  assign thread_0_wire$47 = winner_q;
  localparam logic[0:0] thread_0_wire$48 = 1'b0;
  assign thread_0_wire$49 = thread_0_wire$47 == thread_0_wire$48;
  assign thread_0_wire$50 = valid0_q;
  localparam logic[0:0] thread_0_wire$51 = 1'b1;
  assign thread_0_wire$52 = thread_0_wire$50 == thread_0_wire$51;
  assign thread_0_wire$53 = last0_q;
  localparam logic[0:0] thread_0_wire$54 = 1'b1;
  assign thread_0_wire$55 = thread_0_wire$53 == thread_0_wire$54;
  localparam logic[0:0] thread_0_wire$56 = 1'b0;
  localparam logic[0:0] thread_0_wire$57 = 1'b1;
  assign thread_0_wire$58 = (thread_0_wire$55) ? thread_0_wire$56 : thread_0_wire$57;
  assign thread_0_wire$59 = lock_q;
  assign thread_0_wire$60 = (thread_0_wire$52) ? thread_0_wire$58 : thread_0_wire$59;
  assign thread_0_wire$61 = valid1_q;
  localparam logic[0:0] thread_0_wire$62 = 1'b1;
  assign thread_0_wire$63 = thread_0_wire$61 == thread_0_wire$62;
  assign thread_0_wire$64 = last1_q;
  localparam logic[0:0] thread_0_wire$65 = 1'b1;
  assign thread_0_wire$66 = thread_0_wire$64 == thread_0_wire$65;
  localparam logic[0:0] thread_0_wire$67 = 1'b0;
  localparam logic[0:0] thread_0_wire$68 = 1'b1;
  assign thread_0_wire$69 = (thread_0_wire$66) ? thread_0_wire$67 : thread_0_wire$68;
  assign thread_0_wire$70 = lock_q;
  assign thread_0_wire$71 = (thread_0_wire$63) ? thread_0_wire$69 : thread_0_wire$70;
  assign thread_0_wire$72 = (thread_0_wire$49) ? thread_0_wire$60 : thread_0_wire$71;
  assign thread_0_wire$73 = winner_q;
  localparam logic[0:0] thread_0_wire$74 = 1'b0;
  assign thread_0_wire$75 = thread_0_wire$73 == thread_0_wire$74;
  localparam logic[0:0] thread_0_wire$76 = 1'b0;
  localparam logic[0:0] thread_0_wire$77 = 1'b1;
  assign thread_0_wire$78 = (thread_0_wire$75) ? thread_0_wire$76 : thread_0_wire$77;
  assign thread_0_wire$79 = valid0_q;
  localparam logic[0:0] thread_0_wire$80 = 1'b1;
  assign thread_0_wire$81 = thread_0_wire$79 == thread_0_wire$80;
  assign thread_0_wire$82 = valid1_q;
  localparam logic[0:0] thread_0_wire$83 = 1'b1;
  assign thread_0_wire$84 = thread_0_wire$82 == thread_0_wire$83;
  assign thread_0_wire$85 = winner_q;
  localparam logic[0:0] thread_0_wire$86 = 1'b0;
  assign thread_0_wire$87 = thread_0_wire$85 == thread_0_wire$86;
  assign thread_0_wire$88 = last0_q;
  localparam logic[0:0] thread_0_wire$89 = 1'b1;
  assign thread_0_wire$90 = thread_0_wire$88 == thread_0_wire$89;
  localparam logic[0:0] thread_0_wire$91 = 1'b1;
  assign thread_0_wire$92 = rr_q;
  assign thread_0_wire$93 = (thread_0_wire$90) ? thread_0_wire$91 : thread_0_wire$92;
  assign thread_0_wire$94 = last1_q;
  localparam logic[0:0] thread_0_wire$95 = 1'b1;
  assign thread_0_wire$96 = thread_0_wire$94 == thread_0_wire$95;
  localparam logic[0:0] thread_0_wire$97 = 1'b0;
  assign thread_0_wire$98 = rr_q;
  assign thread_0_wire$99 = (thread_0_wire$96) ? thread_0_wire$97 : thread_0_wire$98;
  assign thread_0_wire$100 = (thread_0_wire$87) ? thread_0_wire$93 : thread_0_wire$99;
  assign thread_0_wire$101 = rr_q;
  assign thread_0_wire$102 = (thread_0_wire$84) ? thread_0_wire$100 : thread_0_wire$101;
  assign thread_0_wire$103 = rr_q;
  assign thread_0_wire$104 = (thread_0_wire$81) ? thread_0_wire$102 : thread_0_wire$103;
  for (genvar i = 0; i < 16; i ++) begin : EVENTS0
    logic event_current;
    end
  logic _init_0;
  logic _thread_0_event_counter_13_1_q, _thread_0_event_counter_13_1_n;
  logic _thread_0_event_counter_12_1_q, _thread_0_event_counter_12_1_n;
  logic _thread_0_event_syncstate_10_q, _thread_0_event_syncstate_10_n;
  logic _thread_0_event_syncstate_6_q, _thread_0_event_syncstate_6_n;
  logic _thread_0_event_counter_2_1_q, _thread_0_event_counter_2_1_n;
  logic _thread_0_event_counter_1_1_q, _thread_0_event_counter_1_1_n;
  assign EVENTS0[15].event_current = EVENTS0[0].event_current && thread_0_wire$0;
  assign EVENTS0[14].event_current = EVENTS0[1].event_current && thread_0_wire$4;
  assign EVENTS0[13].event_current = _thread_0_event_counter_13_1_q;
  assign _thread_0_event_counter_13_1_n = EVENTS0[12].event_current;
  assign EVENTS0[12].event_current = _thread_0_event_counter_12_1_q;
  assign _thread_0_event_counter_12_1_n = EVENTS0[11].event_current;
  assign EVENTS0[11].event_current = EVENTS0[10].event_current || EVENTS0[8].event_current || EVENTS0[6].event_current || EVENTS0[4].event_current;
  assign EVENTS0[10].event_current = (EVENTS0[9].event_current || _thread_0_event_syncstate_10_q) && _out0_beat_ack;
    assign _thread_0_event_syncstate_10_n = (EVENTS0[9].event_current || _thread_0_event_syncstate_10_q) && !_out0_beat_ack;
  assign EVENTS0[9].event_current = EVENTS0[7].event_current && thread_0_wire$44;
  assign EVENTS0[8].event_current = EVENTS0[7].event_current && !thread_0_wire$44;
  assign EVENTS0[7].event_current = EVENTS0[2].event_current && !thread_0_wire$36;
  assign EVENTS0[6].event_current = (EVENTS0[5].event_current || _thread_0_event_syncstate_6_q) && _out0_beat_ack;
    assign _thread_0_event_syncstate_6_n = (EVENTS0[5].event_current || _thread_0_event_syncstate_6_q) && !_out0_beat_ack;
  assign EVENTS0[5].event_current = EVENTS0[3].event_current && thread_0_wire$39;
  assign EVENTS0[4].event_current = EVENTS0[3].event_current && !thread_0_wire$39;
  assign EVENTS0[3].event_current = EVENTS0[2].event_current && thread_0_wire$36;
  assign EVENTS0[2].event_current = _thread_0_event_counter_2_1_q;
  assign _thread_0_event_counter_2_1_n = EVENTS0[1].event_current;
  assign EVENTS0[1].event_current = _thread_0_event_counter_1_1_q;
  assign _thread_0_event_counter_1_1_n = EVENTS0[0].event_current;
  assign EVENTS0[0].event_current = _init_0 || EVENTS0[13].event_current;
  assign _from_in0_beat_ack = EVENTS0[15].event_current;
  assign _from_in1_beat_ack = EVENTS0[14].event_current;
  assign _out0_beat_valid = (EVENTS0[5].event_current || _thread_0_event_syncstate_6_q) || (EVENTS0[9].event_current || _thread_0_event_syncstate_10_q);
  logic[0:0] _out0_beat_valid_selector_q, _out0_beat_valid_selector_n;
  assign _out0_beat_0 = (_out0_beat_valid_selector_n == 1'd0) ? thread_0_wire$40 : (_out0_beat_valid_selector_n == 1'd1) ? thread_0_wire$45 : '0;
  always_comb begin: _thread_0_selector
    _out0_beat_valid_selector_n = _out0_beat_valid_selector_q;
    if ((EVENTS0[5].event_current || _thread_0_event_syncstate_6_q)) _out0_beat_valid_selector_n = 1'd0;
    if ((EVENTS0[9].event_current || _thread_0_event_syncstate_10_q)) _out0_beat_valid_selector_n = 1'd1;
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
      last0_q <= '0;
      last1_q <= '0;
      lock_q <= '0;
      owner_q <= '0;
      packet0_q <= '0;
      packet1_q <= '0;
      rr_q <= '0;
      valid0_q <= '0;
      valid1_q <= '0;
      winner_q <= '0;
      _thread_0_event_counter_13_1_q <= '0;
      _thread_0_event_counter_12_1_q <= '0;
      _thread_0_event_syncstate_10_q <= '0;
      _thread_0_event_syncstate_6_q <= '0;
      _thread_0_event_counter_2_1_q <= '0;
      _thread_0_event_counter_1_1_q <= '0;
    end else begin
      if (EVENTS0[15].event_current) begin
        last0_q[0 +: 1] <= thread_0_wire$3;
        valid0_q[0 +: 1] <= thread_0_wire$2;
        packet0_q[0 +: 34] <= thread_0_wire$1;
      end
      if (EVENTS0[14].event_current) begin
        last1_q[0 +: 1] <= thread_0_wire$7;
        valid1_q[0 +: 1] <= thread_0_wire$6;
        packet1_q[0 +: 34] <= thread_0_wire$5;
      end
      if (EVENTS0[12].event_current) begin
        rr_q[0 +: 1] <= thread_0_wire$104;
        owner_q[0 +: 1] <= thread_0_wire$78;
        lock_q[0 +: 1] <= thread_0_wire$72;
      end
      if (EVENTS0[10].event_current) begin
        valid1_q[0 +: 1] <= thread_0_wire$46;
      end
      if (EVENTS0[6].event_current) begin
        valid0_q[0 +: 1] <= thread_0_wire$41;
      end
      if (EVENTS0[2].event_current) begin
        winner_q[0 +: 1] <= thread_0_wire$33;
      end
      _init_0 <= 1'b0;
      _thread_0_event_counter_13_1_q <= _thread_0_event_counter_13_1_n;
      _thread_0_event_counter_12_1_q <= _thread_0_event_counter_12_1_n;
      _thread_0_event_syncstate_10_q <= _thread_0_event_syncstate_10_n;
      _thread_0_event_syncstate_6_q <= _thread_0_event_syncstate_6_n;
      _thread_0_event_counter_2_1_q <= _thread_0_event_counter_2_1_n;
      _thread_0_event_counter_1_1_q <= _thread_0_event_counter_1_1_n;
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
  logic[0:0] last0_q;
  logic[0:0] last1_q;
  logic[0:0] lock_q;
  logic[0:0] owner_q;
  logic[33:0] packet0_q;
  logic[33:0] packet1_q;
  logic[0:0] rr_q;
  logic[0:0] valid0_q;
  logic[0:0] valid1_q;
  logic[0:0] winner_q;
  always_ff @(posedge clk_i or negedge rst_ni) begin : _proc_transition
    if (~rst_ni) begin
    end
  end
  logic[0:0] thread_0_wire$104;
  logic[0:0] thread_0_wire$103;
  logic[0:0] thread_0_wire$102;
  logic[0:0] thread_0_wire$101;
  logic[0:0] thread_0_wire$100;
  logic[0:0] thread_0_wire$99;
  logic[0:0] thread_0_wire$98;
  logic[0:0] thread_0_wire$96;
  logic[0:0] thread_0_wire$94;
  logic[0:0] thread_0_wire$93;
  logic[0:0] thread_0_wire$92;
  logic[0:0] thread_0_wire$90;
  logic[0:0] thread_0_wire$88;
  logic[0:0] thread_0_wire$87;
  logic[0:0] thread_0_wire$85;
  logic[0:0] thread_0_wire$84;
  logic[0:0] thread_0_wire$82;
  logic[0:0] thread_0_wire$81;
  logic[0:0] thread_0_wire$79;
  logic[0:0] thread_0_wire$78;
  logic[0:0] thread_0_wire$75;
  logic[0:0] thread_0_wire$73;
  logic[0:0] thread_0_wire$72;
  logic[0:0] thread_0_wire$71;
  logic[0:0] thread_0_wire$70;
  logic[0:0] thread_0_wire$69;
  logic[0:0] thread_0_wire$66;
  logic[0:0] thread_0_wire$64;
  logic[0:0] thread_0_wire$63;
  logic[0:0] thread_0_wire$61;
  logic[0:0] thread_0_wire$60;
  logic[0:0] thread_0_wire$59;
  logic[0:0] thread_0_wire$58;
  logic[0:0] thread_0_wire$55;
  logic[0:0] thread_0_wire$53;
  logic[0:0] thread_0_wire$52;
  logic[0:0] thread_0_wire$50;
  logic[0:0] thread_0_wire$49;
  logic[0:0] thread_0_wire$47;
  logic[33:0] thread_0_wire$45;
  logic[0:0] thread_0_wire$44;
  logic[0:0] thread_0_wire$42;
  logic[33:0] thread_0_wire$40;
  logic[0:0] thread_0_wire$39;
  logic[0:0] thread_0_wire$37;
  logic[0:0] thread_0_wire$36;
  logic[0:0] thread_0_wire$34;
  logic[0:0] thread_0_wire$33;
  logic[0:0] thread_0_wire$32;
  logic[0:0] thread_0_wire$31;
  logic[0:0] thread_0_wire$28;
  logic[0:0] thread_0_wire$26;
  logic[0:0] thread_0_wire$25;
  logic[0:0] thread_0_wire$23;
  logic[0:0] thread_0_wire$20;
  logic[0:0] thread_0_wire$18;
  logic[0:0] thread_0_wire$17;
  logic[0:0] thread_0_wire$15;
  logic[0:0] thread_0_wire$14;
  logic[0:0] thread_0_wire$12;
  logic[0:0] thread_0_wire$11;
  logic[0:0] thread_0_wire$10;
  logic[0:0] thread_0_wire$8;
  logic[0:0] thread_0_wire$7;
  logic[33:0] thread_0_wire$5;
  logic[0:0] thread_0_wire$4;
  logic[0:0] thread_0_wire$3;
  logic[33:0] thread_0_wire$1;
  logic[0:0] thread_0_wire$0;
  assign thread_0_wire$0 = _from_in0_beat_valid;
  assign thread_0_wire$1 = _from_in0_beat_0;
  localparam logic[0:0] thread_0_wire$2 = 1'b1;
  assign thread_0_wire$3 = thread_0_wire$1[0 +: 1];
  assign thread_0_wire$4 = _from_in1_beat_valid;
  assign thread_0_wire$5 = _from_in1_beat_0;
  localparam logic[0:0] thread_0_wire$6 = 1'b1;
  assign thread_0_wire$7 = thread_0_wire$5[0 +: 1];
  assign thread_0_wire$8 = lock_q;
  localparam logic[0:0] thread_0_wire$9 = 1'b1;
  assign thread_0_wire$10 = thread_0_wire$8 == thread_0_wire$9;
  assign thread_0_wire$11 = owner_q;
  assign thread_0_wire$12 = valid0_q;
  localparam logic[0:0] thread_0_wire$13 = 1'b1;
  assign thread_0_wire$14 = thread_0_wire$12 == thread_0_wire$13;
  assign thread_0_wire$15 = valid1_q;
  localparam logic[0:0] thread_0_wire$16 = 1'b1;
  assign thread_0_wire$17 = thread_0_wire$15 == thread_0_wire$16;
  assign thread_0_wire$18 = rr_q;
  localparam logic[0:0] thread_0_wire$19 = 1'b0;
  assign thread_0_wire$20 = thread_0_wire$18 == thread_0_wire$19;
  localparam logic[0:0] thread_0_wire$21 = 1'b0;
  localparam logic[0:0] thread_0_wire$22 = 1'b1;
  assign thread_0_wire$23 = (thread_0_wire$20) ? thread_0_wire$21 : thread_0_wire$22;
  localparam logic[0:0] thread_0_wire$24 = 1'b0;
  assign thread_0_wire$25 = (thread_0_wire$17) ? thread_0_wire$23 : thread_0_wire$24;
  assign thread_0_wire$26 = valid1_q;
  localparam logic[0:0] thread_0_wire$27 = 1'b1;
  assign thread_0_wire$28 = thread_0_wire$26 == thread_0_wire$27;
  localparam logic[0:0] thread_0_wire$29 = 1'b1;
  localparam logic[0:0] thread_0_wire$30 = 1'b0;
  assign thread_0_wire$31 = (thread_0_wire$28) ? thread_0_wire$29 : thread_0_wire$30;
  assign thread_0_wire$32 = (thread_0_wire$14) ? thread_0_wire$25 : thread_0_wire$31;
  assign thread_0_wire$33 = (thread_0_wire$10) ? thread_0_wire$11 : thread_0_wire$32;
  assign thread_0_wire$34 = winner_q;
  localparam logic[0:0] thread_0_wire$35 = 1'b0;
  assign thread_0_wire$36 = thread_0_wire$34 == thread_0_wire$35;
  assign thread_0_wire$37 = valid0_q;
  localparam logic[0:0] thread_0_wire$38 = 1'b1;
  assign thread_0_wire$39 = thread_0_wire$37 == thread_0_wire$38;
  assign thread_0_wire$40 = packet0_q;
  localparam logic[0:0] thread_0_wire$41 = 1'b0;
  assign thread_0_wire$42 = valid1_q;
  localparam logic[0:0] thread_0_wire$43 = 1'b1;
  assign thread_0_wire$44 = thread_0_wire$42 == thread_0_wire$43;
  assign thread_0_wire$45 = packet1_q;
  localparam logic[0:0] thread_0_wire$46 = 1'b0;
  assign thread_0_wire$47 = winner_q;
  localparam logic[0:0] thread_0_wire$48 = 1'b0;
  assign thread_0_wire$49 = thread_0_wire$47 == thread_0_wire$48;
  assign thread_0_wire$50 = valid0_q;
  localparam logic[0:0] thread_0_wire$51 = 1'b1;
  assign thread_0_wire$52 = thread_0_wire$50 == thread_0_wire$51;
  assign thread_0_wire$53 = last0_q;
  localparam logic[0:0] thread_0_wire$54 = 1'b1;
  assign thread_0_wire$55 = thread_0_wire$53 == thread_0_wire$54;
  localparam logic[0:0] thread_0_wire$56 = 1'b0;
  localparam logic[0:0] thread_0_wire$57 = 1'b1;
  assign thread_0_wire$58 = (thread_0_wire$55) ? thread_0_wire$56 : thread_0_wire$57;
  assign thread_0_wire$59 = lock_q;
  assign thread_0_wire$60 = (thread_0_wire$52) ? thread_0_wire$58 : thread_0_wire$59;
  assign thread_0_wire$61 = valid1_q;
  localparam logic[0:0] thread_0_wire$62 = 1'b1;
  assign thread_0_wire$63 = thread_0_wire$61 == thread_0_wire$62;
  assign thread_0_wire$64 = last1_q;
  localparam logic[0:0] thread_0_wire$65 = 1'b1;
  assign thread_0_wire$66 = thread_0_wire$64 == thread_0_wire$65;
  localparam logic[0:0] thread_0_wire$67 = 1'b0;
  localparam logic[0:0] thread_0_wire$68 = 1'b1;
  assign thread_0_wire$69 = (thread_0_wire$66) ? thread_0_wire$67 : thread_0_wire$68;
  assign thread_0_wire$70 = lock_q;
  assign thread_0_wire$71 = (thread_0_wire$63) ? thread_0_wire$69 : thread_0_wire$70;
  assign thread_0_wire$72 = (thread_0_wire$49) ? thread_0_wire$60 : thread_0_wire$71;
  assign thread_0_wire$73 = winner_q;
  localparam logic[0:0] thread_0_wire$74 = 1'b0;
  assign thread_0_wire$75 = thread_0_wire$73 == thread_0_wire$74;
  localparam logic[0:0] thread_0_wire$76 = 1'b0;
  localparam logic[0:0] thread_0_wire$77 = 1'b1;
  assign thread_0_wire$78 = (thread_0_wire$75) ? thread_0_wire$76 : thread_0_wire$77;
  assign thread_0_wire$79 = valid0_q;
  localparam logic[0:0] thread_0_wire$80 = 1'b1;
  assign thread_0_wire$81 = thread_0_wire$79 == thread_0_wire$80;
  assign thread_0_wire$82 = valid1_q;
  localparam logic[0:0] thread_0_wire$83 = 1'b1;
  assign thread_0_wire$84 = thread_0_wire$82 == thread_0_wire$83;
  assign thread_0_wire$85 = winner_q;
  localparam logic[0:0] thread_0_wire$86 = 1'b0;
  assign thread_0_wire$87 = thread_0_wire$85 == thread_0_wire$86;
  assign thread_0_wire$88 = last0_q;
  localparam logic[0:0] thread_0_wire$89 = 1'b1;
  assign thread_0_wire$90 = thread_0_wire$88 == thread_0_wire$89;
  localparam logic[0:0] thread_0_wire$91 = 1'b1;
  assign thread_0_wire$92 = rr_q;
  assign thread_0_wire$93 = (thread_0_wire$90) ? thread_0_wire$91 : thread_0_wire$92;
  assign thread_0_wire$94 = last1_q;
  localparam logic[0:0] thread_0_wire$95 = 1'b1;
  assign thread_0_wire$96 = thread_0_wire$94 == thread_0_wire$95;
  localparam logic[0:0] thread_0_wire$97 = 1'b0;
  assign thread_0_wire$98 = rr_q;
  assign thread_0_wire$99 = (thread_0_wire$96) ? thread_0_wire$97 : thread_0_wire$98;
  assign thread_0_wire$100 = (thread_0_wire$87) ? thread_0_wire$93 : thread_0_wire$99;
  assign thread_0_wire$101 = rr_q;
  assign thread_0_wire$102 = (thread_0_wire$84) ? thread_0_wire$100 : thread_0_wire$101;
  assign thread_0_wire$103 = rr_q;
  assign thread_0_wire$104 = (thread_0_wire$81) ? thread_0_wire$102 : thread_0_wire$103;
  for (genvar i = 0; i < 16; i ++) begin : EVENTS0
    logic event_current;
    end
  logic _init_0;
  logic _thread_0_event_counter_13_1_q, _thread_0_event_counter_13_1_n;
  logic _thread_0_event_counter_12_1_q, _thread_0_event_counter_12_1_n;
  logic _thread_0_event_syncstate_10_q, _thread_0_event_syncstate_10_n;
  logic _thread_0_event_syncstate_6_q, _thread_0_event_syncstate_6_n;
  logic _thread_0_event_counter_2_1_q, _thread_0_event_counter_2_1_n;
  logic _thread_0_event_counter_1_1_q, _thread_0_event_counter_1_1_n;
  assign EVENTS0[15].event_current = EVENTS0[0].event_current && thread_0_wire$0;
  assign EVENTS0[14].event_current = EVENTS0[1].event_current && thread_0_wire$4;
  assign EVENTS0[13].event_current = _thread_0_event_counter_13_1_q;
  assign _thread_0_event_counter_13_1_n = EVENTS0[12].event_current;
  assign EVENTS0[12].event_current = _thread_0_event_counter_12_1_q;
  assign _thread_0_event_counter_12_1_n = EVENTS0[11].event_current;
  assign EVENTS0[11].event_current = EVENTS0[10].event_current || EVENTS0[8].event_current || EVENTS0[6].event_current || EVENTS0[4].event_current;
  assign EVENTS0[10].event_current = (EVENTS0[9].event_current || _thread_0_event_syncstate_10_q) && _out1_beat_ack;
    assign _thread_0_event_syncstate_10_n = (EVENTS0[9].event_current || _thread_0_event_syncstate_10_q) && !_out1_beat_ack;
  assign EVENTS0[9].event_current = EVENTS0[7].event_current && thread_0_wire$44;
  assign EVENTS0[8].event_current = EVENTS0[7].event_current && !thread_0_wire$44;
  assign EVENTS0[7].event_current = EVENTS0[2].event_current && !thread_0_wire$36;
  assign EVENTS0[6].event_current = (EVENTS0[5].event_current || _thread_0_event_syncstate_6_q) && _out1_beat_ack;
    assign _thread_0_event_syncstate_6_n = (EVENTS0[5].event_current || _thread_0_event_syncstate_6_q) && !_out1_beat_ack;
  assign EVENTS0[5].event_current = EVENTS0[3].event_current && thread_0_wire$39;
  assign EVENTS0[4].event_current = EVENTS0[3].event_current && !thread_0_wire$39;
  assign EVENTS0[3].event_current = EVENTS0[2].event_current && thread_0_wire$36;
  assign EVENTS0[2].event_current = _thread_0_event_counter_2_1_q;
  assign _thread_0_event_counter_2_1_n = EVENTS0[1].event_current;
  assign EVENTS0[1].event_current = _thread_0_event_counter_1_1_q;
  assign _thread_0_event_counter_1_1_n = EVENTS0[0].event_current;
  assign EVENTS0[0].event_current = _init_0 || EVENTS0[13].event_current;
  assign _from_in0_beat_ack = EVENTS0[15].event_current;
  assign _from_in1_beat_ack = EVENTS0[14].event_current;
  assign _out1_beat_valid = (EVENTS0[5].event_current || _thread_0_event_syncstate_6_q) || (EVENTS0[9].event_current || _thread_0_event_syncstate_10_q);
  logic[0:0] _out1_beat_valid_selector_q, _out1_beat_valid_selector_n;
  assign _out1_beat_0 = (_out1_beat_valid_selector_n == 1'd0) ? thread_0_wire$40 : (_out1_beat_valid_selector_n == 1'd1) ? thread_0_wire$45 : '0;
  always_comb begin: _thread_0_selector
    _out1_beat_valid_selector_n = _out1_beat_valid_selector_q;
    if ((EVENTS0[5].event_current || _thread_0_event_syncstate_6_q)) _out1_beat_valid_selector_n = 1'd0;
    if ((EVENTS0[9].event_current || _thread_0_event_syncstate_10_q)) _out1_beat_valid_selector_n = 1'd1;
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
      last0_q <= '0;
      last1_q <= '0;
      lock_q <= '0;
      owner_q <= '0;
      packet0_q <= '0;
      packet1_q <= '0;
      rr_q <= '0;
      valid0_q <= '0;
      valid1_q <= '0;
      winner_q <= '0;
      _thread_0_event_counter_13_1_q <= '0;
      _thread_0_event_counter_12_1_q <= '0;
      _thread_0_event_syncstate_10_q <= '0;
      _thread_0_event_syncstate_6_q <= '0;
      _thread_0_event_counter_2_1_q <= '0;
      _thread_0_event_counter_1_1_q <= '0;
    end else begin
      if (EVENTS0[15].event_current) begin
        last0_q[0 +: 1] <= thread_0_wire$3;
        valid0_q[0 +: 1] <= thread_0_wire$2;
        packet0_q[0 +: 34] <= thread_0_wire$1;
      end
      if (EVENTS0[14].event_current) begin
        last1_q[0 +: 1] <= thread_0_wire$7;
        valid1_q[0 +: 1] <= thread_0_wire$6;
        packet1_q[0 +: 34] <= thread_0_wire$5;
      end
      if (EVENTS0[12].event_current) begin
        rr_q[0 +: 1] <= thread_0_wire$104;
        owner_q[0 +: 1] <= thread_0_wire$78;
        lock_q[0 +: 1] <= thread_0_wire$72;
      end
      if (EVENTS0[10].event_current) begin
        valid1_q[0 +: 1] <= thread_0_wire$46;
      end
      if (EVENTS0[6].event_current) begin
        valid0_q[0 +: 1] <= thread_0_wire$41;
      end
      if (EVENTS0[2].event_current) begin
        winner_q[0 +: 1] <= thread_0_wire$33;
      end
      _init_0 <= 1'b0;
      _thread_0_event_counter_13_1_q <= _thread_0_event_counter_13_1_n;
      _thread_0_event_counter_12_1_q <= _thread_0_event_counter_12_1_n;
      _thread_0_event_syncstate_10_q <= _thread_0_event_syncstate_10_n;
      _thread_0_event_syncstate_6_q <= _thread_0_event_syncstate_6_n;
      _thread_0_event_counter_2_1_q <= _thread_0_event_counter_2_1_n;
      _thread_0_event_counter_1_1_q <= _thread_0_event_counter_1_1_n;
    end
  end
endmodule
module router (
  input logic[0:0] clk_i,
  input logic[0:0] rst_ni
);
  logic[0:0] _in0_le_beat_ack;
  logic[0:0] _in0_le_beat_valid;
  logic[33:0] _in0_le_beat_0;
  logic[0:0] _in1_le_beat_ack;
  logic[0:0] _in1_le_beat_valid;
  logic[33:0] _in1_le_beat_0;
  logic[0:0] _i0_o0_le_beat_ack;
  logic[0:0] _i0_o0_le_beat_valid;
  logic[33:0] _i0_o0_le_beat_0;
  logic[0:0] _i0_o1_le_beat_ack;
  logic[0:0] _i0_o1_le_beat_valid;
  logic[33:0] _i0_o1_le_beat_0;
  logic[0:0] _i1_o0_le_beat_ack;
  logic[0:0] _i1_o0_le_beat_valid;
  logic[33:0] _i1_o0_le_beat_0;
  logic[0:0] _i1_o1_le_beat_ack;
  logic[0:0] _i1_o1_le_beat_valid;
  logic[33:0] _i1_o1_le_beat_0;
  logic[0:0] _out0_le_beat_ack;
  logic[0:0] _out0_le_beat_valid;
  logic[33:0] _out0_le_beat_0;
  logic[0:0] _out1_le_beat_ack;
  logic[0:0] _out1_le_beat_valid;
  logic[33:0] _out1_le_beat_0;
  input0_route _spawn_0 (
    .clk_i,
    .rst_ni
    ,._inp_beat_valid (_in0_le_beat_valid)
    ,._inp_beat_ack (_in0_le_beat_ack)
    ,._inp_beat_0 (_in0_le_beat_0)
    ,._to_out0_beat_valid (_i0_o0_le_beat_valid)
    ,._to_out0_beat_ack (_i0_o0_le_beat_ack)
    ,._to_out0_beat_0 (_i0_o0_le_beat_0)
    ,._to_out1_beat_valid (_i0_o1_le_beat_valid)
    ,._to_out1_beat_ack (_i0_o1_le_beat_ack)
    ,._to_out1_beat_0 (_i0_o1_le_beat_0)
  );
  input1_route _spawn_1 (
    .clk_i,
    .rst_ni
    ,._inp_beat_valid (_in1_le_beat_valid)
    ,._inp_beat_ack (_in1_le_beat_ack)
    ,._inp_beat_0 (_in1_le_beat_0)
    ,._to_out0_beat_valid (_i1_o0_le_beat_valid)
    ,._to_out0_beat_ack (_i1_o0_le_beat_ack)
    ,._to_out0_beat_0 (_i1_o0_le_beat_0)
    ,._to_out1_beat_valid (_i1_o1_le_beat_valid)
    ,._to_out1_beat_ack (_i1_o1_le_beat_ack)
    ,._to_out1_beat_0 (_i1_o1_le_beat_0)
  );
  output0_arbiter _spawn_2 (
    .clk_i,
    .rst_ni
    ,._from_in0_beat_valid (_i0_o0_le_beat_valid)
    ,._from_in0_beat_ack (_i0_o0_le_beat_ack)
    ,._from_in0_beat_0 (_i0_o0_le_beat_0)
    ,._from_in1_beat_valid (_i1_o0_le_beat_valid)
    ,._from_in1_beat_ack (_i1_o0_le_beat_ack)
    ,._from_in1_beat_0 (_i1_o0_le_beat_0)
    ,._out0_beat_valid (_out0_le_beat_valid)
    ,._out0_beat_ack (_out0_le_beat_ack)
    ,._out0_beat_0 (_out0_le_beat_0)
  );
  output1_arbiter _spawn_3 (
    .clk_i,
    .rst_ni
    ,._from_in0_beat_valid (_i0_o1_le_beat_valid)
    ,._from_in0_beat_ack (_i0_o1_le_beat_ack)
    ,._from_in0_beat_0 (_i0_o1_le_beat_0)
    ,._from_in1_beat_valid (_i1_o1_le_beat_valid)
    ,._from_in1_beat_ack (_i1_o1_le_beat_ack)
    ,._from_in1_beat_0 (_i1_o1_le_beat_0)
    ,._out1_beat_valid (_out1_le_beat_valid)
    ,._out1_beat_ack (_out1_le_beat_ack)
    ,._out1_beat_0 (_out1_le_beat_0)
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
