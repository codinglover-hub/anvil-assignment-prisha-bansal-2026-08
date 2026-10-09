
module bkdr_repro (
  input  logic [7:0] target_idx_i,
  output logic       tgt_idx_err_o
);
  typedef enum logic [3:0] {
    Tgt0  = 4'd0,
    Tgt1  = 4'd1,
    Tgt2  = 4'd2,
    Tgt3  = 4'd3,
    Tgt4  = 4'd4,
    Tgt5  = 4'd5,
    Tgt6  = 4'd6,
    Tgt7  = 4'd7,
    Tgt8  = 4'd8,
    Tgt9  = 4'd9,
    Tgt10 = 4'd10,
    Tgt11 = 4'd11
  } bkdr_idx_e;

  bkdr_idx_e casted;

  assign casted = bkdr_idx_e'(target_idx_i);

  assign tgt_idx_err_o =
      !(casted == Tgt0  || casted == Tgt1  ||
        casted == Tgt2  || casted == Tgt3  ||
        casted == Tgt4  || casted == Tgt5  ||
        casted == Tgt6  || casted == Tgt7  ||
        casted == Tgt8  || casted == Tgt9  ||
        casted == Tgt10 || casted == Tgt11);

endmodule
