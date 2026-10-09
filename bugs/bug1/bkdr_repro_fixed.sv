
module bkdr_repro_fixed (
  input  logic [7:0] target_idx_i,
  output logic       tgt_idx_err_o
);

  typedef enum logic [7:0] {
    Tgt0  = 8'd0,
    Tgt1  = 8'd1,
    Tgt2  = 8'd2,
    Tgt3  = 8'd3,
    Tgt4  = 8'd4,
    Tgt5  = 8'd5,
    Tgt6  = 8'd6,
    Tgt7  = 8'd7,
    Tgt8  = 8'd8,
    Tgt9  = 8'd9,
    Tgt10 = 8'd10,
    Tgt11 = 8'd11
  } bkdr_idx_e;

  bkdr_idx_e casted;

  assign casted = bkdr_idx_e'(target_idx_i);

  assign tgt_idx_err_o = !(
      casted == Tgt0  || casted == Tgt1  ||
      casted == Tgt2  || casted == Tgt3  ||
      casted == Tgt4  || casted == Tgt5  ||
      casted == Tgt6  || casted == Tgt7  ||
      casted == Tgt8  || casted == Tgt9  ||
      casted == Tgt10 || casted == Tgt11
  );

endmodule
