`timescale 1ns/1ps

module router_sva #(
    parameter DATA_WIDTH = 32
)(
    input logic clk,
    input logic rst_n,

    // Input 0
    input logic [DATA_WIDTH-1:0] tdata0,
    input logic                  tvalid0,
    input logic                  tlast0,
    input logic                  tdest0,
    input logic                  tready0,

    // Input 1
    input logic [DATA_WIDTH-1:0] tdata1,
    input logic                  tvalid1,
    input logic                  tlast1,
    input logic                  tdest1,
    input logic                  tready1,

    // Output 0
    input logic [DATA_WIDTH-1:0] out_data0,
    input logic                  out_valid0,
    input logic                  out_last0,
    input logic                  out_src0,
    input logic                  out_ready0,

    // Output 1
    input logic [DATA_WIDTH-1:0] out_data1,
    input logic                  out_valid1,
    input logic                  out_last1,
    input logic                  out_src1,
    input logic                  out_ready1
);

    integer pass_count;
    integer fail_count;

    // Previous output values for handshake stability
    logic [DATA_WIDTH-1:0] prev_data0;
    logic [DATA_WIDTH-1:0] prev_data1;

    logic prev_valid0;
    logic prev_valid1;

    // Packet ownership
    logic lock0;
    logic lock1;

    logic owner0;
    logic owner1;


    // ============================================================
    // INITIALIZATION
    // ============================================================

    initial begin

        pass_count = 0;
        fail_count = 0;

        prev_data0 = '0;
        prev_data1 = '0;

        prev_valid0 = 1'b0;
        prev_valid1 = 1'b0;

        lock0 = 1'b0;
        lock1 = 1'b0;

        owner0 = 1'b0;
        owner1 = 1'b0;

    end


    // ============================================================
    // PROPERTY CHECKER
    // ============================================================

    always @(posedge clk) begin

        if (rst_n) begin

            // ====================================================
            // P1: HANDSHAKE STABILITY
            //
            // If VALID was high and READY is low, DATA must stay
            // unchanged.
            // ====================================================

            if (prev_valid0 && !out_ready0) begin

                if (out_data0 !== prev_data0) begin

                    $display(
                        "FAIL P1: OUT0 data changed during backpressure"
                    );

                    fail_count = fail_count + 1;

                end
                else begin

                    $display(
                        "PASS P1: OUT0 data stable during backpressure"
                    );

                    pass_count = pass_count + 1;

                end

            end


            if (prev_valid1 && !out_ready1) begin

                if (out_data1 !== prev_data1) begin

                    $display(
                        "FAIL P1: OUT1 data changed during backpressure"
                    );

                    fail_count = fail_count + 1;

                end
                else begin

                    $display(
                        "PASS P1: OUT1 data stable during backpressure"
                    );

                    pass_count = pass_count + 1;

                end

            end


            // ====================================================
            // P2: ROUTING CORRECTNESS
            //
            // OUT0 must correspond to destination 0.
            // OUT1 must correspond to destination 1.
            // ====================================================

            if (out_valid0 && out_ready0) begin

                if (out_src0 == 1'b0) begin

                    if (tdest0 == 1'b0) begin

                        $display(
                            "PASS P2: OUT0 correctly routed"
                        );

                        pass_count = pass_count + 1;

                    end
                    else begin

                        $display(
                            "FAIL P2: OUT0 has wrong destination"
                        );

                        fail_count = fail_count + 1;

                    end

                end
                else begin

                    if (tdest1 == 1'b0) begin

                        $display(
                            "PASS P2: OUT0 correctly routed"
                        );

                        pass_count = pass_count + 1;

                    end
                    else begin

                        $display(
                            "FAIL P2: OUT0 has wrong destination"
                        );

                        fail_count = fail_count + 1;

                    end

                end

            end


            if (out_valid1 && out_ready1) begin

                if (out_src1 == 1'b0) begin

                    if (tdest0 == 1'b1) begin

                        $display(
                            "PASS P2: OUT1 correctly routed"
                        );

                        pass_count = pass_count + 1;

                    end
                    else begin

                        $display(
                            "FAIL P2: OUT1 has wrong destination"
                        );

                        fail_count = fail_count + 1;

                    end

                end
                else begin

                    if (tdest1 == 1'b1) begin

                        $display(
                            "PASS P2: OUT1 correctly routed"
                        );

                        pass_count = pass_count + 1;

                    end
                    else begin

                        $display(
                            "FAIL P2: OUT1 has wrong destination"
                        );

                        fail_count = fail_count + 1;

                    end

                end

            end


            // ====================================================
            // P3: TLAST TERMINATION
            //
            // A packet ending in TLAST must be transferred with
            // VALID && READY.
            // ====================================================

            if (out_valid0 && out_ready0 && out_last0) begin

                $display(
                    "PASS P3: OUT0 packet terminated with TLAST"
                );

                pass_count = pass_count + 1;

            end


            if (out_valid1 && out_ready1 && out_last1) begin

                $display(
                    "PASS P3: OUT1 packet terminated with TLAST"
                );

                pass_count = pass_count + 1;

            end


            // ====================================================
            // P4: MUTUAL EXCLUSION
            //
            // The same input cannot be selected by both outputs
            // at the same time.
            // ====================================================

            if (out_valid0 && out_valid1) begin

                if (out_src0 == out_src1) begin

                    $display(
                        "FAIL P4: Same input selected by both outputs"
                    );

                    fail_count = fail_count + 1;

                end
                else begin

                    $display(
                        "PASS P4: Arbitration is mutually exclusive"
                    );

                    pass_count = pass_count + 1;

                end

            end


            // ====================================================
            // P5: PACKET OWNERSHIP
            //
            // Once a multi-beat packet starts, the same source
            // must remain owner until TLAST.
            // ====================================================

            if (lock0 && out_valid0) begin

                if (out_src0 != owner0) begin

                    $display(
                        "FAIL P5: OUT0 packet ownership changed"
                    );

                    fail_count = fail_count + 1;

                end
                else begin

                    $display(
                        "PASS P5: OUT0 packet ownership maintained"
                    );

                    pass_count = pass_count + 1;

                end

            end


            if (lock1 && out_valid1) begin

                if (out_src1 != owner1) begin

                    $display(
                        "FAIL P5: OUT1 packet ownership changed"
                    );

                    fail_count = fail_count + 1;

                end
                else begin

                    $display(
                        "PASS P5: OUT1 packet ownership maintained"
                    );

                    pass_count = pass_count + 1;

                end

            end


            // ====================================================
            // UPDATE PACKET LOCK FOR OUTPUT 0
            // ====================================================

            if (out_valid0 && out_ready0) begin

                if (!lock0) begin

                    owner0 = out_src0;

                    if (!out_last0)
                        lock0 = 1'b1;

                end
                else begin

                    if (out_last0)
                        lock0 = 1'b0;

                end

            end


            // ====================================================
            // UPDATE PACKET LOCK FOR OUTPUT 1
            // ====================================================

            if (out_valid1 && out_ready1) begin

                if (!lock1) begin

                    owner1 = out_src1;

                    if (!out_last1)
                        lock1 = 1'b1;

                end
                else begin

                    if (out_last1)
                        lock1 = 1'b0;

                end

            end


            // ====================================================
            // SAVE PREVIOUS VALUES
            // ====================================================

            prev_data0 = out_data0;
            prev_data1 = out_data1;

            prev_valid0 = out_valid0;
            prev_valid1 = out_valid1;

        end

    end


    // ============================================================
    // FINAL REPORT
    // ============================================================

    final begin

        $display("");
        $display("==========================================");
        $display("PART 1-B PROPERTY SUMMARY");
        $display("==========================================");

        $display(
            "PROPERTY PASSES = %0d",
            pass_count
        );

        $display(
            "PROPERTY FAILS  = %0d",
            fail_count
        );

        if (fail_count == 0 && pass_count > 0) begin

            $display(
                "RESULT: ALL EXECUTED PROPERTIES PASSED"
            );

        end
        else if (fail_count > 0) begin

            $display(
                "RESULT: PROPERTY VIOLATIONS DETECTED"
            );

        end
        else begin

            $display(
                "RESULT: NO PROPERTIES EXECUTED"
            );

        end

        $display("==========================================");

    end

endmodule
