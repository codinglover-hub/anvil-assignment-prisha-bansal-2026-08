`timescale 1ns/1ps

module tb_kmac;

    logic clk;
    logic rst_n;

    logic cmd_start;
    logic cmd_process;
    logic cmd_done;
    logic cmd_valid;

    logic [1:0] buggy_state;
    logic [1:0] fixed_state;

    kmac_buggy buggy (
        .clk        (clk),
        .rst_n      (rst_n),
        .cmd_start  (cmd_start),
        .cmd_process(cmd_process),
        .cmd_done   (cmd_done),
        .cmd_valid  (cmd_valid),
        .state      (buggy_state)
    );

    kmac_fixed fixed (
        .clk        (clk),
        .rst_n      (rst_n),
        .cmd_start  (cmd_start),
        .cmd_process(cmd_process),
        .cmd_done   (cmd_done),
        .cmd_valid  (cmd_valid),
        .state      (fixed_state)
    );

    // 10 ns clock
    always #5 clk = ~clk;

    initial begin

        clk = 0;

        rst_n       = 0;
        cmd_start   = 0;
        cmd_process = 0;
        cmd_done    = 0;
        cmd_valid   = 0;

        $display("");
        $display("========================================");
        $display(" KMAC #6842 BUG REPRODUCER");
        $display("========================================");
        $display("");

        // Reset
        #12;
        rst_n = 1;

        // --------------------------------------------------
        // STEP 1
        // Start a KMAC operation
        // --------------------------------------------------

        @(negedge clk);

        cmd_start = 1;

        @(negedge clk);

        cmd_start = 0;

        $display(
            "After START:      buggy=%0d fixed=%0d",
            buggy_state,
            fixed_state
        );

        // --------------------------------------------------
        // STEP 2
        // We are now in ABSORB.
        //
        // Send CmdDone, but mark it INVALID.
        //
        // This is the important condition.
        // --------------------------------------------------

        @(negedge clk);

        cmd_done  = 1;
        cmd_valid = 0;

        $display("");
        $display("Sending INVALID CmdDone...");
        $display("cmd_done  = %b", cmd_done);
        $display("cmd_valid = %b", cmd_valid);

        @(negedge clk);

        cmd_done = 0;

        // --------------------------------------------------
        // Check result
        // --------------------------------------------------

        $display("");
        $display("After INVALID CmdDone:");
        $display(
            "buggy state = %0d",
            buggy_state
        );

        $display(
            "fixed state = %0d",
            fixed_state
        );

        // --------------------------------------------------
        // The buggy design has incorrectly returned to IDLE.
        // The fixed design remains in ABSORB.
        // --------------------------------------------------

        if (buggy_state == 2'b00)
            $display("BUG REPRODUCED: buggy FSM returned to IDLE.");

        else
            $display("ERROR: buggy FSM did not reproduce.");

        if (fixed_state == 2'b01)
            $display("FIX VERIFIED: fixed FSM remained in ABSORB.");

        else
            $display("ERROR: fixed FSM changed state.");

        // --------------------------------------------------

        #20;

        $display("");
        $display("========================================");
        $display(" Simulation complete");
        $display("========================================");

        $finish;

    end

    // Print states every clock
    always @(posedge clk) begin

        if (rst_n) begin

            $display(
                "t=%0t | start=%b process=%b done=%b valid=%b | buggy=%0d fixed=%0d",
                $time,
                cmd_start,
                cmd_process,
                cmd_done,
                cmd_valid,
                buggy_state,
                fixed_state
            );

        end

    end

endmodule
