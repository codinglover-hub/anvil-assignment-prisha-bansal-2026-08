`timescale 1ns/1ps

module tb_router;

    logic clk;
    logic rst_n;

    // Input 0
    logic [31:0] in0_tdata;
    logic        in0_tvalid;
    logic        in0_tready;
    logic        in0_tlast;
    logic        in0_tdest;

    // Input 1
    logic [31:0] in1_tdata;
    logic        in1_tvalid;
    logic        in1_tready;
    logic        in1_tlast;
    logic        in1_tdest;

    // Output 0
    logic [31:0] out0_tdata;
    logic        out0_tvalid;
    logic        out0_tready;
    logic        out0_tlast;

    // Output 1
    logic [31:0] out1_tdata;
    logic        out1_tvalid;
    logic        out1_tready;
    logic        out1_tlast;

    integer pass_count;
    integer fail_count;

    // ------------------------------------------------------------
    // DUT
    // ------------------------------------------------------------

    router dut (
        .clk         (clk),
        .rst_n       (rst_n),

        .in0_tdata   (in0_tdata),
        .in0_tvalid  (in0_tvalid),
        .in0_tready  (in0_tready),
        .in0_tlast   (in0_tlast),
        .in0_tdest   (in0_tdest),

        .in1_tdata   (in1_tdata),
        .in1_tvalid  (in1_tvalid),
        .in1_tready  (in1_tready),
        .in1_tlast   (in1_tlast),
        .in1_tdest   (in1_tdest),

        .out0_tdata  (out0_tdata),
        .out0_tvalid (out0_tvalid),
        .out0_tready (out0_tready),
        .out0_tlast  (out0_tlast),

        .out1_tdata  (out1_tdata),
        .out1_tvalid (out1_tvalid),
        .out1_tready (out1_tready),
        .out1_tlast  (out1_tlast)
    );

    // ------------------------------------------------------------
    // Clock: 10 ns period
    // ------------------------------------------------------------

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    // ------------------------------------------------------------
    // Result helpers
    // ------------------------------------------------------------

    task check(
        input logic condition,
        input string message
    );
        begin
            if (condition) begin
                pass_count = pass_count + 1;
                $display("PASS: %s", message);
            end
            else begin
                fail_count = fail_count + 1;
                $display("FAIL: %s", message);
            end
        end
    endtask

    task clear_inputs;
        begin
            in0_tdata  = 32'b0;
            in0_tvalid = 1'b0;
            in0_tlast  = 1'b0;
            in0_tdest  = 1'b0;

            in1_tdata  = 32'b0;
            in1_tvalid = 1'b0;
            in1_tlast  = 1'b0;
            in1_tdest  = 1'b0;
        end
    endtask

    // ------------------------------------------------------------
    // Reset
    // ------------------------------------------------------------

    task reset_dut;
        begin
            rst_n = 1'b0;

            clear_inputs();

            out0_tready = 1'b0;
            out1_tready = 1'b0;

            repeat (2) @(posedge clk);

            rst_n = 1'b1;

            @(negedge clk);
        end
    endtask

    // ------------------------------------------------------------
    // Send one beat on input 0.
    //
    // The task waits for the actual successful transfer:
    // in0_tvalid && in0_tready.
    // ------------------------------------------------------------

    task send_in0(
        input logic [31:0] data,
        input logic        dest,
        input logic        last
    );
        begin
            @(negedge clk);

            in0_tdata  = data;
            in0_tdest  = dest;
            in0_tlast  = last;
            in0_tvalid = 1'b1;

            do begin
                @(posedge clk);
            end while (!(in0_tvalid && in0_tready));

            @(negedge clk);

            in0_tvalid = 1'b0;
            in0_tdata  = 32'b0;
            in0_tlast  = 1'b0;
            in0_tdest  = 1'b0;
        end
    endtask

    // ------------------------------------------------------------
    // Send one beat on input 1.
    // ------------------------------------------------------------

    task send_in1(
        input logic [31:0] data,
        input logic        dest,
        input logic        last
    );
        begin
            @(negedge clk);

            in1_tdata  = data;
            in1_tdest  = dest;
            in1_tlast  = last;
            in1_tvalid = 1'b1;

            do begin
                @(posedge clk);
            end while (!(in1_tvalid && in1_tready));

            @(negedge clk);

            in1_tvalid = 1'b0;
            in1_tdata  = 32'b0;
            in1_tlast  = 1'b0;
            in1_tdest  = 1'b0;
        end
    endtask

    // ------------------------------------------------------------
    // TEST 1: Input 0 -> Output 0
    // ------------------------------------------------------------

    task test_input0_output0;
        begin
            $display("\n================================================");
            $display("TEST 1: INPUT 0 -> OUTPUT 0");
            $display("================================================");

            out0_tready = 1'b1;
            out1_tready = 1'b1;

            @(negedge clk);

            in0_tdata  = 32'h0000_00AA;
            in0_tdest  = 1'b0;
            in0_tlast  = 1'b1;
            in0_tvalid = 1'b1;

            @(posedge clk);

            check(
                out0_tvalid &&
                out0_tready &&
                (out0_tdata == 32'h0000_00AA) &&
                (out0_tlast == 1'b1),
                "Input 0 correctly transferred to Output 0"
            );

            check(
                !out1_tvalid,
                "Output 1 remains inactive"
            );

            @(negedge clk);
            in0_tvalid = 1'b0;
        end
    endtask

    // ------------------------------------------------------------
    // TEST 2: Input 1 -> Output 1
    // ------------------------------------------------------------

    task test_input1_output1;
        begin
            $display("\n================================================");
            $display("TEST 2: INPUT 1 -> OUTPUT 1");
            $display("================================================");

            out0_tready = 1'b1;
            out1_tready = 1'b1;

            @(negedge clk);

            in1_tdata  = 32'h0000_00BB;
            in1_tdest  = 1'b1;
            in1_tlast  = 1'b1;
            in1_tvalid = 1'b1;

            @(posedge clk);

            check(
                out1_tvalid &&
                out1_tready &&
                (out1_tdata == 32'h0000_00BB) &&
                (out1_tlast == 1'b1),
                "Input 1 correctly transferred to Output 1"
            );

            check(
                !out0_tvalid,
                "Output 0 remains inactive"
            );

            @(negedge clk);
            in1_tvalid = 1'b0;
        end
    endtask

    // ------------------------------------------------------------
    // TEST 3: Concurrent independent traffic
    // ------------------------------------------------------------

    task test_concurrent;
        begin
            $display("\n================================================");
            $display("TEST 3: CONCURRENT TRAFFIC");
            $display("================================================");

            out0_tready = 1'b1;
            out1_tready = 1'b1;

            @(negedge clk);

            in0_tdata  = 32'h1111_1111;
            in0_tdest  = 1'b0;
            in0_tlast  = 1'b1;
            in0_tvalid = 1'b1;

            in1_tdata  = 32'h2222_2222;
            in1_tdest  = 1'b1;
            in1_tlast  = 1'b1;
            in1_tvalid = 1'b1;

            @(posedge clk);

            check(
                out0_tvalid &&
                out0_tready &&
                (out0_tdata == 32'h1111_1111) &&
                out0_tlast,
                "Input 0 transferred to Output 0 concurrently"
            );

            check(
                out1_tvalid &&
                out1_tready &&
                (out1_tdata == 32'h2222_2222) &&
                out1_tlast,
                "Input 1 transferred to Output 1 concurrently"
            );

            @(negedge clk);
            in0_tvalid = 1'b0;
            in1_tvalid = 1'b0;
        end
    endtask

    // ------------------------------------------------------------
    // TEST 4: Output 0 contention and round-robin
    //
    // Reset initializes rr0=0, so input 0 should win first.
    // After input 0 completes, rr0 becomes 1, so input 1 should
    // win the next contended packet.
    // ------------------------------------------------------------

    task test_contention_round_robin;
        begin
            $display("\n================================================");
            $display("TEST 4: CONTENTION / ROUND-ROBIN");
            $display("================================================");

            out0_tready = 1'b1;
            out1_tready = 1'b1;

            // First contention: input 0 should win.
            @(negedge clk);

            in0_tdata  = 32'hAAAA_0001;
            in0_tdest  = 1'b0;
            in0_tlast  = 1'b1;
            in0_tvalid = 1'b1;

            in1_tdata  = 32'hBBBB_0001;
            in1_tdest  = 1'b0;
            in1_tlast  = 1'b1;
            in1_tvalid = 1'b1;

            @(posedge clk);

            check(
                out0_tvalid &&
                out0_tready &&
                (out0_tdata == 32'hAAAA_0001),
                "First contention selects Input 0"
            );

            // Input 0 completed. Keep input 1 asserted.
            @(negedge clk);
            in0_tvalid = 1'b0;

            @(posedge clk);

            check(
                out0_tvalid &&
                out0_tready &&
                (out0_tdata == 32'hBBBB_0001),
                "Input 1 transfers after Input 0 completes"
            );

            @(negedge clk);
            in1_tvalid = 1'b0;

            // Second contention: round-robin should now favor input 1.
            @(negedge clk);

            in0_tdata  = 32'hAAAA_0002;
            in0_tdest  = 1'b0;
            in0_tlast  = 1'b1;
            in0_tvalid = 1'b1;

            in1_tdata  = 32'hBBBB_0002;
            in1_tdest  = 1'b0;
            in1_tlast  = 1'b1;
            in1_tvalid = 1'b1;

            @(posedge clk);

            check(
                out0_tvalid &&
                out0_tready &&
                (out0_tdata == 32'hBBBB_0002),
                "Second contention selects Input 1"
            );

            @(negedge clk);
            in0_tvalid = 1'b0;
            in1_tvalid = 1'b0;
        end
    endtask

    // ------------------------------------------------------------
    // TEST 5: Backpressure and stable output payload
    // ------------------------------------------------------------

    task test_backpressure;
        logic [31:0] held_data;
        logic        held_last;

        begin
            $display("\n================================================");
            $display("TEST 5: BACKPRESSURE");
            $display("================================================");

            out0_tready = 1'b0;
            out1_tready = 1'b1;

            @(negedge clk);

            in0_tdata  = 32'hDEAD_BEEF;
            in0_tdest  = 1'b0;
            in0_tlast  = 1'b1;
            in0_tvalid = 1'b1;

            @(posedge clk);

            held_data = out0_tdata;
            held_last = out0_tlast;

            check(
                out0_tvalid &&
                !out0_tready &&
                !in0_tready &&
                (out0_tdata == 32'hDEAD_BEEF),
                "Backpressure reaches Input 0 and holds valid data"
            );

            // Keep downstream stalled for one more full clock cycle.
            @(posedge clk);

            check(
                out0_tvalid &&
                !out0_tready &&
                (out0_tdata == held_data) &&
                (out0_tlast == held_last),
                "Output payload remains stable during stall"
            );

            // Release downstream backpressure.
            @(negedge clk);
            out0_tready = 1'b1;

            @(posedge clk);

            check(
                out0_tvalid &&
                out0_tready &&
                (out0_tdata == 32'hDEAD_BEEF) &&
                out0_tlast,
                "Held packet transfers after Output 0 becomes ready"
            );

            @(negedge clk);
            in0_tvalid = 1'b0;
        end
    endtask

    // ------------------------------------------------------------
    // TEST 6: Multi-beat packet locking
    //
    // Input 0 sends a three-beat packet to output 0.
    // Input 1 requests output 0 during the packet.
    // Input 1 must wait until Input 0's tlast beat transfers.
    // ------------------------------------------------------------

    task test_packet_lock;
        begin
            $display("\n================================================");
            $display("TEST 6: MULTI-BEAT PACKET LOCKING");
            $display("================================================");

            out0_tready = 1'b1;
            out1_tready = 1'b1;

            // Beat 1 from input 0.
            @(negedge clk);

            in0_tdata  = 32'h1000_0001;
            in0_tdest  = 1'b0;
            in0_tlast  = 1'b0;
            in0_tvalid = 1'b1;

            @(posedge clk);

            check(
                out0_tvalid &&
                out0_tready &&
                (out0_tdata == 32'h1000_0001) &&
                !out0_tlast,
                "Input 0 packet beat 1 transfers"
            );

            // Beat 2 from input 0; input 1 begins requesting out0.
            @(negedge clk);

            in0_tdata = 32'h1000_0002;
            in0_tlast = 1'b0;

            in1_tdata  = 32'h2000_0001;
            in1_tdest  = 1'b0;
            in1_tlast  = 1'b1;
            in1_tvalid = 1'b1;

            @(posedge clk);

            check(
                out0_tvalid &&
                out0_tready &&
                (out0_tdata == 32'h1000_0002) &&
                !out0_tlast,
                "Lock keeps Output 0 assigned to Input 0 for beat 2"
            );

            check(
                !in1_tready,
                "Input 1 is blocked while Input 0 packet is locked"
            );

            // Last beat from input 0.
            @(negedge clk);

            in0_tdata = 32'h1000_0003;
            in0_tlast = 1'b1;

            @(posedge clk);

            check(
                out0_tvalid &&
                out0_tready &&
                (out0_tdata == 32'h1000_0003) &&
                out0_tlast,
                "Input 0 final packet beat transfers"
            );

            // On the next cycle, the lock is released and input 1 wins.
            @(negedge clk);
            in0_tvalid = 1'b0;

            @(posedge clk);

            check(
                out0_tvalid &&
                out0_tready &&
                (out0_tdata == 32'h2000_0001) &&
                out0_tlast,
                "Input 1 transfers only after Input 0 packet completes"
            );

            @(negedge clk);
            in1_tvalid = 1'b0;
        end
    endtask

    // ------------------------------------------------------------
    // Main sequence
    // ------------------------------------------------------------

    initial begin
        $dumpfile("router.vcd");
        $dumpvars(0, tb_router);

        pass_count = 0;
        fail_count = 0;

        reset_dut();

        test_input0_output0();
        test_input1_output1();
        test_concurrent();
        test_contention_round_robin();
        test_backpressure();
        test_packet_lock();

        $display("\n================================================");
        $display("TEST SUMMARY");
        $display("================================================");
        $display("PASS COUNT: %0d", pass_count);
        $display("FAIL COUNT: %0d", fail_count);

        if (fail_count == 0)
            $display("RESULT: ALL TESTS PASSED");
        else
            $display("RESULT: TESTBENCH FAILED");

        #20;
        $finish;
    end

endmodule
