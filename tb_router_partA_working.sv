`timescale 1ns/1ps

module tb_router;

    parameter DATA_WIDTH = 32;

    // ============================================================
    // CLOCK AND RESET
    // ============================================================

    logic clk;
    logic rst_n;

    // ============================================================
    // INPUT 0
    // ============================================================

    logic [DATA_WIDTH-1:0] tdata0;
    logic                  tvalid0;
    logic                  tlast0;
    logic                  tdest0;
    logic                  tready0;

    // ============================================================
    // INPUT 1
    // ============================================================

    logic [DATA_WIDTH-1:0] tdata1;
    logic                  tvalid1;
    logic                  tlast1;
    logic                  tdest1;
    logic                  tready1;

    // ============================================================
    // OUTPUT 0
    // ============================================================

    logic [DATA_WIDTH-1:0] out_data0;
    logic                  out_valid0;
    logic                  out_last0;
    logic                  out_src0;
    logic                  out_ready0;

    // ============================================================
    // OUTPUT 1
    // ============================================================

    logic [DATA_WIDTH-1:0] out_data1;
    logic                  out_valid1;
    logic                  out_last1;
    logic                  out_src1;
    logic                  out_ready1;

    // ============================================================
    // DUT: ROUTER
    // ============================================================

    router #(
        .DATA_WIDTH(DATA_WIDTH)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),

        // Input 0
        .tdata0(tdata0),
        .tvalid0(tvalid0),
        .tlast0(tlast0),
        .tdest0(tdest0),
        .tready0(tready0),

        // Input 1
        .tdata1(tdata1),
        .tvalid1(tvalid1),
        .tlast1(tlast1),
        .tdest1(tdest1),
        .tready1(tready1),

        // Output 0
        .out_data0(out_data0),
        .out_valid0(out_valid0),
        .out_last0(out_last0),
        .out_src0(out_src0),
        .out_ready0(out_ready0),

        // Output 1
        .out_data1(out_data1),
        .out_valid1(out_valid1),
        .out_last1(out_last1),
        .out_src1(out_src1),
        .out_ready1(out_ready1)
    );

    // ============================================================
    // CLOCK
    // ============================================================

    initial begin
        clk = 1'b0;

        forever #5 clk = ~clk;
    end

    // ============================================================
    // DISPLAY SUCCESSFUL TRANSFERS
    //
    // A transfer occurs only when:
    //
    //     VALID && READY
    //
    // ============================================================

    always @(posedge clk) begin

        if (rst_n) begin

            if (out_valid0 && out_ready0) begin

                $display(
                    "[%0t] TRANSFER OUT0: data=%h src=%0d last=%0d",
                    $time,
                    out_data0,
                    out_src0,
                    out_last0
                );

            end

            if (out_valid1 && out_ready1) begin

                $display(
                    "[%0t] TRANSFER OUT1: data=%h src=%0d last=%0d",
                    $time,
                    out_data1,
                    out_src1,
                    out_last1
                );

            end

        end

    end

    // ============================================================
    // RESET TASK
    // ============================================================

    task reset_dut;

        begin

            rst_n = 1'b0;

            // Input 0
            tdata0  = '0;
            tvalid0 = 1'b0;
            tlast0  = 1'b0;
            tdest0  = 1'b0;

            // Input 1
            tdata1  = '0;
            tvalid1 = 1'b0;
            tlast1  = 1'b0;
            tdest1  = 1'b0;

            // Outputs initially not ready
            out_ready0 = 1'b0;
            out_ready1 = 1'b0;

            repeat (3)
                @(posedge clk);

            rst_n = 1'b1;

            @(posedge clk);

        end

    endtask

    // ============================================================
    // SEND ONE BEAT FROM INPUT 0
    // ============================================================

    task send0(
        input [DATA_WIDTH-1:0] data,
        input                  dest,
        input                  last
    );

        begin

            // Put data on the bus away from the sampling edge.
            @(negedge clk);

            tdata0  = data;
            tdest0  = dest;
            tlast0  = last;
            tvalid0 = 1'b1;

            // Hold VALID and DATA until READY.
            while (!tready0)
                @(negedge clk);

            // Handshake has occurred.
            @(negedge clk);

            tvalid0 = 1'b0;
            tlast0  = 1'b0;

        end

    endtask

    // ============================================================
    // SEND ONE BEAT FROM INPUT 1
    // ============================================================

    task send1(
        input [DATA_WIDTH-1:0] data,
        input                  dest,
        input                  last
    );

        begin

            @(negedge clk);

            tdata1  = data;
            tdest1  = dest;
            tlast1  = last;
            tvalid1 = 1'b1;

            // Hold VALID and DATA until READY.
            while (!tready1)
                @(negedge clk);

            // Handshake has occurred.
            @(negedge clk);

            tvalid1 = 1'b0;
            tlast1  = 1'b0;

        end

    endtask

    // ============================================================
    // TEST 1
    //
    // Independent concurrent traffic:
    //
    // Input 0 -> Output 0
    // Input 1 -> Output 1
    // ============================================================

    task test_independent;

        begin

            $display("");
            $display("==========================================");
            $display("TEST 1: INDEPENDENT TRAFFIC");
            $display("==========================================");

            out_ready0 = 1'b1;
            out_ready1 = 1'b1;

            fork

                send0(
                    32'hAAAA0001,
                    1'b0,
                    1'b1
                );

                send1(
                    32'hBBBB0001,
                    1'b1,
                    1'b1
                );

            join

            repeat (2)
                @(posedge clk);

        end

    endtask

    // ============================================================
    // TEST 2
    //
    // CONTENTION
    //
    // Both inputs target Output 0.
    // ============================================================

    task test_contention;

        begin

            $display("");
            $display("==========================================");
            $display("TEST 2: CONTENTION");
            $display("==========================================");

            out_ready0 = 1'b1;
            out_ready1 = 1'b1;

            fork

                send0(
                    32'h11110001,
                    1'b0,
                    1'b1
                );

                send1(
                    32'h22220001,
                    1'b0,
                    1'b1
                );

            join

            repeat (3)
                @(posedge clk);

        end

    endtask

    // ============================================================
    // TEST 3
    //
    // MULTI-BEAT PACKET
    //
    // Input 0 sends:
    //
    //   10000001
    //   10000002
    //   10000003 / TLAST
    //
    // ============================================================

    task test_multibeat;

        begin

            $display("");
            $display("==========================================");
            $display("TEST 3: MULTI-BEAT PACKET");
            $display("==========================================");

            out_ready0 = 1'b1;
            out_ready1 = 1'b1;

            send0(
                32'h10000001,
                1'b0,
                1'b0
            );

            send0(
                32'h10000002,
                1'b0,
                1'b0
            );

            send0(
                32'h10000003,
                1'b0,
                1'b1
            );

            repeat (3)
                @(posedge clk);

        end

    endtask

    // ============================================================
    // TEST 4
    //
    // BACKPRESSURE
    //
    // Output 0 is not ready for several cycles.
    // Input 0 must hold its transaction.
    // ============================================================

    task test_backpressure;

        begin

            $display("");
            $display("==========================================");
            $display("TEST 4: BACKPRESSURE");
            $display("==========================================");

            out_ready0 = 1'b0;
            out_ready1 = 1'b1;

            @(negedge clk);

            tdata0  = 32'hDEAD0001;
            tdest0  = 1'b0;
            tlast0  = 1'b1;
            tvalid0 = 1'b1;

            repeat (4) begin

                @(posedge clk);

                $display(
                    "[%0t] BACKPRESSURE: valid=%0d ready=%0d data=%h",
                    $time,
                    tvalid0,
                    tready0,
                    tdata0
                );

            end

            // Receiver becomes ready.
            out_ready0 = 1'b1;

            while (!tready0)
                @(posedge clk);

            @(negedge clk);

            tvalid0 = 1'b0;
            tlast0  = 1'b0;

            repeat (3)
                @(posedge clk);

        end

    endtask

    // ============================================================
    // TEST 5
    //
    // PACKET LOCKING
    //
    // Input 0 starts a three-beat packet for Output 0.
    //
    // Input 1 tries to access Output 0 while Input 0's packet
    // is still active.
    //
    // Expected ordering:
    //
    // AAAA1001
    // AAAA1002
    // AAAA1003
    // BBBB2001
    //
    // Input 1 must NOT appear in the middle of Input 0's packet.
    // ============================================================

    task test_packet_lock;

        begin

            $display("");
            $display("==========================================");
            $display("TEST 5: PACKET LOCKING");
            $display("==========================================");

            out_ready0 = 1'b1;
            out_ready1 = 1'b1;

            fork

                begin

                    send0(
                        32'hAAAA1001,
                        1'b0,
                        1'b0
                    );

                    send0(
                        32'hAAAA1002,
                        1'b0,
                        1'b0
                    );

                    send0(
                        32'hAAAA1003,
                        1'b0,
                        1'b1
                    );

                end

                begin

                    // Give Input 0 time to start its packet.
                    #12;

                    send1(
                        32'hBBBB2001,
                        1'b0,
                        1'b1
                    );

                end

            join

            repeat (4)
                @(posedge clk);

        end

    endtask

    // ============================================================
    // MAIN TEST SEQUENCE
    // ============================================================

    initial begin

        // --------------------------------------------------------
        // Waveform dump
        // --------------------------------------------------------

        $dumpfile("router.vcd");
        $dumpvars(0, tb_router);

        // --------------------------------------------------------
        // Reset
        // --------------------------------------------------------

        reset_dut();

        // --------------------------------------------------------
        // Run all tests
        // --------------------------------------------------------

        test_independent();

        test_contention();

        test_multibeat();

        test_backpressure();

        test_packet_lock();

        // --------------------------------------------------------
        // Finish
        // --------------------------------------------------------

        $display("");
        $display("==========================================");
        $display("ALL TESTS COMPLETED");
        $display("==========================================");

        #20;

        $finish;

    end

endmodule
