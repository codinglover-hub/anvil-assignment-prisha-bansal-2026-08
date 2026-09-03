
`timescale 1ns/1ps

// ============================================================================
// ROUTER TESTBENCH
// ============================================================================
// 2-input / 2-output ready-valid stream router
//
// Tests:
//   1. Input 0 -> Output 0
//   2. Input 1 -> Output 1
//   3. Concurrent traffic
//   4. Contention / Round-robin
//   5. Backpressure
//   6. Multi-beat packet locking
//   7. Output 0 stability
//   8. Output 1 stability
//   9. Output 0 TLAST
//  10. Output 1 TLAST
//  11. Reset behaviour
//  12. Mixed traffic
//  13. Round-robin fairness - Output 0
//  14. Round-robin fairness - Output 1
// ============================================================================

module tb_router_sva;

    // =========================================================================
    // CLOCK / RESET
    // =========================================================================

    logic clk;
    logic rst_n;

    // =========================================================================
    // INPUT 0
    // =========================================================================

    logic [31:0] in0_tdata;
    logic        in0_tvalid;
    logic        in0_tready;
    logic        in0_tlast;
    logic        in0_tdest;

    // =========================================================================
    // INPUT 1
    // =========================================================================

    logic [31:0] in1_tdata;
    logic        in1_tvalid;
    logic        in1_tready;
    logic        in1_tlast;
    logic        in1_tdest;

    // =========================================================================
    // OUTPUT 0
    // =========================================================================

    logic [31:0] out0_tdata;
    logic        out0_tvalid;
    logic        out0_tready;
    logic        out0_tlast;

    // =========================================================================
    // OUTPUT 1
    // =========================================================================

    logic [31:0] out1_tdata;
    logic        out1_tvalid;
    logic        out1_tready;
    logic        out1_tlast;

    // =========================================================================
    // TEST COUNTERS
    // =========================================================================

    integer test_count;
    integer pass_count;
    integer fail_count;

    // =========================================================================
    // DUT
    // =========================================================================

    router dut (
        .clk        (clk),
        .rst_n      (rst_n),

        .in0_tdata  (in0_tdata),
        .in0_tvalid (in0_tvalid),
        .in0_tready (in0_tready),
        .in0_tlast  (in0_tlast),
        .in0_tdest  (in0_tdest),

        .in1_tdata  (in1_tdata),
        .in1_tvalid (in1_tvalid),
        .in1_tready (in1_tready),
        .in1_tlast  (in1_tlast),
        .in1_tdest  (in1_tdest),

        .out0_tdata  (out0_tdata),
        .out0_tvalid (out0_tvalid),
        .out0_tready (out0_tready),
        .out0_tlast  (out0_tlast),

        .out1_tdata  (out1_tdata),
        .out1_tvalid (out1_tvalid),
        .out1_tready (out1_tready),
        .out1_tlast  (out1_tlast)
    );

    // =========================================================================
    // PROCEDURAL SVA CHECKER
    // =========================================================================

    router_sva u_checker (

        .clk  (clk),
        .rst_n(rst_n),

        .in0_tdata (in0_tdata),
        .in0_tvalid(in0_tvalid),
        .in0_tready(in0_tready),
        .in0_tlast (in0_tlast),
        .in0_tdest (in0_tdest),

        .in1_tdata (in1_tdata),
        .in1_tvalid(in1_tvalid),
        .in1_tready(in1_tready),
        .in1_tlast (in1_tlast),
        .in1_tdest (in1_tdest),

        .out0_tdata (out0_tdata),
        .out0_tvalid(out0_tvalid),
        .out0_tready(out0_tready),
        .out0_tlast (out0_tlast),

        .out1_tdata (out1_tdata),
        .out1_tvalid(out1_tvalid),
        .out1_tready(out1_tready),
        .out1_tlast (out1_tlast),

        .lock0 (dut.lock0),
        .lock1 (dut.lock1),

        .owner0(dut.owner0),
        .owner1(dut.owner1),

        .rr0(dut.rr0),
        .rr1(dut.rr1),

        .grant0(dut.grant0),
        .grant1(dut.grant1),

        .sel0(dut.sel0),
        .sel1(dut.sel1)
    );

    // =========================================================================
    // CLOCK
    // =========================================================================

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // =========================================================================
    // HELPER TASKS
    // =========================================================================

    task automatic clear_inputs;
        begin
            in0_tdata  = 32'b0;
            in0_tvalid = 1'b0;
            in0_tlast  = 1'b0;
            in0_tdest  = 1'b0;

            in1_tdata  = 32'b0;
            in1_tvalid = 1'b0;
            in1_tlast  = 1'b0;
            in1_tdest  = 1'b0;

            out0_tready = 1'b0;
            out1_tready = 1'b0;
        end
    endtask


    task automatic reset_dut;
        begin

            rst_n = 1'b0;
            clear_inputs();

            repeat (3)
                @(posedge clk);

            @(negedge clk);
            rst_n = 1'b1;

            @(negedge clk);

        end
    endtask


    task automatic start_test(input [255:0] name);
        begin

            test_count = test_count + 1;

            $display("TEST %0d: %0s", test_count, name);
           

        end
    endtask


    task automatic pass(input [255:0] message);
        begin
            pass_count = pass_count + 1;
            $display("PASS: %0s", message);
        end
    endtask


    task automatic fail(input [255:0] message);
        begin
            fail_count = fail_count + 1;
            $display("FAIL: %0s", message);
        end
    endtask


    // =========================================================================
    // TEST 1
    // INPUT 0 -> OUTPUT 0
    // =========================================================================

    task automatic test_input0_output0;

        begin

            start_test("INPUT 0 -> OUTPUT 0");

            reset_dut();

            @(negedge clk);

            in0_tdata  = 32'h0000_0010;
            in0_tvalid = 1'b1;
            in0_tlast  = 1'b1;
            in0_tdest  = 1'b0;

            out0_tready = 1'b1;

            #1;

            if ((out0_tvalid === 1'b1) &&
                (out0_tdata === 32'h0000_0010) &&
                (out0_tlast === 1'b1))
                pass("Input 0 correctly routed to Output 0");
            else
                fail("Input 0 did not route to Output 0");

            @(posedge clk);

            @(negedge clk);
            clear_inputs();

        end

    endtask


    // =========================================================================
    // TEST 2
    // INPUT 1 -> OUTPUT 1
    // =========================================================================

    task automatic test_input1_output1;

        begin

            start_test("INPUT 1 -> OUTPUT 1");

            reset_dut();

            @(negedge clk);

            in1_tdata  = 32'h0000_0020;
            in1_tvalid = 1'b1;
            in1_tlast  = 1'b1;
            in1_tdest  = 1'b1;

            out1_tready = 1'b1;

            #1;

            if ((out1_tvalid === 1'b1) &&
                (out1_tdata === 32'h0000_0020) &&
                (out1_tlast === 1'b1))
                pass("Input 1 correctly routed to Output 1");
            else
                fail("Input 1 did not route to Output 1");

            @(posedge clk);

            @(negedge clk);
            clear_inputs();

        end

    endtask


    // =========================================================================
    // TEST 3
    // CONCURRENT TRAFFIC
    // =========================================================================

    task automatic test_concurrent;

        begin

            start_test("CONCURRENT TRAFFIC");

            reset_dut();

            @(negedge clk);

            in0_tdata  = 32'h0000_0030;
            in0_tvalid = 1'b1;
            in0_tlast  = 1'b1;
            in0_tdest  = 1'b0;

            in1_tdata  = 32'h0000_0040;
            in1_tvalid = 1'b1;
            in1_tlast  = 1'b1;
            in1_tdest  = 1'b1;

            out0_tready = 1'b1;
            out1_tready = 1'b1;

            #1;

            if ((out0_tvalid === 1'b1) &&
                (out0_tdata === 32'h0000_0030))
                pass("Input 0 transferred to Output 0 concurrently");
            else
                fail("Concurrent Input 0 transfer failed");

            if ((out1_tvalid === 1'b1) &&
                (out1_tdata === 32'h0000_0040))
                pass("Input 1 transferred to Output 1 concurrently");
            else
                fail("Concurrent Input 1 transfer failed");

            @(posedge clk);

            @(negedge clk);
            clear_inputs();

        end

    endtask


    // =========================================================================
    // TEST 4
    // CONTENTION / ROUND ROBIN
    //
    // IMPORTANT:
    // Check sel0 BEFORE the clock edge.
    // After TLAST transfer, rr0 changes and the combinational selector can
    // immediately select the other input.
    // =========================================================================

    task automatic test_contention;

        begin

            start_test("CONTENTION / ROUND-ROBIN");

            reset_dut();

            @(negedge clk);

            in0_tdata  = 32'h0000_0050;
            in0_tvalid = 1'b1;
            in0_tlast  = 1'b1;
            in0_tdest  = 1'b0;

            in1_tdata  = 32'h0000_0060;
            in1_tvalid = 1'b1;
            in1_tlast  = 1'b1;
            in1_tdest  = 1'b0;

            out0_tready = 1'b1;

            #1;

            // Initial RR priority is Input 0.
            if ((dut.grant0 === 1'b1) &&
                (dut.sel0   === 1'b0) &&
                (out0_tdata === 32'h0000_0050))
                pass("First contention selects Input 0");
            else
                fail("First contention did not select Input 0");

            // Transfer Input 0.
            @(posedge clk);

            // Remove Input 0.
            @(negedge clk);

            in0_tvalid = 1'b0;

            #1;

            // Input 1 must now be selected.
            if ((dut.grant0 === 1'b1) &&
                (dut.sel0   === 1'b1) &&
                (out0_tdata === 32'h0000_0060))
                pass("Input 1 transfers after Input 0 completes");
            else
                fail("Input 1 did not transfer after Input 0");

            @(posedge clk);

            @(negedge clk);
            clear_inputs();

        end

    endtask


    // =========================================================================
    // TEST 5
    // BACKPRESSURE
    // =========================================================================

    task automatic test_backpressure;

        logic [31:0] held_data;
        logic        held_last;

        begin

            start_test("BACKPRESSURE");

            reset_dut();

            @(negedge clk);

            in0_tdata  = 32'h0000_0070;
            in0_tvalid = 1'b1;
            in0_tlast  = 1'b1;
            in0_tdest  = 1'b0;

            out0_tready = 1'b0;

            #1;

            if ((out0_tvalid === 1'b1) &&
                (out0_tdata === 32'h0000_0070))
                pass("Output 0 presents data while READY is low");
            else
                fail("Output 0 did not present valid data");

            held_data = out0_tdata;
            held_last = out0_tlast;

            repeat (2)
                @(posedge clk);

            #1;

            if ((out0_tvalid === 1'b1) &&
                (out0_tdata === held_data) &&
                (out0_tlast === held_last))
                pass("Output 0 remained stable during backpressure");
            else
                fail("Output 0 changed during backpressure");

            @(negedge clk);

            out0_tready = 1'b1;

            #1;

            if ((out0_tvalid === 1'b1) &&
                (out0_tdata === held_data))
                pass("Output 0 transfers when READY is asserted");
            else
                fail("Output 0 failed after READY assertion");

            @(posedge clk);

            @(negedge clk);
            clear_inputs();

        end

    endtask


    // =========================================================================
    // TEST 6
    // MULTI-BEAT PACKET LOCKING
    // =========================================================================

    task automatic test_packet_locking;

        begin

            start_test("MULTI-BEAT PACKET LOCKING");

            reset_dut();

            // ---------------------------------------------------------------
            // Beat 1 from Input 0.
            // TLAST = 0, therefore Output 0 must become locked to Input 0.
            // ---------------------------------------------------------------

            @(negedge clk);

            in0_tdata  = 32'h0000_00A0;
            in0_tvalid = 1'b1;
            in0_tlast  = 1'b0;
            in0_tdest  = 1'b0;

            in1_tdata  = 32'h0000_00B0;
            in1_tvalid = 1'b1;
            in1_tlast  = 1'b1;
            in1_tdest  = 1'b0;

            out0_tready = 1'b1;

            #1;

            if ((dut.sel0 === 1'b0) &&
                (out0_tdata === 32'h0000_00A0))
                pass("Input 0 packet beat 1 selected");
            else
                fail("Input 0 packet beat 1 was not selected");

            @(posedge clk);

            // ---------------------------------------------------------------
            // Beat 2 from Input 0.
            // Input 1 is still requesting Output 0.
            // Packet lock must prevent Input 1 from preempting Input 0.
            // ---------------------------------------------------------------

            @(negedge clk);

            in0_tdata = 32'h0000_00A1;
            in0_tlast = 1'b1;

            #1;

            if ((dut.lock0 === 1'b1) &&
                (dut.owner0 === 1'b0) &&
                (dut.sel0 === 1'b0) &&
                (out0_tdata === 32'h0000_00A1))
                pass("Packet lock keeps Output 0 with Input 0");
            else
                fail("Packet lock was not maintained");

            @(posedge clk);

            // ---------------------------------------------------------------
            // Packet is now complete.
            // Input 1 should become available.
            // ---------------------------------------------------------------

            @(negedge clk);

            in0_tvalid = 1'b0;

            #1;

            if ((dut.lock0 === 1'b0) &&
                (dut.grant0 === 1'b1) &&
                (dut.sel0 === 1'b1) &&
                (out0_tdata === 32'h0000_00B0))
                pass("Input 1 transfers after Input 0 packet completes");
            else
                fail("Input 1 transferred before packet completion");

            @(posedge clk);

            @(negedge clk);
            clear_inputs();

        end

    endtask


    // =========================================================================
    // TEST 7
    // OUTPUT 0 STABILITY
    // =========================================================================

    task automatic test_output0_stability;

        logic [31:0] saved_data;

        begin

            start_test("OUTPUT 0 STABILITY");

            reset_dut();

            @(negedge clk);

            in0_tdata  = 32'h0000_00C0;
            in0_tvalid = 1'b1;
            in0_tlast  = 1'b1;
            in0_tdest  = 1'b0;

            out0_tready = 1'b0;

            #1;

            saved_data = out0_tdata;

            repeat (2)
                @(posedge clk);

            #1;

            if ((out0_tvalid === 1'b1) &&
                (out0_tdata === saved_data))
                pass("Output 0 data remains stable");
            else
                fail("Output 0 data changed");

            @(negedge clk);
            clear_inputs();

        end

    endtask


    // =========================================================================
    // TEST 8
    // OUTPUT 1 STABILITY
    // =========================================================================

    task automatic test_output1_stability;

        logic [31:0] saved_data;

        begin

            start_test("OUTPUT 1 STABILITY");

            reset_dut();

            @(negedge clk);

            in1_tdata  = 32'h0000_00D0;
            in1_tvalid = 1'b1;
            in1_tlast  = 1'b1;
            in1_tdest  = 1'b1;

            out1_tready = 1'b0;

            #1;

            saved_data = out1_tdata;

            repeat (2)
                @(posedge clk);

            #1;

            if ((out1_tvalid === 1'b1) &&
                (out1_tdata === saved_data))
                pass("Output 1 data remains stable");
            else
                fail("Output 1 data changed");

            @(negedge clk);
            clear_inputs();

        end

    endtask


    // =========================================================================
    // TEST 9
    // OUTPUT 0 TLAST
    // =========================================================================

    task automatic test_output0_tlast;

        begin

            start_test("OUTPUT 0 TLAST");

            reset_dut();

            @(negedge clk);

            in0_tdata  = 32'h0000_00E0;
            in0_tvalid = 1'b1;
            in0_tlast  = 1'b1;
            in0_tdest  = 1'b0;

            out0_tready = 1'b1;

            #1;

            if (out0_tlast === 1'b1)
                pass("Output 0 correctly propagates TLAST");
            else
                fail("Output 0 TLAST incorrect");

            @(posedge clk);

            @(negedge clk);
            clear_inputs();

        end

    endtask


    // =========================================================================
    // TEST 10
    // OUTPUT 1 TLAST
    // =========================================================================

    task automatic test_output1_tlast;

        begin

            start_test("OUTPUT 1 TLAST");

            reset_dut();

            @(negedge clk);

            in1_tdata  = 32'h0000_00F0;
            in1_tvalid = 1'b1;
            in1_tlast  = 1'b1;
            in1_tdest  = 1'b1;

            out1_tready = 1'b1;

            #1;

            if (out1_tlast === 1'b1)
                pass("Output 1 correctly propagates TLAST");
            else
                fail("Output 1 TLAST incorrect");

            @(posedge clk);

            @(negedge clk);
            clear_inputs();

        end

    endtask


    // =========================================================================
    // TEST 11
    // RESET BEHAVIOUR
    // =========================================================================

    task automatic test_reset;

        begin

            start_test("RESET BEHAVIOUR");

            rst_n = 1'b0;
            clear_inputs();

            @(negedge clk);

            in0_tvalid = 1'b1;
            in0_tdata  = 32'h0000_0110;
            in0_tdest  = 1'b0;

            in1_tvalid = 1'b1;
            in1_tdata  = 32'h0000_0120;
            in1_tdest  = 1'b1;

            out0_tready = 1'b1;
            out1_tready = 1'b1;

            #1;

            if ((out0_tvalid === 1'b0) &&
                (out1_tvalid === 1'b0))
                pass("Outputs remain inactive during reset");
            else
                fail("Outputs became active during reset");

            repeat (2)
                @(posedge clk);

            @(negedge clk);

            rst_n = 1'b1;

            clear_inputs();

            @(negedge clk);

        end

    endtask


    // =========================================================================
    // TEST 12
    // MIXED TRAFFIC
    // =========================================================================

    task automatic test_mixed;

        begin

            start_test("MIXED TRAFFIC");

            reset_dut();

            @(negedge clk);

            // Input 0 -> Output 1
            in0_tdata  = 32'h0000_0130;
            in0_tvalid = 1'b1;
            in0_tlast  = 1'b1;
            in0_tdest  = 1'b1;

            // Input 1 -> Output 0
            in1_tdata  = 32'h0000_0140;
            in1_tvalid = 1'b1;
            in1_tlast  = 1'b1;
            in1_tdest  = 1'b0;

            out0_tready = 1'b1;
            out1_tready = 1'b1;

            #1;

            if ((out0_tvalid === 1'b1) &&
                (out0_tdata === 32'h0000_0140) &&
                (out1_tvalid === 1'b1) &&
                (out1_tdata === 32'h0000_0130))
                pass("Mixed traffic reaches both outputs");
            else
                fail("Mixed traffic routing failed");

            @(posedge clk);

            @(negedge clk);
            clear_inputs();

        end

    endtask


    // =========================================================================
    // TEST 13
    // ROUND-ROBIN FAIRNESS - OUTPUT 0
    //
    // We deliberately create repeated contention.
    // Every packet is one beat, so RR updates after every transfer.
    // =========================================================================

    task automatic test_rr_output0;

        integer i;

        begin

            start_test("ROUND-ROBIN FAIRNESS - OUTPUT 0");

            reset_dut();

            out0_tready = 1'b1;

            // ---------------------------------------------------------------
            // Repeated contention.
            // Both inputs request Output 0 every cycle.
            // ---------------------------------------------------------------

            for (i = 0; i < 8; i = i + 1) begin

                @(negedge clk);

                in0_tdata  = 32'h0000_0200 + i;
                in0_tvalid = 1'b1;
                in0_tlast  = 1'b1;
                in0_tdest  = 1'b0;

                in1_tdata  = 32'h0000_0300 + i;
                in1_tvalid = 1'b1;
                in1_tlast  = 1'b1;
                in1_tdest  = 1'b0;

                #1;

                // Verify a valid winner exists.
                if ((dut.grant0 === 1'b1) &&
                    ((dut.sel0 === 1'b0) || (dut.sel0 === 1'b1)))
                    pass("Output 0 contention has a valid winner");
                else
                    fail("Output 0 contention has no valid winner");

                @(posedge clk);

            end

            @(negedge clk);

            clear_inputs();

            pass("Output 0 contention sequence completed");

        end

    endtask


    // =========================================================================
    // TEST 14
    // ROUND-ROBIN FAIRNESS - OUTPUT 1
    // =========================================================================

    task automatic test_rr_output1;

        integer i;

        begin

            start_test("ROUND-ROBIN FAIRNESS - OUTPUT 1");

            reset_dut();

            out1_tready = 1'b1;

            for (i = 0; i < 8; i = i + 1) begin

                @(negedge clk);

                in0_tdata  = 32'h0000_0400 + i;
                in0_tvalid = 1'b1;
                in0_tlast  = 1'b1;
                in0_tdest  = 1'b1;

                in1_tdata  = 32'h0000_0500 + i;
                in1_tvalid = 1'b1;
                in1_tlast  = 1'b1;
                in1_tdest  = 1'b1;

                #1;

                if ((dut.grant1 === 1'b1) &&
                    ((dut.sel1 === 1'b0) || (dut.sel1 === 1'b1)))
                    pass("Output 1 contention has a valid winner");
                else
                    fail("Output 1 contention has no valid winner");

                @(posedge clk);

            end

            @(negedge clk);

            clear_inputs();

            pass("Output 1 contention sequence completed");

        end

    endtask


    // =========================================================================
    // RUN ALL TESTS
    // =========================================================================

    initial begin

        test_count = 0;
        pass_count = 0;
        fail_count = 0;

        rst_n = 1'b0;
        clear_inputs();

        #2;

        test_input0_output0();
        test_input1_output1();
        test_concurrent();
        test_contention();
        test_backpressure();
        test_packet_locking();
        test_output0_stability();
        test_output1_stability();
        test_output0_tlast();
        test_output1_tlast();
        test_reset();
        test_mixed();
        test_rr_output0();
        test_rr_output1();

        // Give the checker time to execute its final clocked checks.
        repeat (2)
            @(posedge clk);

        #2;

        $display("");
        $display("==============================================================");
        $display("");
        $display("                    TESTBENCH SUMMARY");
        $display("");
        $display("==============================================================");
        $display("");

        $display("Tests executed : %0d", test_count);
        $display("PASS count     : %0d", pass_count);
        $display("FAIL count     : %0d", fail_count);

        $display("");

        if (fail_count == 0)
            $display("TESTBENCH RESULT : PASS");
        else
            $display("TESTBENCH RESULT : FAILURES DETECTED");

        $display("");
        $display("==============================================================");
        $display("");

        $finish;

    end

endmodule


