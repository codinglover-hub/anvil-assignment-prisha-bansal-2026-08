
`timescale 1ns/1ps

module tb_equivalence;

    // ============================================================
    // CLOCK / RESET
    // ============================================================

    logic clk;
    logic rst_n;

    integer cycles;
    integer errors;


    always #5 clk = ~clk;


    always @(posedge clk) begin
        if (rst_n)
            cycles = cycles + 1;
    end


    // ============================================================
    // SYSTEMVERILOG INPUTS
    // ============================================================

    logic [31:0] sv_in0_tdata;
    logic        sv_in0_tvalid;
    logic        sv_in0_tready;
    logic        sv_in0_tlast;
    logic        sv_in0_tdest;

    logic [31:0] sv_in1_tdata;
    logic        sv_in1_tvalid;
    logic        sv_in1_tready;
    logic        sv_in1_tlast;
    logic        sv_in1_tdest;


    // ============================================================
    // SYSTEMVERILOG OUTPUTS
    // ============================================================

    logic [31:0] sv_out0_tdata;
    logic        sv_out0_tvalid;
    logic        sv_out0_tready;
    logic        sv_out0_tlast;

    logic [31:0] sv_out1_tdata;
    logic        sv_out1_tvalid;
    logic        sv_out1_tready;
    logic        sv_out1_tlast;


    // ============================================================
    // ANVIL INPUTS
    // ============================================================

    logic [33:0] av_in0_beat;
    logic        av_in0_valid;
    logic        av_in0_ack;

    logic [33:0] av_in1_beat;
    logic        av_in1_valid;
    logic        av_in1_ack;


    // ============================================================
    // ANVIL OUTPUTS
    // ============================================================

    logic [33:0] av_out0_beat;
    logic        av_out0_valid;
    logic        av_out0_ack;

    logic [33:0] av_out1_beat;
    logic        av_out1_valid;
    logic        av_out1_ack;


    // ============================================================
    // OUTPUT LOGS
    // ============================================================

    logic [31:0] sv_out0_log [0:255];
    logic [31:0] sv_out1_log [0:255];

    logic [31:0] av_out0_log [0:255];
    logic [31:0] av_out1_log [0:255];


    integer sv_out0_count;
    integer sv_out1_count;

    integer av_out0_count;
    integer av_out1_count;


    // ============================================================
    // ONE-SHOT MONITOR FLAGS
    //
    // Prevents counting the same asserted valid multiple times.
    // ============================================================

    logic sv0_seen;
    logic sv1_seen;

    logic av0_seen;
    logic av1_seen;


    // ============================================================
    // SYSTEMVERILOG DUT
    // ============================================================

    router sv_dut (

        .clk         (clk),
        .rst_n       (rst_n),

        .in0_tdata   (sv_in0_tdata),
        .in0_tvalid  (sv_in0_tvalid),
        .in0_tready  (sv_in0_tready),
        .in0_tlast   (sv_in0_tlast),
        .in0_tdest   (sv_in0_tdest),

        .in1_tdata   (sv_in1_tdata),
        .in1_tvalid  (sv_in1_tvalid),
        .in1_tready  (sv_in1_tready),
        .in1_tlast   (sv_in1_tlast),
        .in1_tdest   (sv_in1_tdest),

        .out0_tdata  (sv_out0_tdata),
        .out0_tvalid (sv_out0_tvalid),
        .out0_tready (sv_out0_tready),
        .out0_tlast  (sv_out0_tlast),

        .out1_tdata  (sv_out1_tdata),
        .out1_tvalid (sv_out1_tvalid),
        .out1_tready (sv_out1_tready),
        .out1_tlast  (sv_out1_tlast)
    );


    // ============================================================
    // ANVIL DUT
    // ============================================================

    router_equiv anvil_dut (

        .clk_i            (clk),
        .rst_ni           (rst_n),

        ._in0_beat_ack    (av_in0_ack),
        ._in0_beat_valid  (av_in0_valid),
        ._in0_beat_0      (av_in0_beat),

        ._in1_beat_ack    (av_in1_ack),
        ._in1_beat_valid  (av_in1_valid),
        ._in1_beat_0      (av_in1_beat),

        ._out0_beat_ack   (av_out0_ack),
        ._out0_beat_valid (av_out0_valid),
        ._out0_beat_0     (av_out0_beat),

        ._out1_beat_ack   (av_out1_ack),
        ._out1_beat_valid (av_out1_valid),
        ._out1_beat_0     (av_out1_beat)
    );


    // ============================================================
    // INITIALIZATION
    // ============================================================

    initial begin

        clk = 1'b0;
        rst_n = 1'b0;

        cycles = 0;
        errors = 0;


        sv_in0_tdata  = 32'b0;
        sv_in0_tvalid = 1'b0;
        sv_in0_tlast  = 1'b0;
        sv_in0_tdest  = 1'b0;

        sv_in1_tdata  = 32'b0;
        sv_in1_tvalid = 1'b0;
        sv_in1_tlast  = 1'b0;
        sv_in1_tdest  = 1'b0;


        av_in0_beat  = 34'b0;
        av_in0_valid = 1'b0;

        av_in1_beat  = 34'b0;
        av_in1_valid = 1'b0;


        sv_out0_tready = 1'b1;
        sv_out1_tready = 1'b1;

        av_out0_ack = 1'b1;
        av_out1_ack = 1'b1;


        sv_out0_count = 0;
        sv_out1_count = 0;

        av_out0_count = 0;
        av_out1_count = 0;


        sv0_seen = 1'b0;
        sv1_seen = 1'b0;

        av0_seen = 1'b0;
        av1_seen = 1'b0;

    end


    // ============================================================
    // OUTPUT MONITOR
    //
    // Transfer is recorded on the rising edge.
    //
    // A transfer is recorded once until VALID goes LOW again.
    // ============================================================

    always @(posedge clk) begin

        if (!rst_n) begin

            sv0_seen <= 1'b0;
            sv1_seen <= 1'b0;

            av0_seen <= 1'b0;
            av1_seen <= 1'b0;

        end
        else begin

            // ----------------------------------------------------
            // SV OUTPUT 0
            // ----------------------------------------------------

            if (!sv_out0_tvalid) begin

                sv0_seen <= 1'b0;

            end
            else if (sv_out0_tvalid &&
                     sv_out0_tready &&
                     !sv0_seen) begin

                sv0_seen <= 1'b1;

                if (sv_out0_count < 256) begin

                    sv_out0_log[sv_out0_count]
                        <= sv_out0_tdata;

                    sv_out0_count
                        <= sv_out0_count + 1;

                end

                $display(
                    "SV   OUT0 data=%08h last=%b",
                    sv_out0_tdata,
                    sv_out0_tlast
                );

            end


            // ----------------------------------------------------
            // SV OUTPUT 1
            // ----------------------------------------------------

            if (!sv_out1_tvalid) begin

                sv1_seen <= 1'b0;

            end
            else if (sv_out1_tvalid &&
                     sv_out1_tready &&
                     !sv1_seen) begin

                sv1_seen <= 1'b1;

                if (sv_out1_count < 256) begin

                    sv_out1_log[sv_out1_count]
                        <= sv_out1_tdata;

                    sv_out1_count
                        <= sv_out1_count + 1;

                end

                $display(
                    "SV   OUT1 data=%08h last=%b",
                    sv_out1_tdata,
                    sv_out1_tlast
                );

            end


            // ----------------------------------------------------
            // ANVIL OUTPUT 0
            // ----------------------------------------------------

            if (!av_out0_valid) begin

                av0_seen <= 1'b0;

            end
            else if (av_out0_valid &&
                     av_out0_ack &&
                     !av0_seen) begin

                av0_seen <= 1'b1;

                if (av_out0_count < 256) begin

                    av_out0_log[av_out0_count]
                        <= av_out0_beat[33:2];

                    av_out0_count
                        <= av_out0_count + 1;

                end

                $display(
                    "ANV  OUT0 data=%08h last=%b",
                    av_out0_beat[33:2],
                    av_out0_beat[0]
                );

            end


            // ----------------------------------------------------
            // ANVIL OUTPUT 1
            // ----------------------------------------------------

            if (!av_out1_valid) begin

                av1_seen <= 1'b0;

            end
            else if (av_out1_valid &&
                     av_out1_ack &&
                     !av1_seen) begin

                av1_seen <= 1'b1;

                if (av_out1_count < 256) begin

                    av_out1_log[av_out1_count]
                        <= av_out1_beat[33:2];

                    av_out1_count
                        <= av_out1_count + 1;

                end

                $display(
                    "ANV  OUT1 data=%08h last=%b",
                    av_out1_beat[33:2],
                    av_out1_beat[0]
                );

            end

        end

    end


    // ============================================================
    // RESET
    // ============================================================

    task automatic reset_duts;

        begin

            sv_in0_tvalid = 1'b0;
            sv_in1_tvalid = 1'b0;

            av_in0_valid = 1'b0;
            av_in1_valid = 1'b0;


            sv_out0_tready = 1'b1;
            sv_out1_tready = 1'b1;

            av_out0_ack = 1'b1;
            av_out1_ack = 1'b1;


            rst_n = 1'b0;

            repeat (6)
                @(posedge clk);


            @(negedge clk);

            rst_n = 1'b1;


            repeat (3)
                @(posedge clk);


            $display("");
            $display("==========================================");
            $display("RESET COMPLETE");
            $display("==========================================");

        end

    endtask


    // ============================================================
    // CLEAR LOGS
    // ============================================================

    task automatic clear_logs;

        integer i;

        begin

            sv_out0_count = 0;
            sv_out1_count = 0;

            av_out0_count = 0;
            av_out1_count = 0;


            sv0_seen = 1'b0;
            sv1_seen = 1'b0;

            av0_seen = 1'b0;
            av1_seen = 1'b0;


            for (i = 0; i < 256; i = i + 1) begin

                sv_out0_log[i] = 32'b0;
                sv_out1_log[i] = 32'b0;

                av_out0_log[i] = 32'b0;
                av_out1_log[i] = 32'b0;

            end

        end

    endtask


    // ============================================================
    // SEND SAME BEAT TO INPUT 0 OF BOTH DUTS
    // ============================================================

    task automatic send0;

        input [31:0] data;
        input        dest;
        input        last;

        integer timeout;

        reg sv_done;
        reg av_done;

        begin

            @(negedge clk);


            // SV copy

            sv_in0_tdata  = data;
            sv_in0_tdest  = dest;
            sv_in0_tlast  = last;
            sv_in0_tvalid = 1'b1;


            // Anvil copy

            av_in0_beat = {
                data,
                dest,
                last
            };

            av_in0_valid = 1'b1;


            sv_done = 1'b0;
            av_done = 1'b0;

            timeout = 0;


            while (!(sv_done && av_done)) begin

                @(posedge clk);


                if (!sv_done &&
                    sv_in0_tvalid &&
                    sv_in0_tready) begin

                    sv_done = 1'b1;

                end


                if (!av_done &&
                    av_in0_valid &&
                    av_in0_ack) begin

                    av_done = 1'b1;

                end


                timeout = timeout + 1;


                if (timeout >= 100) begin

                    $display(
                        "TIMEOUT INPUT0 data=%08h",
                        data
                    );

                    errors = errors + 1;

                    sv_done = 1'b1;
                    av_done = 1'b1;

                end

            end


            @(negedge clk);

            sv_in0_tvalid = 1'b0;
            av_in0_valid  = 1'b0;


            // Allow valid to visibly drop before next transaction.

            @(posedge clk);


            $display(
                "INPUT0 SENT data=%08h dest=%b last=%b",
                data,
                dest,
                last
            );

        end

    endtask


    // ============================================================
    // SEND SAME BEAT TO INPUT 1 OF BOTH DUTS
    // ============================================================

    task automatic send1;

        input [31:0] data;
        input        dest;
        input        last;

        integer timeout;

        reg sv_done;
        reg av_done;

        begin

            @(negedge clk);


            sv_in1_tdata  = data;
            sv_in1_tdest  = dest;
            sv_in1_tlast  = last;
            sv_in1_tvalid = 1'b1;


            av_in1_beat = {
                data,
                dest,
                last
            };

            av_in1_valid = 1'b1;


            sv_done = 1'b0;
            av_done = 1'b0;

            timeout = 0;


            while (!(sv_done && av_done)) begin

                @(posedge clk);


                if (!sv_done &&
                    sv_in1_tvalid &&
                    sv_in1_tready) begin

                    sv_done = 1'b1;

                end


                if (!av_done &&
                    av_in1_valid &&
                    av_in1_ack) begin

                    av_done = 1'b1;

                end


                timeout = timeout + 1;


                if (timeout >= 100) begin

                    $display(
                        "TIMEOUT INPUT1 data=%08h",
                        data
                    );

                    errors = errors + 1;

                    sv_done = 1'b1;
                    av_done = 1'b1;

                end

            end


            @(negedge clk);

            sv_in1_tvalid = 1'b0;
            av_in1_valid  = 1'b0;


            @(posedge clk);


            $display(
                "INPUT1 SENT data=%08h dest=%b last=%b",
                data,
                dest,
                last
            );

        end

    endtask


    // ============================================================
    // CONCURRENT TWO-INPUT TRANSACTION
    // ============================================================

    task automatic send_both;

        input [31:0] data0;
        input        dest0;
        input        last0;

        input [31:0] data1;
        input        dest1;
        input        last1;

        integer timeout;

        reg sv0_done;
        reg sv1_done;

        reg av0_done;
        reg av1_done;

        begin

            @(negedge clk);


            // ----------------------------------------------------
            // SV input 0
            // ----------------------------------------------------

            sv_in0_tdata  = data0;
            sv_in0_tdest  = dest0;
            sv_in0_tlast  = last0;
            sv_in0_tvalid = 1'b1;


            // ----------------------------------------------------
            // SV input 1
            // ----------------------------------------------------

            sv_in1_tdata  = data1;
            sv_in1_tdest  = dest1;
            sv_in1_tlast  = last1;
            sv_in1_tvalid = 1'b1;


            // ----------------------------------------------------
            // Anvil input 0
            // ----------------------------------------------------

            av_in0_beat = {
                data0,
                dest0,
                last0
            };

            av_in0_valid = 1'b1;


            // ----------------------------------------------------
            // Anvil input 1
            // ----------------------------------------------------

            av_in1_beat = {
                data1,
                dest1,
                last1
            };

            av_in1_valid = 1'b1;


            sv0_done = 1'b0;
            sv1_done = 1'b0;

            av0_done = 1'b0;
            av1_done = 1'b0;

            timeout = 0;


            while (!(sv0_done &&
                     sv1_done &&
                     av0_done &&
                     av1_done)) begin

                @(posedge clk);


                if (!sv0_done &&
                    sv_in0_tvalid &&
                    sv_in0_tready) begin

                    sv0_done = 1'b1;

                end


                if (!sv1_done &&
                    sv_in1_tvalid &&
                    sv_in1_tready) begin

                    sv1_done = 1'b1;

                end


                if (!av0_done &&
                    av_in0_valid &&
                    av_in0_ack) begin

                    av0_done = 1'b1;

                end


                if (!av1_done &&
                    av_in1_valid &&
                    av_in1_ack) begin

                    av1_done = 1'b1;

                end


                timeout = timeout + 1;


                if (timeout >= 100) begin

                    $display("");
                    $display(
                        "TIMEOUT CONCURRENT SEND"
                    );

                    $display(
                        "I0=%08h DEST=%b LAST=%b",
                        data0,
                        dest0,
                        last0
                    );

                    $display(
                        "I1=%08h DEST=%b LAST=%b",
                        data1,
                        dest1,
                        last1
                    );

                    errors = errors + 1;

                    sv0_done = 1'b1;
                    sv1_done = 1'b1;

                    av0_done = 1'b1;
                    av1_done = 1'b1;

                end

            end


            @(negedge clk);

            sv_in0_tvalid = 1'b0;
            sv_in1_tvalid = 1'b0;

            av_in0_valid = 1'b0;
            av_in1_valid = 1'b0;


            @(posedge clk);


            $display(
                "CONCURRENT SENT I0=%08h I1=%08h",
                data0,
                data1
            );

        end

    endtask


    // ============================================================
    // DRAIN
    // ============================================================

    task automatic drain;

        begin

            repeat (20)
                @(posedge clk);

        end

    endtask


    // ============================================================
    // COMPARE OUTPUT 0
    // ============================================================

    task automatic compare_out0;

        integer i;

        begin

            $display("");
            $display("------------------------------------------");
            $display("OUTPUT 0 COMPARISON");
            $display("------------------------------------------");

            $display(
                "SV COUNT    = %0d",
                sv_out0_count
            );

            $display(
                "ANVIL COUNT = %0d",
                av_out0_count
            );


            if (sv_out0_count != av_out0_count) begin

                $display(
                    "FAIL OUT0 COUNT: SV=%0d ANVIL=%0d",
                    sv_out0_count,
                    av_out0_count
                );

                errors = errors + 1;

            end
            else begin

                $display(
                    "PASS OUT0 COUNT"
                );


                for (i = 0;
                     i < sv_out0_count;
                     i = i + 1) begin

                    if (sv_out0_log[i] !==
                        av_out0_log[i]) begin

                        $display(
                            "FAIL OUT0[%0d]: SV=%08h ANVIL=%08h",
                            i,
                            sv_out0_log[i],
                            av_out0_log[i]
                        );

                        errors = errors + 1;

                    end
                    else begin

                        $display(
                            "PASS OUT0[%0d] = %08h",
                            i,
                            sv_out0_log[i]
                        );

                    end

                end

            end

        end

    endtask


    // ============================================================
    // COMPARE OUTPUT 1
    // ============================================================

    task automatic compare_out1;

        integer i;

        begin

            $display("");
            $display("------------------------------------------");
            $display("OUTPUT 1 COMPARISON");
            $display("------------------------------------------");

            $display(
                "SV COUNT    = %0d",
                sv_out1_count
            );

            $display(
                "ANVIL COUNT = %0d",
                av_out1_count
            );


            if (sv_out1_count != av_out1_count) begin

                $display(
                    "FAIL OUT1 COUNT: SV=%0d ANVIL=%0d",
                    sv_out1_count,
                    av_out1_count
                );

                errors = errors + 1;

            end
            else begin

                $display(
                    "PASS OUT1 COUNT"
                );


                for (i = 0;
                     i < sv_out1_count;
                     i = i + 1) begin

                    if (sv_out1_log[i] !==
                        av_out1_log[i]) begin

                        $display(
                            "FAIL OUT1[%0d]: SV=%08h ANVIL=%08h",
                            i,
                            sv_out1_log[i],
                            av_out1_log[i]
                        );

                        errors = errors + 1;

                    end
                    else begin

                        $display(
                            "PASS OUT1[%0d] = %08h",
                            i,
                            sv_out1_log[i]
                        );

                    end

                end

            end

        end

    endtask


    // ============================================================
    // TEST 1
    // BASIC ROUTING
    // ============================================================

    task automatic test_basic;

        begin

            $display("");
            $display("==========================================");
            $display("TEST 1: BASIC ROUTING");
            $display("==========================================");

            clear_logs();
            reset_duts();


            send0(
                32'hA0000001,
                1'b0,
                1'b1
            );


            send1(
                32'hA0000002,
                1'b1,
                1'b1
            );


            drain();


            compare_out0();
            compare_out1();

        end

    endtask


    // ============================================================
    // TEST 2
    // CONCURRENT TRAFFIC
    // ============================================================

    task automatic test_concurrent;

        begin

            $display("");
            $display("==========================================");
            $display("TEST 2: CONCURRENT TRAFFIC");
            $display("==========================================");

            clear_logs();
            reset_duts();


            send_both(
                32'hB0000001,
                1'b0,
                1'b1,

                32'hB0000011,
                1'b1,
                1'b1
            );


            drain();


            compare_out0();
            compare_out1();

        end

    endtask


    // ============================================================
    // TEST 3
    // OUTPUT 0 ROUND ROBIN
    // ============================================================

    task automatic test_rr0;

        begin

            $display("");
            $display("==========================================");
            $display("TEST 3: OUTPUT 0 ROUND ROBIN");
            $display("==========================================");

            clear_logs();
            reset_duts();


            send_both(
                32'hC0000000,
                1'b0,
                1'b1,

                32'hC0000010,
                1'b0,
                1'b1
            );


            send_both(
                32'hC0000001,
                1'b0,
                1'b1,

                32'hC0000011,
                1'b0,
                1'b1
            );


            send_both(
                32'hC0000002,
                1'b0,
                1'b1,

                32'hC0000012,
                1'b0,
                1'b1
            );


            send_both(
                32'hC0000003,
                1'b0,
                1'b1,

                32'hC0000013,
                1'b0,
                1'b1
            );


            drain();


            compare_out0();

        end

    endtask


    // ============================================================
    // TEST 4
    // OUTPUT 1 ROUND ROBIN
    // ============================================================

    task automatic test_rr1;

        begin

            $display("");
            $display("==========================================");
            $display("TEST 4: OUTPUT 1 ROUND ROBIN");
            $display("==========================================");

            clear_logs();
            reset_duts();


            send_both(
                32'hD0000000,
                1'b1,
                1'b1,

                32'hD0000010,
                1'b1,
                1'b1
            );


            send_both(
                32'hD0000001,
                1'b1,
                1'b1,

                32'hD0000011,
                1'b1,
                1'b1
            );


            send_both(
                32'hD0000002,
                1'b1,
                1'b1,

                32'hD0000012,
                1'b1,
                1'b1
            );


            send_both(
                32'hD0000003,
                1'b1,
                1'b1,

                32'hD0000013,
                1'b1,
                1'b1
            );


            drain();


            compare_out1();

        end

    endtask


    // ============================================================
    // TEST 5
    // BACKPRESSURE
    // ============================================================

    task automatic test_backpressure;

        integer i;

        reg sv_seen;
        reg av_seen;

        reg [31:0] sv_hold;
        reg [31:0] av_hold;

        begin

            $display("");
            $display("==========================================");
            $display("TEST 5: BACKPRESSURE");
            $display("==========================================");

            clear_logs();
            reset_duts();


            // Block Output 0.

            sv_out0_tready = 1'b0;
            av_out0_ack    = 1'b0;


            @(negedge clk);


            // SV transaction.

            sv_in0_tdata  = 32'hE0000001;
            sv_in0_tdest  = 1'b0;
            sv_in0_tlast  = 1'b1;
            sv_in0_tvalid = 1'b1;


            // Anvil transaction.

            av_in0_beat = {
                32'hE0000001,
                1'b0,
                1'b1
            };

            av_in0_valid = 1'b1;


            sv_seen = 1'b0;
            av_seen = 1'b0;


            // ----------------------------------------------------
            // Wait until outputs become valid.
            // ----------------------------------------------------

            for (i = 0; i < 30; i = i + 1) begin

                @(posedge clk);


                if (sv_out0_tvalid &&
                    !sv_seen) begin

                    sv_seen = 1'b1;
                    sv_hold = sv_out0_tdata;

                    $display(
                        "SV BACKPRESSURE DATA=%08h",
                        sv_out0_tdata
                    );

                end


                if (av_out0_valid &&
                    !av_seen) begin

                    av_seen = 1'b1;
                    av_hold = av_out0_beat[33:2];

                    $display(
                        "ANVIL BACKPRESSURE DATA=%08h",
                        av_out0_beat[33:2]
                    );

                end

            end


            if (sv_seen) begin

                $display(
                    "PASS SV OUTPUT VALID UNDER BACKPRESSURE"
                );

            end
            else begin

                $display(
                    "FAIL SV OUTPUT DID NOT BECOME VALID"
                );

                errors = errors + 1;

            end


            if (av_seen) begin

                $display(
                    "PASS ANVIL OUTPUT VALID UNDER BACKPRESSURE"
                );

            end
            else begin

                $display(
                    "NOTE ANVIL OUTPUT DID NOT BECOME VALID YET"
                );

            end


            // No output should have transferred.

            if (sv_out0_count != 0) begin

                $display(
                    "FAIL SV TRANSFER DURING BACKPRESSURE"
                );

                errors = errors + 1;

            end


            if (av_out0_count != 0) begin

                $display(
                    "FAIL ANVIL TRANSFER DURING BACKPRESSURE"
                );

                errors = errors + 1;

            end


            // ----------------------------------------------------
            // Check SV stability.
            // ----------------------------------------------------

            if (sv_seen) begin

                repeat (3) begin

                    @(posedge clk);

                    if (sv_out0_tvalid &&
                        !sv_out0_tready &&
                        sv_out0_tdata !== sv_hold) begin

                        $display(
                            "FAIL SV DATA CHANGED UNDER BACKPRESSURE"
                        );

                        errors = errors + 1;

                    end

                end

            end


            // ----------------------------------------------------
            // Check Anvil stability.
            // ----------------------------------------------------

            if (av_seen) begin

                repeat (3) begin

                    @(posedge clk);

                    if (av_out0_valid &&
                        !av_out0_ack &&
                        av_out0_beat[33:2] !== av_hold) begin

                        $display(
                            "FAIL ANVIL DATA CHANGED UNDER BACKPRESSURE"
                        );

                        errors = errors + 1;

                    end

                end

            end


            // ----------------------------------------------------
            // Release backpressure.
            // ----------------------------------------------------

            @(negedge clk);

            sv_out0_tready = 1'b1;
            av_out0_ack    = 1'b1;


            // ----------------------------------------------------
            // Wait until inputs have transferred.
            // ----------------------------------------------------

            for (i = 0; i < 50; i = i + 1) begin

                @(posedge clk);

                if (sv_in0_tvalid &&
                    sv_in0_tready) begin

                    sv_in0_tvalid = 1'b0;

                end


                if (av_in0_valid &&
                    av_in0_ack) begin

                    av_in0_valid = 1'b0;

                end


                if (!sv_in0_tvalid &&
                    !av_in0_valid) begin

                    break;

                end

            end


            @(negedge clk);

            sv_in0_tvalid = 1'b0;
            av_in0_valid  = 1'b0;


            drain();


            // ----------------------------------------------------
            // Final counts.
            // ----------------------------------------------------

            if (sv_out0_count == 1) begin

                $display(
                    "PASS SV BACKPRESSURE RELEASE"
                );

            end
            else begin

                $display(
                    "FAIL SV RELEASE COUNT=%0d",
                    sv_out0_count
                );

                errors = errors + 1;

            end


            if (av_out0_count == 1) begin

                $display(
                    "PASS ANVIL BACKPRESSURE RELEASE"
                );

            end
            else begin

                $display(
                    "FAIL ANVIL RELEASE COUNT=%0d",
                    av_out0_count
                );

                errors = errors + 1;

            end

        end

    endtask


    // ============================================================
    // TEST 6
    // PACKET LOCKING
    // ============================================================

    task automatic test_packet_lock;

        begin

            $display("");
            $display("==========================================");
            $display("TEST 6: MULTI-BEAT PACKET LOCKING");
            $display("==========================================");

            clear_logs();
            reset_duts();


            // First beat of packet.

            send0(
                32'hBBBB0001,
                1'b0,
                1'b0
            );


            // Second beat competes with input 1.

            send_both(
                32'hBBBB0002,
                1'b0,
                1'b1,

                32'hCCCC0001,
                1'b0,
                1'b1
            );


            drain();


            compare_out0();

        end

    endtask


    // ============================================================
    // MAIN
    // ============================================================

    initial begin

        test_basic();

        test_concurrent();

        test_rr0();

        test_rr1();

        test_backpressure();

        test_packet_lock();


        $display("");
        $display("==========================================");
        $display("FINAL RESULT");
        $display("==========================================");

        $display(
            "Cycles checked : %0d",
            cycles
        );

        $display(
            "Total errors   : %0d",
            errors
        );


        if (errors == 0) begin

            $display("");
            $display(
                "PASS: ALL PART C TESTS PASSED"
            );
            $display("");

        end
        else begin

            $display("");
            $display(
                "FAIL: %0d ERRORS FOUND",
                errors
            );
            $display("");

        end


        $finish;

    end

endmodule

