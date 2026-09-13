module bkdr_repro (
  input  logic [7:0] target_idx_i,
  output logic       tgt_idx_err_o
);
  typedef enum logic [2:0] {
    Tgt0, Tgt1, Tgt2, Tgt3, Tgt4
  } bkdr_idx_e;

  bkdr_idx_e casted;
  assign casted = bkdr_idx_e'(target_idx_i);

  // Same check as "inside {Tgt0,...,Tgt4}", written without the inside operator
  assign tgt_idx_err_o = !(casted == Tgt0 || casted == Tgt1 || casted == Tgt2 ||
                            casted == Tgt3 || casted == Tgt4);
endmodule
