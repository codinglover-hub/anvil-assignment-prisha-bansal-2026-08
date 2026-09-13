module bkdr_repro_fixed (
  input  logic [7:0] target_idx_i,
  output logic       tgt_idx_err_o
);
  typedef enum logic [7:0] {   // <-- widened to 8 bits, matches target_idx_i
    Tgt0, Tgt1, Tgt2, Tgt3, Tgt4
  } bkdr_idx_e;

  bkdr_idx_e casted;
  assign casted = bkdr_idx_e'(target_idx_i);

  assign tgt_idx_err_o = !(casted == Tgt0 || casted == Tgt1 || casted == Tgt2 ||
                            casted == Tgt3 || casted == Tgt4);
endmodule
