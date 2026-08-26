`timescale 1ns/1ps

module tb_router_sva;

    parameter DATA_WIDTH = 32;

    // ============================================================
    // CLOCK / RESET
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
    // DUT
    // ============================================================

    router #(
        .DATA_WIDTH(DATA_WIDTH)
    ) dut (
        .clk       (clk),
        .rst_n     (rst_n),

        .tdata0    (tdata0),
        .tvalid0   (tvalid0),
        .tlast0    (tlast0),
        .tdest0    (tdest0),
        .tready0   (tready0),

        .tdata1    (tdata1),
        .tvalid1   (tvalid1),
        .tlast1    (tlast1),
        .tdest1    (tdest1),
        .tready1   (tready1),

        .out_data0 (out_data0),
        .out_valid0(out_valid0),
        .out_last0 (out_last0),
        .out_src0  (out_src0),
        .out_ready0(out_ready0),

        .out_data1 (out_data1),
        .out_valid1(out_valid1),
        .out_last1 (out_last1),
        .out_src1  (out_src1),
        .out_ready1(out_ready1)
    );


    // ============================================================
    // SVA CHECKER CONNECTION
    // ============================================================

    router_sva #(
        .DATA_WIDTH(DATA_WIDTH)
    ) sva_checker (
        .clk       (clk),
        .rst_n     (rst_n),

        .tdata0    (tdata0),
        .tvalid0   (tvalid0),
        .tlast0    (tlast0),
        .tdest0    (tdest0),
        .tready0   (tready0),

        .tdata1    (tdata1),
        .tvalid1   (tvalid1),
        .tlast1    (tlast1),
        .tdest1    (tdest1),
        .tready1   (tready1),

        .out_data0 (out_data0),
        .out_valid0(out_valid0),
        .out_last0 (out_last0),
        .out_src0  (out_src0),
        .out_ready0(out_ready0),

        .out_data1 (out_data1),
        .out_valid1(out_valid1),
        .out_last1 (out_last1),
        .out_src1  (out_src1),
        .out_ready1(out_ready1)
    );


    // ============================================================
    // CLOCK GENERATION
    // ============================================================

    initial begin
        clk = 1'b0;

        forever #5 clk = ~clk;
    end


    // ============================================================
    // RESET
    // ============================================================

    task reset_dut;

        begin

            rst_n = 1'b0;

            tdata0  = '0;
            tvalid0 = 1'b0;
            tlast0  = 1'b0;
            tdest0  = 1'b0;

            tdata1  = '0;
            tvalid1 = 1'b0;
            tlast1  = 1'b0;
            tdest1  = 1'b0;

            out_ready0 = 1'b1;
            out_ready1 = 1'b1;

            repeat (3)
                @(posedge clk);

            rst_n = 1'b1;

            @(posedge clk);

        end

    endtask


    // ============================================================
    // SEND ONE BEAT FROM INPUT 0
    // ============================================================

    task send0;

        input [DATA_WIDTH-1:0] data;
        input                  dest;
        input                  last;

        begin

            @(negedge clk);

            tdata0  = data;
            tdest0  = dest;
            tlast0  = last;
            tvalid0 = 1'b1;

            while (!tready0)
                @(negedge clk);

            @(negedge clk);

            tvalid0 = 1'b0;
            tlast0  = 1'b0;

        end

    endtask


    // ============================================================
    // SEND ONE BEAT FROM INPUT 1
    // ============================================================

    task send1;

        input [DATA_WIDTH-1:0] data;
        input                  dest;
        input                  last;

        begin

            @(negedge clk);

            tdata1  = data;
            tdest1  = dest;
            tlast1  = last;
            tvalid1 = 1'b1;

            while (!tready1)
                @(negedge clk);

            @(negedge clk);

            tvalid1 = 1'b0;
            tlast1  = 1'b0;

        end

    endtask


    // ============================================================
    // TEST 1
    // INDEPENDENT TRAFFIC
    // ============================================================

    task test_independent;

        begin

            $display("");
            $display("==========================================");
            $display("SVA TEST 1: INDEPENDENT TRAFFIC");
            $display("==========================================");

            out_ready0 = 1'b1;
            out_ready1 = 1'b1;

            fork

                begin
                    send0(
                        32'hAAAA0001,
                        1'b0,
                        1'b1
                    );
                end

                begin
                    send1(
                        32'hBBBB0001,
                        1'b1,
                        1'b1
                    );
                end

            join

            repeat (2)
                @(posedge clk);

        end

    endtask


    // ============================================================
    // TEST 2
    // CONTENTION
    // ============================================================

    task test_contention;

        begin

            $display("");
            $display("==========================================");
            $display("SVA TEST 2: CONTENTION");
            $display("==========================================");

            out_ready0 = 1'b1;
            out_ready1 = 1'b1;

            fork

                begin
                    send0(
                        32'h11110001,
                        1'b0,
                        1'b1
                    );
                end

                begin
                    send1(
                        32'h22220001,
                        1'b0,
                        1'b1
                    );
                end

            join

            repeat (2)
                @(posedge clk);

        end

    endtask


    // ============================================================
    // TEST 3
    // MULTI-BEAT PACKET
    // ============================================================

    task test_multibeat;

        begin

            $display("");
            $display("==========================================");
            $display("SVA TEST 3: MULTI-BEAT PACKET");
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

            repeat (2)
                @(posedge clk);

        end

    endtask


    // ============================================================
    // TEST 4
    // BACKPRESSURE
    // ============================================================

    task test_backpressure;

        begin

            $display("");
            $display("==========================================");
            $display("SVA TEST 4: BACKPRESSURE");
            $display("==========================================");

            out_ready0 = 1'b0;
            out_ready1 = 1'b1;

            fork

                begin
                    send0(
                        32'hDEAD0001,
                        1'b0,
                        1'b1
                    );
                end

                begin

                    repeat (5)
                        @(posedge clk);

                    out_ready0 = 1'b1;

                end

            join

            repeat (2)
                @(posedge clk);

        end

    endtask


    // ============================================================
    // TEST 5
    // PACKET LOCKING
    // ============================================================

    task test_packet_lock;

        begin

            $display("");
            $display("==========================================");
            $display("SVA TEST 5: PACKET LOCKING");
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

                    #10;

                    send1(
                        32'hBBBB2001,
                        1'b0,
                        1'b1
                    );

                end

            join

            repeat (3)
                @(posedge clk);

        end

    endtask


    // ============================================================
    // OUTPUT MONITOR
    // ============================================================

    always @(posedge clk) begin

        if (rst_n) begin

            if (out_valid0 && out_ready0) begin

                $display(
                    "[%0t] SVA TB OUT0: data=%h src=%0d last=%0d",
                    $time,
                    out_data0,
                    out_src0,
                    out_last0
                );

            end

            if (out_valid1 && out_ready1) begin

                $display(
                    "[%0t] SVA TB OUT1: data=%h src=%0d last=%0d",
                    $time,
                    out_data1,
                    out_src1,
                    out_last1
                );

            end

        end

    end


    // ============================================================
    // WAVEFORM
    // ============================================================

    initial begin

        $dumpfile("router_sva.vcd");
        $dumpvars(0, tb_router_sva);

    end


    // ============================================================
    // MAIN TEST SEQUENCE
    // ============================================================

    initial begin

        reset_dut();

        test_independent();

        test_contention();

        test_multibeat();

        test_backpressure();

        test_packet_lock();

        repeat (5)
            @(posedge clk);

        $display("");
        $display("==========================================");
        $display("ALL SVA TESTS COMPLETED");
        $display("==========================================");

        $finish;

    end

endmodule
