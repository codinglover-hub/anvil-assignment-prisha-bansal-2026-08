`timescale 1ns/1ps

// ============================================================================
// PART B - ROUTER VERIFICATION CHECKER
// ============================================================================
//
// DUT:
//   2-input / 2-output ready-valid stream router.
//
// Verification properties:
//
//   P1  - Routing correctness
//   P2  - Data and TLAST correctness
//   P3  - Ready/Valid stability under backpressure
//   P4  - Mutual exclusion
//   P5  - Packet locking and ownership
//   P6A - Round-robin pointer update
//   P6B - Fairness under contention
//
// Icarus Verilog 13.0 does not support the concurrent SVA constructs used
// by SystemVerilog Assertions. Therefore the checker below implements the
// same temporal intent using procedural clocked checks.
//
// ============================================================================

module router_sva (

    input logic        clk,
    input logic        rst_n,

    // ------------------------------------------------------------------------
    // Input 0
    // ------------------------------------------------------------------------

    input logic [31:0] in0_tdata,
    input logic        in0_tvalid,
    input logic        in0_tready,
    input logic        in0_tlast,
    input logic        in0_tdest,

    // ------------------------------------------------------------------------
    // Input 1
    // ------------------------------------------------------------------------

    input logic [31:0] in1_tdata,
    input logic        in1_tvalid,
    input logic        in1_tready,
    input logic        in1_tlast,
    input logic        in1_tdest,

    // ------------------------------------------------------------------------
    // Output 0
    // ------------------------------------------------------------------------

    input logic [31:0] out0_tdata,
    input logic        out0_tvalid,
    input logic        out0_tready,
    input logic        out0_tlast,

    // ------------------------------------------------------------------------
    // Output 1
    // ------------------------------------------------------------------------

    input logic [31:0] out1_tdata,
    input logic        out1_tvalid,
    input logic        out1_tready,
    input logic        out1_tlast,

    // ------------------------------------------------------------------------
    // Internal router state
    // ------------------------------------------------------------------------

    input logic lock0,
    input logic lock1,

    input logic owner0,
    input logic owner1,

    input logic rr0,
    input logic rr1,

    input logic grant0,
    input logic grant1,

    input logic sel0,
    input logic sel1
);

    // =========================================================================
    // ERROR COUNTER
    // =========================================================================

    integer assertion_errors;

    // =========================================================================
    // FAIRNESS COUNTERS
    // =========================================================================

    integer fairness_o0_i0_count;
    integer fairness_o0_i1_count;

    integer fairness_o1_i0_count;
    integer fairness_o1_i1_count;

    // =========================================================================
    // PREVIOUS-CYCLE SIGNALS
    // =========================================================================

    logic        prev_out0_valid;
    logic        prev_out0_ready;
    logic [31:0] prev_out0_data;
    logic        prev_out0_last;

    logic        prev_out1_valid;
    logic        prev_out1_ready;
    logic [31:0] prev_out1_data;
    logic        prev_out1_last;

    logic        prev_out0_transfer;
    logic        prev_out1_transfer;

    logic        prev_out0_nonlast_transfer;
    logic        prev_out1_nonlast_transfer;

    logic        prev_out0_last_transfer;
    logic        prev_out1_last_transfer;

    logic        prev_sel0;
    logic        prev_sel1;

    logic        prev_lock0;
    logic        prev_lock1;

    logic        prev_owner0;
    logic        prev_owner1;

    logic        prev_contested0;
    logic        prev_contested1;

    // =========================================================================
    // EXPECTED RR VALUES
    //
    // These are generated when a contested TLAST transfer occurs.
    // They are checked after the DUT's nonblocking state update.
    // ===================================

    logic        check_rr0;
    logic        check_rr1;

    logic        expected_rr0;
    logic        expected_rr1;

    // =========================================================================
    // INITIALIZATION
    // =========================================================================

    initial begin

        assertion_errors = 0;

        fairness_o0_i0_count = 0;
        fairness_o0_i1_count = 0;

        fairness_o1_i0_count = 0;
        fairness_o1_i1_count = 0;

        prev_out0_valid = 0;
        prev_out0_ready = 0;
        prev_out0_data = 0;
        prev_out0_last = 0;

        prev_out1_valid = 0;
        prev_out1_ready = 0;
        prev_out1_data = 0;
        prev_out1_last = 0;

        prev_out0_transfer = 0;
        prev_out1_transfer = 0;

        prev_out0_nonlast_transfer = 0;
        prev_out1_nonlast_transfer = 0;

        prev_out0_last_transfer = 0;
        prev_out1_last_transfer = 0;

        prev_sel0 = 0;
        prev_sel1 = 0;

        prev_lock0 = 0;
        prev_lock1 = 0;

        prev_owner0 = 0;
        prev_owner1 = 0;

        prev_contested0 = 0;
        prev_contested1 = 0;

        check_rr0 = 0;
        check_rr1 = 0;

        expected_rr0 = 0;
        expected_rr1 = 0;

    end

    // =========================================================================
    // FAILURE TASK
    // =========================================================================

    task automatic report_failure(input [255:0] message);
        begin
            assertion_errors = assertion_errors + 1;
            $display("ASSERTION FAIL: %0s", message);
        end
    endtask

    // =========================================================================
    // MAIN CHECKER
    //
    // This block samples the signals at the transfer edge.
    // =========================================================================

    always @(posedge clk) begin

        // =====================================================================
        // RESET
        // =====================================================================

        if (!rst_n) begin

            prev_out0_valid = 0;
            prev_out0_ready = 0;
            prev_out0_data = 0;
            prev_out0_last = 0;

            prev_out1_valid = 0;
            prev_out1_ready = 0;
            prev_out1_data = 0;
            prev_out1_last = 0;

            prev_out0_transfer = 0;
            prev_out1_transfer = 0;

            prev_out0_nonlast_transfer = 0;
            prev_out1_nonlast_transfer = 0;

            prev_out0_last_transfer = 0;
            prev_out1_last_transfer = 0;

            prev_sel0 = 0;
            prev_sel1 = 0;

            prev_lock0 = 0;
            prev_lock1 = 0;

            prev_owner0 = 0;
            prev_owner1 = 0;

            prev_contested0 = 0;
            prev_contested1 = 0;

            check_rr0 = 0;
            check_rr1 = 0;

            expected_rr0 = 0;
            expected_rr1 = 0;

            fairness_o0_i0_count = 0;
            fairness_o0_i1_count = 0;

            fairness_o1_i0_count = 0;
            fairness_o1_i1_count = 0;

            assertion_errors = 0;

        end

        else begin

            // =================================================================
            // P1 - ROUTING CORRECTNESS
            // =================================================================
            //
            // Destination 0 -> Output 0
            // Destination 1 -> Output 1
            //
            // Check only when VALID is asserted.
            // =================================================================

            if (out0_tvalid === 1'b1) begin

                if (sel0 === 1'b0) begin

                    if (in0_tdest !== 1'b0)
                        report_failure(
                            "P1: Output 0 selected Input 0 with wrong destination"
                        );

                end
                else if (sel0 === 1'b1) begin

                    if (in1_tdest !== 1'b0)
                        report_failure(
                            "P1: Output 0 selected Input 1 with wrong destination"
                        );

                end
            end


            if (out1_tvalid === 1'b1) begin

                if (sel1 === 1'b0) begin

                    if (in0_tdest !== 1'b1)
                        report_failure(
                            "P1: Output 1 selected Input 0 with wrong destination"
                        );

                end
                else if (sel1 === 1'b1) begin

                    if (in1_tdest !== 1'b1)
                        report_failure(
                            "P1: Output 1 selected Input 1 with wrong destination"
                        );

                end
            end


            // =================================================================
            // P2 - DATA AND TLAST CORRECTNESS
            // =================================================================
            //
            // The output must carry the selected input's payload and TLAST.
            // =================================================================

            if ((out0_tvalid === 1'b1) &&
                (out0_tready === 1'b1)) begin

                if (sel0 === 1'b0) begin

                    if (out0_tdata !== in0_tdata)
                        report_failure(
                            "P2: Output 0 data mismatch from Input 0"
                        );

                    if (out0_tlast !== in0_tlast)
                        report_failure(
                            "P2: Output 0 TLAST mismatch from Input 0"
                        );

                end
                else if (sel0 === 1'b1) begin

                    if (out0_tdata !== in1_tdata)
                        report_failure(
                            "P2: Output 0 data mismatch from Input 1"
                        );

                    if (out0_tlast !== in1_tlast)
                        report_failure(
                            "P2: Output 0 TLAST mismatch from Input 1"
                        );
                end
            end


            if ((out1_tvalid === 1'b1) &&
                (out1_tready === 1'b1)) begin

                if (sel1 === 1'b0) begin

                    if (out1_tdata !== in0_tdata)
                        report_failure(
                            "P2: Output 1 data mismatch from Input 0"
                        );

                    if (out1_tlast !== in0_tlast)
                        report_failure(
                            "P2: Output 1 TLAST mismatch from Input 0"
                        );

                end
                else if (sel1 === 1'b1) begin

                    if (out1_tdata !== in1_tdata)
                        report_failure(
                            "P2: Output 1 data mismatch from Input 1"
                        );

                    if (out1_tlast !== in1_tlast)
                        report_failure(
                            "P2: Output 1 TLAST mismatch from Input 1"
                        );
                end
            end


            // =================================================================
            // P3 - READY / VALID STABILITY
            // =================================================================
            //
            // When VALID=1 and READY=0, data and TLAST must remain unchanged.
            // =================================================================

            if ((prev_out0_valid === 1'b1) &&
                (prev_out0_ready === 1'b0)) begin

                if (out0_tvalid !== 1'b1)
                    report_failure(
                        "P3: Output 0 VALID changed during backpressure"
                    );

                if (out0_tdata !== prev_out0_data)
                    report_failure(
                        "P3: Output 0 DATA changed during backpressure"
                    );

                if (out0_tlast !== prev_out0_last)
                    report_failure(
                        "P3: Output 0 TLAST changed during backpressure"
                    );
            end


            if ((prev_out1_valid === 1'b1) &&
                (prev_out1_ready === 1'b0)) begin

                if (out1_tvalid !== 1'b1)
                    report_failure(
                        "P3: Output 1 VALID changed during backpressure"
                    );

                if (out1_tdata !== prev_out1_data)
                    report_failure(
                        "P3: Output 1 DATA changed during backpressure"
                    );

                if (out1_tlast !== prev_out1_last)
                    report_failure(
                        "P3: Output 1 TLAST changed during backpressure"
                    );
            end


            // =================================================================
            // P4 - MUTUAL EXCLUSION
            // =====================================================================
            //
            // An input cannot be selected by both outputs at the same time.
            // =================================================================

            if ((grant0 === 1'b1) &&
                (grant1 === 1'b1)) begin

                if ((sel0 === 1'b0) &&
                    (sel1 === 1'b0))

                    report_failure(
                        "P4: Input 0 selected by both outputs"
                    );

                if ((sel0 === 1'b1) &&
                    (sel1 === 1'b1))

                    report_failure(
                        "P4: Input 1 selected by both outputs"
                    );
            end


            // =================================================================
            // P5 - PACKET LOCK CREATION
            // =====================================================================
            //
            // If a non-final beat transfers, the output must become locked.
            // =================================================================

            if (prev_out0_nonlast_transfer === 1'b1) begin

                if (lock0 !== 1'b1)
                    report_failure(
                        "P5: Output 0 did not lock after non-final transfer"
                    );

                if (owner0 !== prev_sel0)
                    report_failure(
                        "P5: Output 0 owner incorrect after non-final transfer"
                    );
            end


            if (prev_out1_nonlast_transfer === 1'b1) begin

                if (lock1 !== 1'b1)
                    report_failure(
                        "P5: Output 1 did not lock after non-final transfer"
                    );

                if (owner1 !== prev_sel1)
                    report_failure(
                        "P5: Output 1 owner incorrect after non-final transfer"
                    );
            end


            // =================================================================
            // P5 - PACKET OWNERSHIP
            // =====================================================================
            // Do NOT check ownership across a TLAST transfer.
            //
            // After TLAST the lock is intentionally released and arbitration
            // is allowed to choose another input.
            // =====================================================================

            if ((prev_lock0 === 1'b1) &&
                (prev_out0_transfer === 1'b1) &&
                (prev_out0_last_transfer === 1'b0)) begin

                if (sel0 !== prev_owner0)
                    report_failure(
                        "P5: Output 0 changed owner before packet completion"
                    );
            end


            if ((prev_lock1 === 1'b1) &&
                (prev_out1_transfer === 1'b1) &&
                (prev_out1_last_transfer === 1'b0)) begin

                if (sel1 !== prev_owner1)
                    report_failure(
                        "P5: Output 1 changed owner before packet completion"
                    );
            end


            // =================================================================
            // P5 - LOCK RELEASE
            // =====================================================================

            if (prev_out0_last_transfer === 1'b1) begin

                // Router releases lock on TLAST.
                // The check is performed after the DUT update below.
                fork
                    begin
                        #1;
                        if (lock0 !== 1'b0)
                            report_failure(
                                "P5: Output 0 remained locked after TLAST"
                            );
                    end
                join_none

            end


            if (prev_out1_last_transfer === 1'b1) begin

                fork
                    begin
                        #1;
                        if (lock1 !== 1'b0)
                            report_failure(
                                "P5: Output 1 remained locked after TLAST"
                            );
                    end
                join_none

            end


            // =================================================================
            // P6A - ROUND-ROBIN
            // =====================================================================
            //
            // If both inputs contend and the winning packet ends:
            //
            //     winner 0 -> rr becomes 1
            // =====================================================================

            if ((out0_tvalid === 1'b1) &&
                (out0_tready === 1'b1) &&
                (out0_tlast === 1'b1) &&
                (in0_tvalid === 1'b1) &&
                (in1_tvalid === 1'b1) &&
                (in0_tdest === 1'b0) &&
                (in1_tdest === 1'b0)) begin

                check_rr0 = 1'b1;

                if (sel0 === 1'b0)
                    expected_rr0 = 1'b1;
                else
                    expected_rr0 = 1'b0;

            end


            if ((out1_tvalid === 1'b1) &&
                (out1_tready === 1'b1) &&
                (out1_tlast === 1'b1) &&
                (in0_tvalid === 1'b1) &&
                (in1_tvalid === 1'b1) &&
                (in0_tdest === 1'b1) &&
                (in1_tdest === 1'b1)) begin

                check_rr1 = 1'b1;

                if (sel1 === 1'b0)
                    expected_rr1 = 1'b1;
                else
                    expected_rr1 = 1'b0;

            end


            // =================================================================
            // P6B - FAIRNESS
            // =====================================================================
            //
            // Count every actual contested transfer.
            // =====================================================================

            if ((in0_tvalid === 1'b1) &&
                (in1_tvalid === 1'b1) &&
                (in0_tdest === 1'b0) &&
                (in1_tdest === 1'b0) &&
                (out0_tvalid === 1'b1) &&
                (out0_tready === 1'b1)) begin

                if (sel0 === 1'b0)
                    fairness_o0_i0_count =
                        fairness_o0_i0_count + 1;

                else if (sel0 === 1'b1)
                    fairness_o0_i1_count =
                        fairness_o0_i1_count + 1;

            end


            if ((in0_tvalid === 1'b1) &&
                (in1_tvalid === 1'b1) &&
                (in0_tdest === 1'b1) &&
                (in1_tdest === 1'b1) &&
                (out1_tvalid === 1'b1) &&
                (out1_tready === 1'b1)) begin

                if (sel1 === 1'b0)
                    fairness_o1_i0_count =
                        fairness_o1_i0_count + 1;

                else if (sel1 === 1'b1)
                    fairness_o1_i1_count =
                        fairness_o1_i1_count + 1;

            end


            // =================================================================
            // SAVE CURRENT VALUES
            // =================================================================

            prev_out0_valid = out0_tvalid;
            prev_out0_ready = out0_tready;
            prev_out0_data = out0_tdata;
            prev_out0_last = out0_tlast;

            prev_out1_valid = out1_tvalid;
            prev_out1_ready = out1_tready;
            prev_out1_data = out1_tdata;
            prev_out1_last = out1_tlast;

            prev_out0_transfer =
                (out0_tvalid === 1'b1) &&
                (out0_tready === 1'b1);

            prev_out1_transfer =
                (out1_tvalid === 1'b1) &&
                (out1_tready === 1'b1);

            prev_out0_nonlast_transfer =
                (out0_tvalid === 1'b1) &&
                (out0_tready === 1'b1) &&
                (out0_tlast === 1'b0);

            prev_out1_nonlast_transfer =
                (out1_tvalid === 1'b1) &&
                (out1_tready === 1'b1) &&
                (out1_tlast === 1'b0);

            prev_out0_last_transfer =
                (out0_tvalid === 1'b1) &&
                (out0_tready === 1'b1) &&
                (out0_tlast === 1'b1);

            prev_out1_last_transfer =
                (out1_tvalid === 1'b1) &&
                (out1_tready === 1'b1) &&
                (out1_tlast === 1'b1);

            prev_sel0 = sel0;
            prev_sel1 = sel1;

            prev_lock0 = lock0;
            prev_lock1 = lock1;

            prev_owner0 = owner0;
            prev_owner1 = owner1;

            prev_contested0 =
                (in0_tvalid === 1'b1) &&
                (in1_tvalid === 1'b1) &&
                (in0_tdest === 1'b0) &&
                (in1_tdest === 1'b0);

            prev_contested1 =
                (in0_tvalid === 1'b1) &&
                (in1_tvalid === 1'b1) &&
                (in0_tdest === 1'b1) &&
                (in1_tdest === 1'b1);

        end
    end


    // =========================================================================
    // P6A POST-CLOCK CHECK
    //
    // Separate block because rr0/rr1 are updated by the DUT with <=.
    // =========================================================================

    always @(negedge clk) begin

        if (rst_n) begin

            if (check_rr0 === 1'b1) begin

                if (rr0 !== expected_rr0)
                    report_failure(
                        "P6A: Output 0 round-robin pointer update incorrect"
                    );

                check_rr0 = 1'b0;

            end


            if (check_rr1 === 1'b1) begin

                if (rr1 !== expected_rr1)
                    report_failure(
                        "P6A: Output 1 round-robin pointer update incorrect"
                    );

                check_rr1 = 1'b0;

            end

        end

    end


    // =========================================================================
    // FINAL REPORT
    // =========================================================================

    final begin

        $display("ROUTER CHECKER RESULT");

        if (assertion_errors == 0)
            $display("CORE CHECKS : PASS");
        else begin
            $display(
                "CORE CHECKS : FAIL (%0d errors)",
                assertion_errors
            );
        end

        
        $display("P6B FAIRNESS RESULTS");
        

        $display(
            "Output 0 / Input 0 contention wins : %0d",
            fairness_o0_i0_count
        );

        $display(
            "Output 0 / Input 1 contention wins : %0d",
            fairness_o0_i1_count
        );

        $display(
            "Output 1 / Input 0 contention wins : %0d",
            fairness_o1_i0_count
        );

        $display(
            "Output 1 / Input 1 contention wins : %0d",
            fairness_o1_i1_count
        );

        $display("");

        if ((fairness_o0_i0_count > 0) &&
            (fairness_o0_i1_count > 0))

            $display("Output 0 fairness : PASS");

        else

            $display("Output 0 fairness : NOT DEMONSTRATED");


        if ((fairness_o1_i0_count > 0) &&
            (fairness_o1_i1_count > 0))

            $display("Output 1 fairness : PASS");

        else

            $display("Output 1 fairness : NOT DEMONSTRATED");



        if (assertion_errors == 0)

            $display("RESULT : PASS");

        else

            $display("RESULT : FAIL");

        $display("============================================================");

    end

endmodule

