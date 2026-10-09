 
module bkdr_repro_fixed (
  input  logic [7:0] target_idx_i,
  output logic       tgt_idx_err_o
);

  assign tgt_idx_err_o = (target_idx_i > 8'd11);

endmodule
