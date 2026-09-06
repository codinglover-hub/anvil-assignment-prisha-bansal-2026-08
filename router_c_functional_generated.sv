/* verilator lint_off UNOPTFLAT */
/* verilator lint_off WIDTHTRUNC */
/* verilator lint_off WIDTHEXPAND */
/* verilator lint_off WIDTHCONCAT */
module input0_buffer (
  input logic[0:0] clk_i,
  input logic[0:0] rst_ni,
  output logic[0:0] _inp_beat_ack,
  input logic[0:0] _inp_beat_valid,
  input logic[33:0] _inp_beat_0
);
  logic[0:0] dest0_q;
  logic[0:0] last0_q;
  logic[33:0] packet0_q;
  logic[0:0] valid0_q;
  always_ff @(posedge clk_i or negedge rst_ni) begin : _proc_transition
    if (~rst_ni) begin
    end
  end
  logic[0:0] thread_0_wire$4;
  logic[0:0] thread_0_wire$3;
  logic[33:0] thread_0_wire$1;
  logic[0:0] thread_0_wire$0;
  assign thread_0_wire$0 = _inp_beat_valid;
  assign thread_0_wire$1 = _inp_beat_0;
  localparam logic[0:0] thread_0_wire$2 = 1'b1;
  assign thread_0_wire$3 = thread_0_wire$1[1 +: 1];
  assign thread_0_wire$4 = thread_0_wire$1[0 +: 1];
  for (genvar i = 0; i < 3; i ++) begin : EVENTS0
    logic event_current;
    end
  logic _init_0;
  logic _thread_0_event_counter_2_1_q, _thread_0_event_counter_2_1_n;
  assign EVENTS0[2].event_current = _thread_0_event_counter_2_1_q;
  assign _thread_0_event_counter_2_1_n = EVENTS0[0].event_current;
  assign EVENTS0[1].event_current = EVENTS0[0].event_current && thread_0_wire$0;
  assign EVENTS0[0].event_current = _init_0 || EVENTS0[2].event_current;
  assign _inp_beat_ack = EVENTS0[1].event_current;
  always_ff @(posedge clk_i or negedge rst_ni) begin : _thread_0_st_transition
    if (~rst_ni) begin
      _init_0 <= 1'b1;
      dest0_q <= '0;
      last0_q <= '0;
      packet0_q <= '0;
      valid0_q <= '0;
      _thread_0_event_counter_2_1_q <= '0;
    end else begin
      if (EVENTS0[1].event_current) begin
        last0_q[0 +: 1] <= thread_0_wire$4;
        dest0_q[0 +: 1] <= thread_0_wire$3;
        valid0_q[0 +: 1] <= thread_0_wire$2;
        packet0_q[0 +: 34] <= thread_0_wire$1;
      end
      _init_0 <= 1'b0;
      _thread_0_event_counter_2_1_q <= _thread_0_event_counter_2_1_n;
    end
  end
endmodule
module input1_buffer (
  input logic[0:0] clk_i,
  input logic[0:0] rst_ni,
  output logic[0:0] _inp_beat_ack,
  input logic[0:0] _inp_beat_valid,
  input logic[33:0] _inp_beat_0
);
  logic[0:0] dest1_q;
  logic[0:0] last1_q;
  logic[33:0] packet1_q;
  logic[0:0] valid1_q;
  always_ff @(posedge clk_i or negedge rst_ni) begin : _proc_transition
    if (~rst_ni) begin
    end
  end
  logic[0:0] thread_0_wire$4;
  logic[0:0] thread_0_wire$3;
  logic[33:0] thread_0_wire$1;
  logic[0:0] thread_0_wire$0;
  assign thread_0_wire$0 = _inp_beat_valid;
  assign thread_0_wire$1 = _inp_beat_0;
  localparam logic[0:0] thread_0_wire$2 = 1'b1;
  assign thread_0_wire$3 = thread_0_wire$1[1 +: 1];
  assign thread_0_wire$4 = thread_0_wire$1[0 +: 1];
  for (genvar i = 0; i < 3; i ++) begin : EVENTS0
    logic event_current;
    end
  logic _init_0;
  logic _thread_0_event_counter_2_1_q, _thread_0_event_counter_2_1_n;
  assign EVENTS0[2].event_current = _thread_0_event_counter_2_1_q;
  assign _thread_0_event_counter_2_1_n = EVENTS0[0].event_current;
  assign EVENTS0[1].event_current = EVENTS0[0].event_current && thread_0_wire$0;
  assign EVENTS0[0].event_current = _init_0 || EVENTS0[2].event_current;
  assign _inp_beat_ack = EVENTS0[1].event_current;
  always_ff @(posedge clk_i or negedge rst_ni) begin : _thread_0_st_transition
    if (~rst_ni) begin
      _init_0 <= 1'b1;
      dest1_q <= '0;
      last1_q <= '0;
      packet1_q <= '0;
      valid1_q <= '0;
      _thread_0_event_counter_2_1_q <= '0;
    end else begin
      if (EVENTS0[1].event_current) begin
        last1_q[0 +: 1] <= thread_0_wire$4;
        dest1_q[0 +: 1] <= thread_0_wire$3;
        valid1_q[0 +: 1] <= thread_0_wire$2;
        packet1_q[0 +: 34] <= thread_0_wire$1;
      end
      _init_0 <= 1'b0;
      _thread_0_event_counter_2_1_q <= _thread_0_event_counter_2_1_n;
    end
  end
endmodule
module output0_control (
  input logic[0:0] clk_i,
  input logic[0:0] rst_ni,
  input logic[0:0] _out0_beat_ack,
  output logic[0:0] _out0_beat_valid,
  output logic[33:0] _out0_beat_0
);
  logic[0:0] last0_q;
  logic[0:0] last1_q;
  logic[0:0] lock0_q;
  logic[0:0] owner0_q;
  logic[0:0] req0_q;
  logic[0:0] req1_q;
  logic[0:0] rr0_q;
  logic[0:0] winner0_q;
  always_ff @(posedge clk_i or negedge rst_ni) begin : _proc_transition
    if (~rst_ni) begin
      last0_q <= '0;
      last1_q <= '0;
    end
  end
  logic[0:0] thread_0_wire$55;
  logic[0:0] thread_0_wire$54;
  logic[0:0] thread_0_wire$53;
  logic[0:0] thread_0_wire$52;
  logic[0:0] thread_0_wire$51;
  logic[0:0] thread_0_wire$48;
  logic[0:0] thread_0_wire$46;
  logic[0:0] thread_0_wire$45;
  logic[0:0] thread_0_wire$43;
  logic[0:0] thread_0_wire$42;
  logic[0:0] thread_0_wire$40;
  logic[0:0] thread_0_wire$39;
  logic[0:0] thread_0_wire$38;
  logic[0:0] thread_0_wire$37;
  logic[0:0] thread_0_wire$36;
  logic[0:0] thread_0_wire$34;
  logic[0:0] thread_0_wire$33;
  logic[0:0] thread_0_wire$31;
  logic[0:0] thread_0_wire$30;
  logic[0:0] thread_0_wire$27;
  logic[0:0] thread_0_wire$25;
  logic[0:0] thread_0_wire$24;
  logic[0:0] thread_0_wire$21;
  logic[0:0] thread_0_wire$19;
  logic[0:0] thread_0_wire$18;
  logic[0:0] thread_0_wire$16;
  logic[0:0] thread_0_wire$15;
  logic[0:0] thread_0_wire$13;
  logic[0:0] thread_0_wire$12;
  logic[0:0] thread_0_wire$11;
  logic[0:0] thread_0_wire$8;
  logic[0:0] thread_0_wire$6;
  logic[0:0] thread_0_wire$5;
  logic[0:0] thread_0_wire$4;
  logic[0:0] thread_0_wire$2;
  localparam logic[0:0] thread_0_wire$0 = 1'b0;
  localparam logic[0:0] thread_0_wire$1 = 1'b0;
  assign thread_0_wire$2 = lock0_q;
  localparam logic[0:0] thread_0_wire$3 = 1'b1;
  assign thread_0_wire$4 = thread_0_wire$2 == thread_0_wire$3;
  assign thread_0_wire$5 = owner0_q;
  assign thread_0_wire$6 = rr0_q;
  localparam logic[0:0] thread_0_wire$7 = 1'b0;
  assign thread_0_wire$8 = thread_0_wire$6 == thread_0_wire$7;
  localparam logic[0:0] thread_0_wire$9 = 1'b0;
  localparam logic[0:0] thread_0_wire$10 = 1'b1;
  assign thread_0_wire$11 = (thread_0_wire$8) ? thread_0_wire$9 : thread_0_wire$10;
  assign thread_0_wire$12 = (thread_0_wire$4) ? thread_0_wire$5 : thread_0_wire$11;
  assign thread_0_wire$13 = lock0_q;
  localparam logic[0:0] thread_0_wire$14 = 1'b1;
  assign thread_0_wire$15 = thread_0_wire$13 == thread_0_wire$14;
  assign thread_0_wire$16 = owner0_q;
  localparam logic[0:0] thread_0_wire$17 = 1'b0;
  assign thread_0_wire$18 = thread_0_wire$16 == thread_0_wire$17;
  assign thread_0_wire$19 = last0_q;
  localparam logic[0:0] thread_0_wire$20 = 1'b1;
  assign thread_0_wire$21 = thread_0_wire$19 == thread_0_wire$20;
  localparam logic[0:0] thread_0_wire$22 = 1'b0;
  localparam logic[0:0] thread_0_wire$23 = 1'b1;
  assign thread_0_wire$24 = (thread_0_wire$21) ? thread_0_wire$22 : thread_0_wire$23;
  assign thread_0_wire$25 = last1_q;
  localparam logic[0:0] thread_0_wire$26 = 1'b1;
  assign thread_0_wire$27 = thread_0_wire$25 == thread_0_wire$26;
  localparam logic[0:0] thread_0_wire$28 = 1'b0;
  localparam logic[0:0] thread_0_wire$29 = 1'b1;
  assign thread_0_wire$30 = (thread_0_wire$27) ? thread_0_wire$28 : thread_0_wire$29;
  assign thread_0_wire$31 = (thread_0_wire$18) ? thread_0_wire$24 : thread_0_wire$30;
  localparam logic[0:0] thread_0_wire$32 = 1'b0;
  assign thread_0_wire$33 = (thread_0_wire$15) ? thread_0_wire$31 : thread_0_wire$32;
  assign thread_0_wire$34 = lock0_q;
  localparam logic[0:0] thread_0_wire$35 = 1'b1;
  assign thread_0_wire$36 = thread_0_wire$34 == thread_0_wire$35;
  assign thread_0_wire$37 = owner0_q;
  assign thread_0_wire$38 = winner0_q;
  assign thread_0_wire$39 = (thread_0_wire$36) ? thread_0_wire$37 : thread_0_wire$38;
  assign thread_0_wire$40 = req0_q;
  localparam logic[0:0] thread_0_wire$41 = 1'b1;
  assign thread_0_wire$42 = thread_0_wire$40 == thread_0_wire$41;
  assign thread_0_wire$43 = req1_q;
  localparam logic[0:0] thread_0_wire$44 = 1'b1;
  assign thread_0_wire$45 = thread_0_wire$43 == thread_0_wire$44;
  assign thread_0_wire$46 = winner0_q;
  localparam logic[0:0] thread_0_wire$47 = 1'b0;
  assign thread_0_wire$48 = thread_0_wire$46 == thread_0_wire$47;
  localparam logic[0:0] thread_0_wire$49 = 1'b1;
  localparam logic[0:0] thread_0_wire$50 = 1'b0;
  assign thread_0_wire$51 = (thread_0_wire$48) ? thread_0_wire$49 : thread_0_wire$50;
  assign thread_0_wire$52 = rr0_q;
  assign thread_0_wire$53 = (thread_0_wire$45) ? thread_0_wire$51 : thread_0_wire$52;
  assign thread_0_wire$54 = rr0_q;
  assign thread_0_wire$55 = (thread_0_wire$42) ? thread_0_wire$53 : thread_0_wire$54;
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
      lock0_q <= '0;
      owner0_q <= '0;
      req0_q <= '0;
      req1_q <= '0;
      rr0_q <= '0;
      winner0_q <= '0;
      _thread_0_event_counter_1_1_q <= '0;
    end else begin
      if (EVENTS0[0].event_current) begin
        rr0_q[0 +: 1] <= thread_0_wire$55;
        owner0_q[0 +: 1] <= thread_0_wire$39;
        lock0_q[0 +: 1] <= thread_0_wire$33;
        winner0_q[0 +: 1] <= thread_0_wire$12;
        req1_q[0 +: 1] <= thread_0_wire$1;
        req0_q[0 +: 1] <= thread_0_wire$0;
      end
      _init_0 <= 1'b0;
      _thread_0_event_counter_1_1_q <= _thread_0_event_counter_1_1_n;
    end
  end
endmodule
module output1_control (
  input logic[0:0] clk_i,
  input logic[0:0] rst_ni,
  input logic[0:0] _out1_beat_ack,
  output logic[0:0] _out1_beat_valid,
  output logic[33:0] _out1_beat_0
);
  logic[0:0] last0_q;
  logic[0:0] last1_q;
  logic[0:0] lock1_q;
  logic[0:0] owner1_q;
  logic[0:0] req0_q;
  logic[0:0] req1_q;
  logic[0:0] rr1_q;
  logic[0:0] winner1_q;
  always_ff @(posedge clk_i or negedge rst_ni) begin : _proc_transition
    if (~rst_ni) begin
      last0_q <= '0;
      last1_q <= '0;
    end
  end
  logic[0:0] thread_0_wire$55;
  logic[0:0] thread_0_wire$54;
  logic[0:0] thread_0_wire$53;
  logic[0:0] thread_0_wire$52;
  logic[0:0] thread_0_wire$51;
  logic[0:0] thread_0_wire$48;
  logic[0:0] thread_0_wire$46;
  logic[0:0] thread_0_wire$45;
  logic[0:0] thread_0_wire$43;
  logic[0:0] thread_0_wire$42;
  logic[0:0] thread_0_wire$40;
  logic[0:0] thread_0_wire$39;
  logic[0:0] thread_0_wire$38;
  logic[0:0] thread_0_wire$37;
  logic[0:0] thread_0_wire$36;
  logic[0:0] thread_0_wire$34;
  logic[0:0] thread_0_wire$33;
  logic[0:0] thread_0_wire$31;
  logic[0:0] thread_0_wire$30;
  logic[0:0] thread_0_wire$27;
  logic[0:0] thread_0_wire$25;
  logic[0:0] thread_0_wire$24;
  logic[0:0] thread_0_wire$21;
  logic[0:0] thread_0_wire$19;
  logic[0:0] thread_0_wire$18;
  logic[0:0] thread_0_wire$16;
  logic[0:0] thread_0_wire$15;
  logic[0:0] thread_0_wire$13;
  logic[0:0] thread_0_wire$12;
  logic[0:0] thread_0_wire$11;
  logic[0:0] thread_0_wire$8;
  logic[0:0] thread_0_wire$6;
  logic[0:0] thread_0_wire$5;
  logic[0:0] thread_0_wire$4;
  logic[0:0] thread_0_wire$2;
  localparam logic[0:0] thread_0_wire$0 = 1'b0;
  localparam logic[0:0] thread_0_wire$1 = 1'b0;
  assign thread_0_wire$2 = lock1_q;
  localparam logic[0:0] thread_0_wire$3 = 1'b1;
  assign thread_0_wire$4 = thread_0_wire$2 == thread_0_wire$3;
  assign thread_0_wire$5 = owner1_q;
  assign thread_0_wire$6 = rr1_q;
  localparam logic[0:0] thread_0_wire$7 = 1'b0;
  assign thread_0_wire$8 = thread_0_wire$6 == thread_0_wire$7;
  localparam logic[0:0] thread_0_wire$9 = 1'b0;
  localparam logic[0:0] thread_0_wire$10 = 1'b1;
  assign thread_0_wire$11 = (thread_0_wire$8) ? thread_0_wire$9 : thread_0_wire$10;
  assign thread_0_wire$12 = (thread_0_wire$4) ? thread_0_wire$5 : thread_0_wire$11;
  assign thread_0_wire$13 = lock1_q;
  localparam logic[0:0] thread_0_wire$14 = 1'b1;
  assign thread_0_wire$15 = thread_0_wire$13 == thread_0_wire$14;
  assign thread_0_wire$16 = owner1_q;
  localparam logic[0:0] thread_0_wire$17 = 1'b0;
  assign thread_0_wire$18 = thread_0_wire$16 == thread_0_wire$17;
  assign thread_0_wire$19 = last0_q;
  localparam logic[0:0] thread_0_wire$20 = 1'b1;
  assign thread_0_wire$21 = thread_0_wire$19 == thread_0_wire$20;
  localparam logic[0:0] thread_0_wire$22 = 1'b0;
  localparam logic[0:0] thread_0_wire$23 = 1'b1;
  assign thread_0_wire$24 = (thread_0_wire$21) ? thread_0_wire$22 : thread_0_wire$23;
  assign thread_0_wire$25 = last1_q;
  localparam logic[0:0] thread_0_wire$26 = 1'b1;
  assign thread_0_wire$27 = thread_0_wire$25 == thread_0_wire$26;
  localparam logic[0:0] thread_0_wire$28 = 1'b0;
  localparam logic[0:0] thread_0_wire$29 = 1'b1;
  assign thread_0_wire$30 = (thread_0_wire$27) ? thread_0_wire$28 : thread_0_wire$29;
  assign thread_0_wire$31 = (thread_0_wire$18) ? thread_0_wire$24 : thread_0_wire$30;
  localparam logic[0:0] thread_0_wire$32 = 1'b0;
  assign thread_0_wire$33 = (thread_0_wire$15) ? thread_0_wire$31 : thread_0_wire$32;
  assign thread_0_wire$34 = lock1_q;
  localparam logic[0:0] thread_0_wire$35 = 1'b1;
  assign thread_0_wire$36 = thread_0_wire$34 == thread_0_wire$35;
  assign thread_0_wire$37 = owner1_q;
  assign thread_0_wire$38 = winner1_q;
  assign thread_0_wire$39 = (thread_0_wire$36) ? thread_0_wire$37 : thread_0_wire$38;
  assign thread_0_wire$40 = req0_q;
  localparam logic[0:0] thread_0_wire$41 = 1'b1;
  assign thread_0_wire$42 = thread_0_wire$40 == thread_0_wire$41;
  assign thread_0_wire$43 = req1_q;
  localparam logic[0:0] thread_0_wire$44 = 1'b1;
  assign thread_0_wire$45 = thread_0_wire$43 == thread_0_wire$44;
  assign thread_0_wire$46 = winner1_q;
  localparam logic[0:0] thread_0_wire$47 = 1'b0;
  assign thread_0_wire$48 = thread_0_wire$46 == thread_0_wire$47;
  localparam logic[0:0] thread_0_wire$49 = 1'b1;
  localparam logic[0:0] thread_0_wire$50 = 1'b0;
  assign thread_0_wire$51 = (thread_0_wire$48) ? thread_0_wire$49 : thread_0_wire$50;
  assign thread_0_wire$52 = rr1_q;
  assign thread_0_wire$53 = (thread_0_wire$45) ? thread_0_wire$51 : thread_0_wire$52;
  assign thread_0_wire$54 = rr1_q;
  assign thread_0_wire$55 = (thread_0_wire$42) ? thread_0_wire$53 : thread_0_wire$54;
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
      lock1_q <= '0;
      owner1_q <= '0;
      req0_q <= '0;
      req1_q <= '0;
      rr1_q <= '0;
      winner1_q <= '0;
      _thread_0_event_counter_1_1_q <= '0;
    end else begin
      if (EVENTS0[0].event_current) begin
        rr1_q[0 +: 1] <= thread_0_wire$55;
        owner1_q[0 +: 1] <= thread_0_wire$39;
        lock1_q[0 +: 1] <= thread_0_wire$33;
        winner1_q[0 +: 1] <= thread_0_wire$12;
        req1_q[0 +: 1] <= thread_0_wire$1;
        req0_q[0 +: 1] <= thread_0_wire$0;
      end
      _init_0 <= 1'b0;
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
  input0_buffer _spawn_0 (
    .clk_i,
    .rst_ni
    ,._inp_beat_valid (_in0_le_beat_valid)
    ,._inp_beat_ack (_in0_le_beat_ack)
    ,._inp_beat_0 (_in0_le_beat_0)
  );
  input1_buffer _spawn_1 (
    .clk_i,
    .rst_ni
    ,._inp_beat_valid (_in1_le_beat_valid)
    ,._inp_beat_ack (_in1_le_beat_ack)
    ,._inp_beat_0 (_in1_le_beat_0)
  );
  output0_control _spawn_2 (
    .clk_i,
    .rst_ni
    ,._out0_beat_valid (_out0_le_beat_valid)
    ,._out0_beat_ack (_out0_le_beat_ack)
    ,._out0_beat_0 (_out0_le_beat_0)
  );
  output1_control _spawn_3 (
    .clk_i,
    .rst_ni
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
