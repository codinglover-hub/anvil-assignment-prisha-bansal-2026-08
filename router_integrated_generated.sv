/* verilator lint_off UNOPTFLAT */
/* verilator lint_off WIDTHTRUNC */
/* verilator lint_off WIDTHEXPAND */
/* verilator lint_off WIDTHCONCAT */
module output0 (
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
  output logic[33:0] _out0_beat_0
);
  logic[0:0] dest0_q;
  logic[0:0] dest1_q;
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
  logic[0:0] thread_0_wire$122;
  logic[0:0] thread_0_wire$121;
  logic[0:0] thread_0_wire$120;
  logic[0:0] thread_0_wire$119;
  logic[0:0] thread_0_wire$118;
  logic[0:0] thread_0_wire$117;
  logic[0:0] thread_0_wire$116;
  logic[0:0] thread_0_wire$114;
  logic[0:0] thread_0_wire$112;
  logic[0:0] thread_0_wire$111;
  logic[0:0] thread_0_wire$110;
  logic[0:0] thread_0_wire$108;
  logic[0:0] thread_0_wire$106;
  logic[0:0] thread_0_wire$105;
  logic[0:0] thread_0_wire$103;
  logic[0:0] thread_0_wire$102;
  logic[0:0] thread_0_wire$100;
  logic[0:0] thread_0_wire$99;
  logic[0:0] thread_0_wire$97;
  logic[0:0] thread_0_wire$96;
  logic[0:0] thread_0_wire$93;
  logic[0:0] thread_0_wire$91;
  logic[0:0] thread_0_wire$90;
  logic[0:0] thread_0_wire$89;
  logic[0:0] thread_0_wire$88;
  logic[0:0] thread_0_wire$87;
  logic[0:0] thread_0_wire$86;
  logic[0:0] thread_0_wire$85;
  logic[0:0] thread_0_wire$82;
  logic[0:0] thread_0_wire$80;
  logic[0:0] thread_0_wire$79;
  logic[0:0] thread_0_wire$77;
  logic[0:0] thread_0_wire$76;
  logic[0:0] thread_0_wire$74;
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
  logic[0:0] thread_0_wire$58;
  logic[0:0] thread_0_wire$57;
  logic[0:0] thread_0_wire$55;
  logic[33:0] thread_0_wire$53;
  logic[0:0] thread_0_wire$52;
  logic[0:0] thread_0_wire$50;
  logic[0:0] thread_0_wire$49;
  logic[0:0] thread_0_wire$47;
  logic[33:0] thread_0_wire$45;
  logic[0:0] thread_0_wire$44;
  logic[0:0] thread_0_wire$42;
  logic[0:0] thread_0_wire$41;
  logic[0:0] thread_0_wire$39;
  logic[0:0] thread_0_wire$38;
  logic[0:0] thread_0_wire$36;
  logic[0:0] thread_0_wire$35;
  logic[0:0] thread_0_wire$34;
  logic[0:0] thread_0_wire$33;
  logic[0:0] thread_0_wire$30;
  logic[0:0] thread_0_wire$28;
  logic[0:0] thread_0_wire$27;
  logic[0:0] thread_0_wire$25;
  logic[0:0] thread_0_wire$22;
  logic[0:0] thread_0_wire$20;
  logic[0:0] thread_0_wire$19;
  logic[0:0] thread_0_wire$17;
  logic[0:0] thread_0_wire$16;
  logic[0:0] thread_0_wire$14;
  logic[0:0] thread_0_wire$13;
  logic[0:0] thread_0_wire$12;
  logic[0:0] thread_0_wire$10;
  logic[0:0] thread_0_wire$9;
  logic[0:0] thread_0_wire$8;
  logic[33:0] thread_0_wire$6;
  logic[0:0] thread_0_wire$5;
  logic[0:0] thread_0_wire$4;
  logic[0:0] thread_0_wire$3;
  logic[33:0] thread_0_wire$1;
  logic[0:0] thread_0_wire$0;
  assign thread_0_wire$0 = _in0_beat_valid;
  assign thread_0_wire$1 = _in0_beat_0;
  localparam logic[0:0] thread_0_wire$2 = 1'b1;
  assign thread_0_wire$3 = thread_0_wire$1[1 +: 1];
  assign thread_0_wire$4 = thread_0_wire$1[0 +: 1];
  assign thread_0_wire$5 = _in1_beat_valid;
  assign thread_0_wire$6 = _in1_beat_0;
  localparam logic[0:0] thread_0_wire$7 = 1'b1;
  assign thread_0_wire$8 = thread_0_wire$6[1 +: 1];
  assign thread_0_wire$9 = thread_0_wire$6[0 +: 1];
  assign thread_0_wire$10 = lock_q;
  localparam logic[0:0] thread_0_wire$11 = 1'b1;
  assign thread_0_wire$12 = thread_0_wire$10 == thread_0_wire$11;
  assign thread_0_wire$13 = owner_q;
  assign thread_0_wire$14 = valid0_q;
  localparam logic[0:0] thread_0_wire$15 = 1'b1;
  assign thread_0_wire$16 = thread_0_wire$14 == thread_0_wire$15;
  assign thread_0_wire$17 = valid1_q;
  localparam logic[0:0] thread_0_wire$18 = 1'b1;
  assign thread_0_wire$19 = thread_0_wire$17 == thread_0_wire$18;
  assign thread_0_wire$20 = rr_q;
  localparam logic[0:0] thread_0_wire$21 = 1'b0;
  assign thread_0_wire$22 = thread_0_wire$20 == thread_0_wire$21;
  localparam logic[0:0] thread_0_wire$23 = 1'b0;
  localparam logic[0:0] thread_0_wire$24 = 1'b1;
  assign thread_0_wire$25 = (thread_0_wire$22) ? thread_0_wire$23 : thread_0_wire$24;
  localparam logic[0:0] thread_0_wire$26 = 1'b0;
  assign thread_0_wire$27 = (thread_0_wire$19) ? thread_0_wire$25 : thread_0_wire$26;
  assign thread_0_wire$28 = valid1_q;
  localparam logic[0:0] thread_0_wire$29 = 1'b1;
  assign thread_0_wire$30 = thread_0_wire$28 == thread_0_wire$29;
  localparam logic[0:0] thread_0_wire$31 = 1'b1;
  localparam logic[0:0] thread_0_wire$32 = 1'b0;
  assign thread_0_wire$33 = (thread_0_wire$30) ? thread_0_wire$31 : thread_0_wire$32;
  assign thread_0_wire$34 = (thread_0_wire$16) ? thread_0_wire$27 : thread_0_wire$33;
  assign thread_0_wire$35 = (thread_0_wire$12) ? thread_0_wire$13 : thread_0_wire$34;
  assign thread_0_wire$36 = winner_q;
  localparam logic[0:0] thread_0_wire$37 = 1'b0;
  assign thread_0_wire$38 = thread_0_wire$36 == thread_0_wire$37;
  assign thread_0_wire$39 = valid0_q;
  localparam logic[0:0] thread_0_wire$40 = 1'b1;
  assign thread_0_wire$41 = thread_0_wire$39 == thread_0_wire$40;
  assign thread_0_wire$42 = dest0_q;
  localparam logic[0:0] thread_0_wire$43 = 1'b0;
  assign thread_0_wire$44 = thread_0_wire$42 == thread_0_wire$43;
  assign thread_0_wire$45 = packet0_q;
  localparam logic[0:0] thread_0_wire$46 = 1'b0;
  assign thread_0_wire$47 = valid1_q;
  localparam logic[0:0] thread_0_wire$48 = 1'b1;
  assign thread_0_wire$49 = thread_0_wire$47 == thread_0_wire$48;
  assign thread_0_wire$50 = dest1_q;
  localparam logic[0:0] thread_0_wire$51 = 1'b0;
  assign thread_0_wire$52 = thread_0_wire$50 == thread_0_wire$51;
  assign thread_0_wire$53 = packet1_q;
  localparam logic[0:0] thread_0_wire$54 = 1'b0;
  assign thread_0_wire$55 = winner_q;
  localparam logic[0:0] thread_0_wire$56 = 1'b0;
  assign thread_0_wire$57 = thread_0_wire$55 == thread_0_wire$56;
  assign thread_0_wire$58 = valid0_q;
  localparam logic[0:0] thread_0_wire$59 = 1'b1;
  assign thread_0_wire$60 = thread_0_wire$58 == thread_0_wire$59;
  assign thread_0_wire$61 = dest0_q;
  localparam logic[0:0] thread_0_wire$62 = 1'b0;
  assign thread_0_wire$63 = thread_0_wire$61 == thread_0_wire$62;
  assign thread_0_wire$64 = last0_q;
  localparam logic[0:0] thread_0_wire$65 = 1'b1;
  assign thread_0_wire$66 = thread_0_wire$64 == thread_0_wire$65;
  localparam logic[0:0] thread_0_wire$67 = 1'b0;
  localparam logic[0:0] thread_0_wire$68 = 1'b1;
  assign thread_0_wire$69 = (thread_0_wire$66) ? thread_0_wire$67 : thread_0_wire$68;
  assign thread_0_wire$70 = lock_q;
  assign thread_0_wire$71 = (thread_0_wire$63) ? thread_0_wire$69 : thread_0_wire$70;
  assign thread_0_wire$72 = lock_q;
  assign thread_0_wire$73 = (thread_0_wire$60) ? thread_0_wire$71 : thread_0_wire$72;
  assign thread_0_wire$74 = valid1_q;
  localparam logic[0:0] thread_0_wire$75 = 1'b1;
  assign thread_0_wire$76 = thread_0_wire$74 == thread_0_wire$75;
  assign thread_0_wire$77 = dest1_q;
  localparam logic[0:0] thread_0_wire$78 = 1'b0;
  assign thread_0_wire$79 = thread_0_wire$77 == thread_0_wire$78;
  assign thread_0_wire$80 = last1_q;
  localparam logic[0:0] thread_0_wire$81 = 1'b1;
  assign thread_0_wire$82 = thread_0_wire$80 == thread_0_wire$81;
  localparam logic[0:0] thread_0_wire$83 = 1'b0;
  localparam logic[0:0] thread_0_wire$84 = 1'b1;
  assign thread_0_wire$85 = (thread_0_wire$82) ? thread_0_wire$83 : thread_0_wire$84;
  assign thread_0_wire$86 = lock_q;
  assign thread_0_wire$87 = (thread_0_wire$79) ? thread_0_wire$85 : thread_0_wire$86;
  assign thread_0_wire$88 = lock_q;
  assign thread_0_wire$89 = (thread_0_wire$76) ? thread_0_wire$87 : thread_0_wire$88;
  assign thread_0_wire$90 = (thread_0_wire$57) ? thread_0_wire$73 : thread_0_wire$89;
  assign thread_0_wire$91 = winner_q;
  localparam logic[0:0] thread_0_wire$92 = 1'b0;
  assign thread_0_wire$93 = thread_0_wire$91 == thread_0_wire$92;
  localparam logic[0:0] thread_0_wire$94 = 1'b0;
  localparam logic[0:0] thread_0_wire$95 = 1'b1;
  assign thread_0_wire$96 = (thread_0_wire$93) ? thread_0_wire$94 : thread_0_wire$95;
  assign thread_0_wire$97 = valid0_q;
  localparam logic[0:0] thread_0_wire$98 = 1'b1;
  assign thread_0_wire$99 = thread_0_wire$97 == thread_0_wire$98;
  assign thread_0_wire$100 = valid1_q;
  localparam logic[0:0] thread_0_wire$101 = 1'b1;
  assign thread_0_wire$102 = thread_0_wire$100 == thread_0_wire$101;
  assign thread_0_wire$103 = winner_q;
  localparam logic[0:0] thread_0_wire$104 = 1'b0;
  assign thread_0_wire$105 = thread_0_wire$103 == thread_0_wire$104;
  assign thread_0_wire$106 = last0_q;
  localparam logic[0:0] thread_0_wire$107 = 1'b1;
  assign thread_0_wire$108 = thread_0_wire$106 == thread_0_wire$107;
  localparam logic[0:0] thread_0_wire$109 = 1'b1;
  assign thread_0_wire$110 = rr_q;
  assign thread_0_wire$111 = (thread_0_wire$108) ? thread_0_wire$109 : thread_0_wire$110;
  assign thread_0_wire$112 = last1_q;
  localparam logic[0:0] thread_0_wire$113 = 1'b1;
  assign thread_0_wire$114 = thread_0_wire$112 == thread_0_wire$113;
  localparam logic[0:0] thread_0_wire$115 = 1'b0;
  assign thread_0_wire$116 = rr_q;
  assign thread_0_wire$117 = (thread_0_wire$114) ? thread_0_wire$115 : thread_0_wire$116;
  assign thread_0_wire$118 = (thread_0_wire$105) ? thread_0_wire$111 : thread_0_wire$117;
  assign thread_0_wire$119 = rr_q;
  assign thread_0_wire$120 = (thread_0_wire$102) ? thread_0_wire$118 : thread_0_wire$119;
  assign thread_0_wire$121 = rr_q;
  assign thread_0_wire$122 = (thread_0_wire$99) ? thread_0_wire$120 : thread_0_wire$121;
  for (genvar i = 0; i < 20; i ++) begin : EVENTS0
    logic event_current;
    end
  logic _init_0;
  logic _thread_0_event_counter_17_1_q, _thread_0_event_counter_17_1_n;
  logic _thread_0_event_counter_16_1_q, _thread_0_event_counter_16_1_n;
  logic _thread_0_event_syncstate_14_q, _thread_0_event_syncstate_14_n;
  logic _thread_0_event_syncstate_8_q, _thread_0_event_syncstate_8_n;
  logic _thread_0_event_counter_2_1_q, _thread_0_event_counter_2_1_n;
  logic _thread_0_event_counter_1_1_q, _thread_0_event_counter_1_1_n;
  assign EVENTS0[19].event_current = EVENTS0[0].event_current && thread_0_wire$0;
  assign EVENTS0[18].event_current = EVENTS0[1].event_current && thread_0_wire$5;
  assign EVENTS0[17].event_current = _thread_0_event_counter_17_1_q;
  assign _thread_0_event_counter_17_1_n = EVENTS0[16].event_current;
  assign EVENTS0[16].event_current = _thread_0_event_counter_16_1_q;
  assign _thread_0_event_counter_16_1_n = EVENTS0[15].event_current;
  assign EVENTS0[15].event_current = EVENTS0[14].event_current || EVENTS0[12].event_current || EVENTS0[10].event_current || EVENTS0[8].event_current || EVENTS0[6].event_current || EVENTS0[4].event_current;
  assign EVENTS0[14].event_current = (EVENTS0[13].event_current || _thread_0_event_syncstate_14_q) && _out0_beat_ack;
    assign _thread_0_event_syncstate_14_n = (EVENTS0[13].event_current || _thread_0_event_syncstate_14_q) && !_out0_beat_ack;
  assign EVENTS0[13].event_current = EVENTS0[11].event_current && thread_0_wire$52;
  assign EVENTS0[12].event_current = EVENTS0[11].event_current && !thread_0_wire$52;
  assign EVENTS0[11].event_current = EVENTS0[9].event_current && thread_0_wire$49;
  assign EVENTS0[10].event_current = EVENTS0[9].event_current && !thread_0_wire$49;
  assign EVENTS0[9].event_current = EVENTS0[2].event_current && !thread_0_wire$38;
  assign EVENTS0[8].event_current = (EVENTS0[7].event_current || _thread_0_event_syncstate_8_q) && _out0_beat_ack;
    assign _thread_0_event_syncstate_8_n = (EVENTS0[7].event_current || _thread_0_event_syncstate_8_q) && !_out0_beat_ack;
  assign EVENTS0[7].event_current = EVENTS0[5].event_current && thread_0_wire$44;
  assign EVENTS0[6].event_current = EVENTS0[5].event_current && !thread_0_wire$44;
  assign EVENTS0[5].event_current = EVENTS0[3].event_current && thread_0_wire$41;
  assign EVENTS0[4].event_current = EVENTS0[3].event_current && !thread_0_wire$41;
  assign EVENTS0[3].event_current = EVENTS0[2].event_current && thread_0_wire$38;
  assign EVENTS0[2].event_current = _thread_0_event_counter_2_1_q;
  assign _thread_0_event_counter_2_1_n = EVENTS0[1].event_current;
  assign EVENTS0[1].event_current = _thread_0_event_counter_1_1_q;
  assign _thread_0_event_counter_1_1_n = EVENTS0[0].event_current;
  assign EVENTS0[0].event_current = _init_0 || EVENTS0[17].event_current;
  assign _in1_beat_ack = EVENTS0[18].event_current;
  assign _in0_beat_ack = EVENTS0[19].event_current;
  assign _out0_beat_valid = (EVENTS0[7].event_current || _thread_0_event_syncstate_8_q) || (EVENTS0[13].event_current || _thread_0_event_syncstate_14_q);
  logic[0:0] _out0_beat_valid_selector_q, _out0_beat_valid_selector_n;
  assign _out0_beat_0 = (_out0_beat_valid_selector_n == 1'd0) ? thread_0_wire$45 : (_out0_beat_valid_selector_n == 1'd1) ? thread_0_wire$53 : '0;
  always_comb begin: _thread_0_selector
    _out0_beat_valid_selector_n = _out0_beat_valid_selector_q;
    if ((EVENTS0[7].event_current || _thread_0_event_syncstate_8_q)) _out0_beat_valid_selector_n = 1'd0;
    if ((EVENTS0[13].event_current || _thread_0_event_syncstate_14_q)) _out0_beat_valid_selector_n = 1'd1;
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
      dest0_q <= '0;
      dest1_q <= '0;
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
      _thread_0_event_counter_17_1_q <= '0;
      _thread_0_event_counter_16_1_q <= '0;
      _thread_0_event_syncstate_14_q <= '0;
      _thread_0_event_syncstate_8_q <= '0;
      _thread_0_event_counter_2_1_q <= '0;
      _thread_0_event_counter_1_1_q <= '0;
    end else begin
      if (EVENTS0[19].event_current) begin
        last0_q[0 +: 1] <= thread_0_wire$4;
        dest0_q[0 +: 1] <= thread_0_wire$3;
        valid0_q[0 +: 1] <= thread_0_wire$2;
        packet0_q[0 +: 34] <= thread_0_wire$1;
      end
      if (EVENTS0[18].event_current) begin
        last1_q[0 +: 1] <= thread_0_wire$9;
        dest1_q[0 +: 1] <= thread_0_wire$8;
        valid1_q[0 +: 1] <= thread_0_wire$7;
        packet1_q[0 +: 34] <= thread_0_wire$6;
      end
      if (EVENTS0[16].event_current) begin
        rr_q[0 +: 1] <= thread_0_wire$122;
        owner_q[0 +: 1] <= thread_0_wire$96;
        lock_q[0 +: 1] <= thread_0_wire$90;
      end
      if (EVENTS0[14].event_current) begin
        valid1_q[0 +: 1] <= thread_0_wire$54;
      end
      if (EVENTS0[8].event_current) begin
        valid0_q[0 +: 1] <= thread_0_wire$46;
      end
      if (EVENTS0[2].event_current) begin
        winner_q[0 +: 1] <= thread_0_wire$35;
      end
      _init_0 <= 1'b0;
      _thread_0_event_counter_17_1_q <= _thread_0_event_counter_17_1_n;
      _thread_0_event_counter_16_1_q <= _thread_0_event_counter_16_1_n;
      _thread_0_event_syncstate_14_q <= _thread_0_event_syncstate_14_n;
      _thread_0_event_syncstate_8_q <= _thread_0_event_syncstate_8_n;
      _thread_0_event_counter_2_1_q <= _thread_0_event_counter_2_1_n;
      _thread_0_event_counter_1_1_q <= _thread_0_event_counter_1_1_n;
    end
  end
endmodule
module output1 (
  input logic[0:0] clk_i,
  input logic[0:0] rst_ni,
  output logic[0:0] _in0_beat_ack,
  input logic[0:0] _in0_beat_valid,
  input logic[33:0] _in0_beat_0,
  output logic[0:0] _in1_beat_ack,
  input logic[0:0] _in1_beat_valid,
  input logic[33:0] _in1_beat_0,
  input logic[0:0] _out1_beat_ack,
  output logic[0:0] _out1_beat_valid,
  output logic[33:0] _out1_beat_0
);
  logic[0:0] dest0_q;
  logic[0:0] dest1_q;
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
  logic[0:0] thread_0_wire$122;
  logic[0:0] thread_0_wire$121;
  logic[0:0] thread_0_wire$120;
  logic[0:0] thread_0_wire$119;
  logic[0:0] thread_0_wire$118;
  logic[0:0] thread_0_wire$117;
  logic[0:0] thread_0_wire$116;
  logic[0:0] thread_0_wire$114;
  logic[0:0] thread_0_wire$112;
  logic[0:0] thread_0_wire$111;
  logic[0:0] thread_0_wire$110;
  logic[0:0] thread_0_wire$108;
  logic[0:0] thread_0_wire$106;
  logic[0:0] thread_0_wire$105;
  logic[0:0] thread_0_wire$103;
  logic[0:0] thread_0_wire$102;
  logic[0:0] thread_0_wire$100;
  logic[0:0] thread_0_wire$99;
  logic[0:0] thread_0_wire$97;
  logic[0:0] thread_0_wire$96;
  logic[0:0] thread_0_wire$93;
  logic[0:0] thread_0_wire$91;
  logic[0:0] thread_0_wire$90;
  logic[0:0] thread_0_wire$89;
  logic[0:0] thread_0_wire$88;
  logic[0:0] thread_0_wire$87;
  logic[0:0] thread_0_wire$86;
  logic[0:0] thread_0_wire$85;
  logic[0:0] thread_0_wire$82;
  logic[0:0] thread_0_wire$80;
  logic[0:0] thread_0_wire$79;
  logic[0:0] thread_0_wire$77;
  logic[0:0] thread_0_wire$76;
  logic[0:0] thread_0_wire$74;
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
  logic[0:0] thread_0_wire$58;
  logic[0:0] thread_0_wire$57;
  logic[0:0] thread_0_wire$55;
  logic[33:0] thread_0_wire$53;
  logic[0:0] thread_0_wire$52;
  logic[0:0] thread_0_wire$50;
  logic[0:0] thread_0_wire$49;
  logic[0:0] thread_0_wire$47;
  logic[33:0] thread_0_wire$45;
  logic[0:0] thread_0_wire$44;
  logic[0:0] thread_0_wire$42;
  logic[0:0] thread_0_wire$41;
  logic[0:0] thread_0_wire$39;
  logic[0:0] thread_0_wire$38;
  logic[0:0] thread_0_wire$36;
  logic[0:0] thread_0_wire$35;
  logic[0:0] thread_0_wire$34;
  logic[0:0] thread_0_wire$33;
  logic[0:0] thread_0_wire$30;
  logic[0:0] thread_0_wire$28;
  logic[0:0] thread_0_wire$27;
  logic[0:0] thread_0_wire$25;
  logic[0:0] thread_0_wire$22;
  logic[0:0] thread_0_wire$20;
  logic[0:0] thread_0_wire$19;
  logic[0:0] thread_0_wire$17;
  logic[0:0] thread_0_wire$16;
  logic[0:0] thread_0_wire$14;
  logic[0:0] thread_0_wire$13;
  logic[0:0] thread_0_wire$12;
  logic[0:0] thread_0_wire$10;
  logic[0:0] thread_0_wire$9;
  logic[0:0] thread_0_wire$8;
  logic[33:0] thread_0_wire$6;
  logic[0:0] thread_0_wire$5;
  logic[0:0] thread_0_wire$4;
  logic[0:0] thread_0_wire$3;
  logic[33:0] thread_0_wire$1;
  logic[0:0] thread_0_wire$0;
  assign thread_0_wire$0 = _in0_beat_valid;
  assign thread_0_wire$1 = _in0_beat_0;
  localparam logic[0:0] thread_0_wire$2 = 1'b1;
  assign thread_0_wire$3 = thread_0_wire$1[1 +: 1];
  assign thread_0_wire$4 = thread_0_wire$1[0 +: 1];
  assign thread_0_wire$5 = _in1_beat_valid;
  assign thread_0_wire$6 = _in1_beat_0;
  localparam logic[0:0] thread_0_wire$7 = 1'b1;
  assign thread_0_wire$8 = thread_0_wire$6[1 +: 1];
  assign thread_0_wire$9 = thread_0_wire$6[0 +: 1];
  assign thread_0_wire$10 = lock_q;
  localparam logic[0:0] thread_0_wire$11 = 1'b1;
  assign thread_0_wire$12 = thread_0_wire$10 == thread_0_wire$11;
  assign thread_0_wire$13 = owner_q;
  assign thread_0_wire$14 = valid0_q;
  localparam logic[0:0] thread_0_wire$15 = 1'b1;
  assign thread_0_wire$16 = thread_0_wire$14 == thread_0_wire$15;
  assign thread_0_wire$17 = valid1_q;
  localparam logic[0:0] thread_0_wire$18 = 1'b1;
  assign thread_0_wire$19 = thread_0_wire$17 == thread_0_wire$18;
  assign thread_0_wire$20 = rr_q;
  localparam logic[0:0] thread_0_wire$21 = 1'b0;
  assign thread_0_wire$22 = thread_0_wire$20 == thread_0_wire$21;
  localparam logic[0:0] thread_0_wire$23 = 1'b0;
  localparam logic[0:0] thread_0_wire$24 = 1'b1;
  assign thread_0_wire$25 = (thread_0_wire$22) ? thread_0_wire$23 : thread_0_wire$24;
  localparam logic[0:0] thread_0_wire$26 = 1'b0;
  assign thread_0_wire$27 = (thread_0_wire$19) ? thread_0_wire$25 : thread_0_wire$26;
  assign thread_0_wire$28 = valid1_q;
  localparam logic[0:0] thread_0_wire$29 = 1'b1;
  assign thread_0_wire$30 = thread_0_wire$28 == thread_0_wire$29;
  localparam logic[0:0] thread_0_wire$31 = 1'b1;
  localparam logic[0:0] thread_0_wire$32 = 1'b0;
  assign thread_0_wire$33 = (thread_0_wire$30) ? thread_0_wire$31 : thread_0_wire$32;
  assign thread_0_wire$34 = (thread_0_wire$16) ? thread_0_wire$27 : thread_0_wire$33;
  assign thread_0_wire$35 = (thread_0_wire$12) ? thread_0_wire$13 : thread_0_wire$34;
  assign thread_0_wire$36 = winner_q;
  localparam logic[0:0] thread_0_wire$37 = 1'b0;
  assign thread_0_wire$38 = thread_0_wire$36 == thread_0_wire$37;
  assign thread_0_wire$39 = valid0_q;
  localparam logic[0:0] thread_0_wire$40 = 1'b1;
  assign thread_0_wire$41 = thread_0_wire$39 == thread_0_wire$40;
  assign thread_0_wire$42 = dest0_q;
  localparam logic[0:0] thread_0_wire$43 = 1'b1;
  assign thread_0_wire$44 = thread_0_wire$42 == thread_0_wire$43;
  assign thread_0_wire$45 = packet0_q;
  localparam logic[0:0] thread_0_wire$46 = 1'b0;
  assign thread_0_wire$47 = valid1_q;
  localparam logic[0:0] thread_0_wire$48 = 1'b1;
  assign thread_0_wire$49 = thread_0_wire$47 == thread_0_wire$48;
  assign thread_0_wire$50 = dest1_q;
  localparam logic[0:0] thread_0_wire$51 = 1'b1;
  assign thread_0_wire$52 = thread_0_wire$50 == thread_0_wire$51;
  assign thread_0_wire$53 = packet1_q;
  localparam logic[0:0] thread_0_wire$54 = 1'b0;
  assign thread_0_wire$55 = winner_q;
  localparam logic[0:0] thread_0_wire$56 = 1'b0;
  assign thread_0_wire$57 = thread_0_wire$55 == thread_0_wire$56;
  assign thread_0_wire$58 = valid0_q;
  localparam logic[0:0] thread_0_wire$59 = 1'b1;
  assign thread_0_wire$60 = thread_0_wire$58 == thread_0_wire$59;
  assign thread_0_wire$61 = dest0_q;
  localparam logic[0:0] thread_0_wire$62 = 1'b1;
  assign thread_0_wire$63 = thread_0_wire$61 == thread_0_wire$62;
  assign thread_0_wire$64 = last0_q;
  localparam logic[0:0] thread_0_wire$65 = 1'b1;
  assign thread_0_wire$66 = thread_0_wire$64 == thread_0_wire$65;
  localparam logic[0:0] thread_0_wire$67 = 1'b0;
  localparam logic[0:0] thread_0_wire$68 = 1'b1;
  assign thread_0_wire$69 = (thread_0_wire$66) ? thread_0_wire$67 : thread_0_wire$68;
  assign thread_0_wire$70 = lock_q;
  assign thread_0_wire$71 = (thread_0_wire$63) ? thread_0_wire$69 : thread_0_wire$70;
  assign thread_0_wire$72 = lock_q;
  assign thread_0_wire$73 = (thread_0_wire$60) ? thread_0_wire$71 : thread_0_wire$72;
  assign thread_0_wire$74 = valid1_q;
  localparam logic[0:0] thread_0_wire$75 = 1'b1;
  assign thread_0_wire$76 = thread_0_wire$74 == thread_0_wire$75;
  assign thread_0_wire$77 = dest1_q;
  localparam logic[0:0] thread_0_wire$78 = 1'b1;
  assign thread_0_wire$79 = thread_0_wire$77 == thread_0_wire$78;
  assign thread_0_wire$80 = last1_q;
  localparam logic[0:0] thread_0_wire$81 = 1'b1;
  assign thread_0_wire$82 = thread_0_wire$80 == thread_0_wire$81;
  localparam logic[0:0] thread_0_wire$83 = 1'b0;
  localparam logic[0:0] thread_0_wire$84 = 1'b1;
  assign thread_0_wire$85 = (thread_0_wire$82) ? thread_0_wire$83 : thread_0_wire$84;
  assign thread_0_wire$86 = lock_q;
  assign thread_0_wire$87 = (thread_0_wire$79) ? thread_0_wire$85 : thread_0_wire$86;
  assign thread_0_wire$88 = lock_q;
  assign thread_0_wire$89 = (thread_0_wire$76) ? thread_0_wire$87 : thread_0_wire$88;
  assign thread_0_wire$90 = (thread_0_wire$57) ? thread_0_wire$73 : thread_0_wire$89;
  assign thread_0_wire$91 = winner_q;
  localparam logic[0:0] thread_0_wire$92 = 1'b0;
  assign thread_0_wire$93 = thread_0_wire$91 == thread_0_wire$92;
  localparam logic[0:0] thread_0_wire$94 = 1'b0;
  localparam logic[0:0] thread_0_wire$95 = 1'b1;
  assign thread_0_wire$96 = (thread_0_wire$93) ? thread_0_wire$94 : thread_0_wire$95;
  assign thread_0_wire$97 = valid0_q;
  localparam logic[0:0] thread_0_wire$98 = 1'b1;
  assign thread_0_wire$99 = thread_0_wire$97 == thread_0_wire$98;
  assign thread_0_wire$100 = valid1_q;
  localparam logic[0:0] thread_0_wire$101 = 1'b1;
  assign thread_0_wire$102 = thread_0_wire$100 == thread_0_wire$101;
  assign thread_0_wire$103 = winner_q;
  localparam logic[0:0] thread_0_wire$104 = 1'b0;
  assign thread_0_wire$105 = thread_0_wire$103 == thread_0_wire$104;
  assign thread_0_wire$106 = last0_q;
  localparam logic[0:0] thread_0_wire$107 = 1'b1;
  assign thread_0_wire$108 = thread_0_wire$106 == thread_0_wire$107;
  localparam logic[0:0] thread_0_wire$109 = 1'b1;
  assign thread_0_wire$110 = rr_q;
  assign thread_0_wire$111 = (thread_0_wire$108) ? thread_0_wire$109 : thread_0_wire$110;
  assign thread_0_wire$112 = last1_q;
  localparam logic[0:0] thread_0_wire$113 = 1'b1;
  assign thread_0_wire$114 = thread_0_wire$112 == thread_0_wire$113;
  localparam logic[0:0] thread_0_wire$115 = 1'b0;
  assign thread_0_wire$116 = rr_q;
  assign thread_0_wire$117 = (thread_0_wire$114) ? thread_0_wire$115 : thread_0_wire$116;
  assign thread_0_wire$118 = (thread_0_wire$105) ? thread_0_wire$111 : thread_0_wire$117;
  assign thread_0_wire$119 = rr_q;
  assign thread_0_wire$120 = (thread_0_wire$102) ? thread_0_wire$118 : thread_0_wire$119;
  assign thread_0_wire$121 = rr_q;
  assign thread_0_wire$122 = (thread_0_wire$99) ? thread_0_wire$120 : thread_0_wire$121;
  for (genvar i = 0; i < 20; i ++) begin : EVENTS0
    logic event_current;
    end
  logic _init_0;
  logic _thread_0_event_counter_17_1_q, _thread_0_event_counter_17_1_n;
  logic _thread_0_event_counter_16_1_q, _thread_0_event_counter_16_1_n;
  logic _thread_0_event_syncstate_14_q, _thread_0_event_syncstate_14_n;
  logic _thread_0_event_syncstate_8_q, _thread_0_event_syncstate_8_n;
  logic _thread_0_event_counter_2_1_q, _thread_0_event_counter_2_1_n;
  logic _thread_0_event_counter_1_1_q, _thread_0_event_counter_1_1_n;
  assign EVENTS0[19].event_current = EVENTS0[0].event_current && thread_0_wire$0;
  assign EVENTS0[18].event_current = EVENTS0[1].event_current && thread_0_wire$5;
  assign EVENTS0[17].event_current = _thread_0_event_counter_17_1_q;
  assign _thread_0_event_counter_17_1_n = EVENTS0[16].event_current;
  assign EVENTS0[16].event_current = _thread_0_event_counter_16_1_q;
  assign _thread_0_event_counter_16_1_n = EVENTS0[15].event_current;
  assign EVENTS0[15].event_current = EVENTS0[14].event_current || EVENTS0[12].event_current || EVENTS0[10].event_current || EVENTS0[8].event_current || EVENTS0[6].event_current || EVENTS0[4].event_current;
  assign EVENTS0[14].event_current = (EVENTS0[13].event_current || _thread_0_event_syncstate_14_q) && _out1_beat_ack;
    assign _thread_0_event_syncstate_14_n = (EVENTS0[13].event_current || _thread_0_event_syncstate_14_q) && !_out1_beat_ack;
  assign EVENTS0[13].event_current = EVENTS0[11].event_current && thread_0_wire$52;
  assign EVENTS0[12].event_current = EVENTS0[11].event_current && !thread_0_wire$52;
  assign EVENTS0[11].event_current = EVENTS0[9].event_current && thread_0_wire$49;
  assign EVENTS0[10].event_current = EVENTS0[9].event_current && !thread_0_wire$49;
  assign EVENTS0[9].event_current = EVENTS0[2].event_current && !thread_0_wire$38;
  assign EVENTS0[8].event_current = (EVENTS0[7].event_current || _thread_0_event_syncstate_8_q) && _out1_beat_ack;
    assign _thread_0_event_syncstate_8_n = (EVENTS0[7].event_current || _thread_0_event_syncstate_8_q) && !_out1_beat_ack;
  assign EVENTS0[7].event_current = EVENTS0[5].event_current && thread_0_wire$44;
  assign EVENTS0[6].event_current = EVENTS0[5].event_current && !thread_0_wire$44;
  assign EVENTS0[5].event_current = EVENTS0[3].event_current && thread_0_wire$41;
  assign EVENTS0[4].event_current = EVENTS0[3].event_current && !thread_0_wire$41;
  assign EVENTS0[3].event_current = EVENTS0[2].event_current && thread_0_wire$38;
  assign EVENTS0[2].event_current = _thread_0_event_counter_2_1_q;
  assign _thread_0_event_counter_2_1_n = EVENTS0[1].event_current;
  assign EVENTS0[1].event_current = _thread_0_event_counter_1_1_q;
  assign _thread_0_event_counter_1_1_n = EVENTS0[0].event_current;
  assign EVENTS0[0].event_current = _init_0 || EVENTS0[17].event_current;
  assign _in1_beat_ack = EVENTS0[18].event_current;
  assign _in0_beat_ack = EVENTS0[19].event_current;
  assign _out1_beat_valid = (EVENTS0[7].event_current || _thread_0_event_syncstate_8_q) || (EVENTS0[13].event_current || _thread_0_event_syncstate_14_q);
  logic[0:0] _out1_beat_valid_selector_q, _out1_beat_valid_selector_n;
  assign _out1_beat_0 = (_out1_beat_valid_selector_n == 1'd0) ? thread_0_wire$45 : (_out1_beat_valid_selector_n == 1'd1) ? thread_0_wire$53 : '0;
  always_comb begin: _thread_0_selector
    _out1_beat_valid_selector_n = _out1_beat_valid_selector_q;
    if ((EVENTS0[7].event_current || _thread_0_event_syncstate_8_q)) _out1_beat_valid_selector_n = 1'd0;
    if ((EVENTS0[13].event_current || _thread_0_event_syncstate_14_q)) _out1_beat_valid_selector_n = 1'd1;
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
      dest0_q <= '0;
      dest1_q <= '0;
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
      _thread_0_event_counter_17_1_q <= '0;
      _thread_0_event_counter_16_1_q <= '0;
      _thread_0_event_syncstate_14_q <= '0;
      _thread_0_event_syncstate_8_q <= '0;
      _thread_0_event_counter_2_1_q <= '0;
      _thread_0_event_counter_1_1_q <= '0;
    end else begin
      if (EVENTS0[19].event_current) begin
        last0_q[0 +: 1] <= thread_0_wire$4;
        dest0_q[0 +: 1] <= thread_0_wire$3;
        valid0_q[0 +: 1] <= thread_0_wire$2;
        packet0_q[0 +: 34] <= thread_0_wire$1;
      end
      if (EVENTS0[18].event_current) begin
        last1_q[0 +: 1] <= thread_0_wire$9;
        dest1_q[0 +: 1] <= thread_0_wire$8;
        valid1_q[0 +: 1] <= thread_0_wire$7;
        packet1_q[0 +: 34] <= thread_0_wire$6;
      end
      if (EVENTS0[16].event_current) begin
        rr_q[0 +: 1] <= thread_0_wire$122;
        owner_q[0 +: 1] <= thread_0_wire$96;
        lock_q[0 +: 1] <= thread_0_wire$90;
      end
      if (EVENTS0[14].event_current) begin
        valid1_q[0 +: 1] <= thread_0_wire$54;
      end
      if (EVENTS0[8].event_current) begin
        valid0_q[0 +: 1] <= thread_0_wire$46;
      end
      if (EVENTS0[2].event_current) begin
        winner_q[0 +: 1] <= thread_0_wire$35;
      end
      _init_0 <= 1'b0;
      _thread_0_event_counter_17_1_q <= _thread_0_event_counter_17_1_n;
      _thread_0_event_counter_16_1_q <= _thread_0_event_counter_16_1_n;
      _thread_0_event_syncstate_14_q <= _thread_0_event_syncstate_14_n;
      _thread_0_event_syncstate_8_q <= _thread_0_event_syncstate_8_n;
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
  logic[0:0] _out0_le_beat_ack;
  logic[0:0] _out0_le_beat_valid;
  logic[33:0] _out0_le_beat_0;
  logic[0:0] _out1_le_beat_ack;
  logic[0:0] _out1_le_beat_valid;
  logic[33:0] _out1_le_beat_0;
  output0 _spawn_0 (
    .clk_i,
    .rst_ni
    ,._in0_beat_valid (_in0_le_beat_valid)
    ,._in0_beat_ack (_in0_le_beat_ack)
    ,._in0_beat_0 (_in0_le_beat_0)
    ,._in1_beat_valid (_in1_le_beat_valid)
    ,._in1_beat_ack (_in1_le_beat_ack)
    ,._in1_beat_0 (_in1_le_beat_0)
    ,._out0_beat_valid (_out0_le_beat_valid)
    ,._out0_beat_ack (_out0_le_beat_ack)
    ,._out0_beat_0 (_out0_le_beat_0)
  );
  output1 _spawn_1 (
    .clk_i,
    .rst_ni
    ,._in0_beat_valid (_in0_le_beat_valid)
    ,._in0_beat_ack (_in0_le_beat_ack)
    ,._in0_beat_0 (_in0_le_beat_0)
    ,._in1_beat_valid (_in1_le_beat_valid)
    ,._in1_beat_ack (_in1_le_beat_ack)
    ,._in1_beat_0 (_in1_le_beat_0)
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
