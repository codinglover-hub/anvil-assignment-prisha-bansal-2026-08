module bkdr_repro_tb;
  logic [7:0] target_idx;
  logic       tgt_idx_err;

  bkdr_repro dut (
    .target_idx_i(target_idx),
    .tgt_idx_err_o(tgt_idx_err)
  );

  initial begin
    // Legal values: 0-4 should NOT error
    // Illegal-but-aliasing: 8, 16, 24... should error but WON'T (the bug)
    test_val(0,  0);  // legal
    test_val(4,  0);  // legal
    test_val(5,  1);  // illegal, no alias -> correctly caught
    test_val(8,  1);  // illegal, ALIASES to Tgt0 -> bug: wrongly accepted
    test_val(16, 1);  // illegal, aliases to Tgt0 -> bug
    test_val(24, 1);  // illegal, aliases to Tgt0 -> bug
    $finish;
  end

  task test_val(input [7:0] val, input expect_err);
    target_idx = val;
    #1;
    if (tgt_idx_err !== expect_err)
      $display("FAIL: target_idx=%0d  expected err=%0d  got err=%0d  <-- BUG TRIGGERED",
                val, expect_err, tgt_idx_err);
    else
      $display("PASS: target_idx=%0d  err=%0d", val, tgt_idx_err);
  endtask
endmodule
