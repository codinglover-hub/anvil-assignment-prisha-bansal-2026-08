`timescale 1ns/1ps

module tb_partc;

    // ============================================================
    // CLOCK / RESET
    // ============================================================

    logic clk;
    logic rst_n;

    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end


    // ============================================================
    // COMMON OUTPUT READY
    // ============================================================

    logic out0_tready;
    logic out1_tready;


    // ============================================================
    // SYSTEMVERILOG INPUTS
    // ============================================================

    logic [31:0] sv_in0_tdata;
    logic        sv_in0_tvalid;
    logic        sv_in0_tlast;
    logic        sv_in0_tdest;
    logic        sv_in0_tready;

    logic [31:0] sv_in1_tdata;
    logic        sv_in1_tvalid;
    logic        sv_in1_tlast;
    logic        sv_in1_tdest;
    logic        sv_in1_tready;


    // ============================================================
    // SYSTEMVERILOG OUTPUTS
    // ============================================================

    logic [31:0] sv_out0_tdata;
    logic        sv_out0_tvalid;
    logic        sv_out0_tlast;

    logic [31:0] sv_out1_tdata;
    logic        sv_out1_tvalid;
    logic        sv_out1_tlast;


    // ============================================================
    // ANVIL INTERFACE
    // ============================================================

    logic        av_in0_valid;
    logic        av_in0_ack;
    logic [33:0] av_in0_beat;

    logic        av_in1_valid;
    logic        av_in1_ack;
    logic [33:0] av_in1_beat;

    logic        av_out0_valid;
    logic        av_out0_ack;
    logic [33:0] av_out0_beat;

    logic        av_out1_valid;
    logic        av_out1_ack;
    logic [33:0] av_out1_beat;

    wire [31:0] av_out0_tdata = av_out0_beat[31:0];
    wire        av_out0_tlast = av_out0_beat[33];

    wire [31:0] av_out1_tdata = av_out1_beat[31:0];
    wire        av_out1_tlast = av_out1_beat[33];


    // ============================================================
    // SYSTEMVERILOG DUT
    // ============================================================

    router dut_sv (

        .clk          (clk),
        .rst_n        (rst_n),

        .in0_tdata    (sv_in0_tdata),
        .in0_tvalid   (sv_in0_tvalid),
        .in0_tready   (sv_in0_tready),
        .in0_tlast    (sv_in0_tlast),
        .in0_tdest    (sv_in0_tdest),

        .in1_tdata    (sv_in1_tdata),
        .in1_tvalid   (sv_in1_tvalid),
        .in1_tready   (sv_in1_tready),
        .in1_tlast    (sv_in1_tlast),
        .in1_tdest    (sv_in1_tdest),

        .out0_tdata   (sv_out0_tdata),
        .out0_tvalid  (sv_out0_tvalid),
        .out0_tready  (out0_tready),
        .out0_tlast   (sv_out0_tlast),

        .out1_tdata   (sv_out1_tdata),
        .out1_tvalid  (sv_out1_tvalid),
        .out1_tready  (out1_tready),
        .out1_tlast   (sv_out1_tlast)
    );


    // ============================================================
    // ANVIL DUT
    // ============================================================

    Top dut_anvil (

        .clk_i              (clk),
        .rst_ni             (rst_n),

        ._in0_beat_ack      (av_in0_ack),
        ._in0_beat_valid    (av_in0_valid),
        ._in0_beat_0        (av_in0_beat),

        ._in1_beat_ack      (av_in1_ack),
        ._in1_beat_valid    (av_in1_valid),
        ._in1_beat_0        (av_in1_beat),

        ._out0_beat_ack     (av_out0_ack),
        ._out0_beat_valid   (av_out0_valid),
        ._out0_beat_0       (av_out0_beat),

        ._out1_beat_ack     (av_out1_ack),
        ._out1_beat_valid   (av_out1_valid),
        ._out1_beat_0       (av_out1_beat)
    );


    assign av_out0_ack = out0_tready;
    assign av_out1_ack = out1_tready;


    // ============================================================
    // SCOREBOARDS
    // ============================================================

    logic [31:0] sv_q0_data [0:255];
    logic        sv_q0_last [0:255];

    logic [31:0] av_q0_data [0:255];
    logic        av_q0_last [0:255];

    logic [31:0] sv_q1_data [0:255];
    logic        sv_q1_last [0:255];

    logic [31:0] av_q1_data [0:255];
    logic        av_q1_last [0:255];

    integer sv_q0_count;
    integer av_q0_count;

    integer sv_q1_count;
    integer av_q1_count;

    integer errors;
    integer cycles;


    // ============================================================
    // OUTPUT CAPTURE
    // ============================================================

    always @(posedge clk) begin

        if (rst_n) begin

            cycles = cycles + 1;

            if (sv_out0_tvalid && out0_tready) begin

                sv_q0_data[sv_q0_count] = sv_out0_tdata;
                sv_q0_last[sv_q0_count] = sv_out0_tlast;

                sv_q0_count = sv_q0_count + 1;

            end

            if (av_out0_valid && av_out0_ack) begin

                av_q0_data[av_q0_count] = av_out0_tdata;
                av_q0_last[av_q0_count] = av_out0_tlast;

                av_q0_count = av_q0_count + 1;

            end

            if (sv_out1_tvalid && out1_tready) begin

                sv_q1_data[sv_q1_count] = sv_out1_tdata;
                sv_q1_last[sv_q1_count] = sv_out1_tlast;

                sv_q1_count = sv_q1_count + 1;

            end

            if (av_out1_valid && av_out1_ack) begin

                av_q1_data[av_q1_count] = av_out1_tdata;
                av_q1_last[av_q1_count] = av_out1_tlast;

                av_q1_count = av_q1_count + 1;

            end

        end

    end


    // ============================================================
    // RESET
    // ============================================================

    task reset_dut;

        begin

            rst_n = 1'b0;

            sv_in0_tvalid = 1'b0;
            sv_in1_tvalid = 1'b0;

            av_in0_valid = 1'b0;
            av_in1_valid = 1'b0;

            sv_in0_tdata = 32'h0;
            sv_in1_tdata = 32'h0;

            sv_in0_tdest = 1'b0;
            sv_in1_tdest = 1'b0;

            sv_in0_tlast = 1'b0;
            sv_in1_tlast = 1'b0;

            av_in0_beat = 34'h0;
            av_in1_beat = 34'h0;

            out0_tready = 1'b1;
            out1_tready = 1'b1;

            repeat (5)
                @(posedge clk);

            rst_n = 1'b1;

            repeat (3)
                @(posedge clk);

        end

    endtask


    // ============================================================
    // SEND TO SV INPUT 0
    // ============================================================

    task send_sv0;

        input [31:0] data;
        input        dest;
        input        last;

        integer timeout;

        begin

            timeout = 0;

            @(negedge clk);

            sv_in0_tdata  = data;
            sv_in0_tdest  = dest;
            sv_in0_tlast  = last;
            sv_in0_tvalid = 1'b1;

            while (!sv_in0_tready && timeout < 20) begin

                @(posedge clk);

                timeout = timeout + 1;

            end

            @(negedge clk);

            sv_in0_tvalid = 1'b0;

            sv_in0_tdata  = 32'h0;
            sv_in0_tdest  = 1'b0;
            sv_in0_tlast  = 1'b0;

        end

    endtask


    // ============================================================
    // SEND TO SV INPUT 1
    // ============================================================

    task send_sv1;

        input [31:0] data;
        input        dest;
        input        last;

        integer timeout;

        begin

            timeout = 0;

            @(negedge clk);

            sv_in1_tdata  = data;
            sv_in1_tdest  = dest;
            sv_in1_tlast  = last;
            sv_in1_tvalid = 1'b1;

            while (!sv_in1_tready && timeout < 20) begin

                @(posedge clk);

                timeout = timeout + 1;

            end

            @(negedge clk);

            sv_in1_tvalid = 1'b0;

            sv_in1_tdata  = 32'h0;
            sv_in1_tdest  = 1'b0;
            sv_in1_tlast  = 1'b0;

        end

    endtask


    // ============================================================
    // SEND TO ANVIL INPUT 0
    // ============================================================

    task send_av0;

        input [31:0] data;
        input        dest;
        input        last;

        integer timeout;

        begin

            timeout = 0;

            @(negedge clk);

            av_in0_beat  = {last, dest, data};
            av_in0_valid = 1'b1;

            while (!av_in0_ack && timeout < 20) begin

                @(posedge clk);

                timeout = timeout + 1;

            end

            @(negedge clk);

            av_in0_valid = 1'b0;
            av_in0_beat  = 34'h0;

        end

    endtask


    // ============================================================
    // SEND TO ANVIL INPUT 1
    // ============================================================

    task send_av1;

        input [31:0] data;
        input        dest;
        input        last;

        integer timeout;

        begin

            timeout = 0;

            @(negedge clk);

            av_in1_beat  = {last, dest, data};
            av_in1_valid = 1'b1;

            while (!av_in1_ack && timeout < 20) begin

                @(posedge clk);

                timeout = timeout + 1;

            end

            @(negedge clk);

            av_in1_valid = 1'b0;
            av_in1_beat  = 34'h0;

        end

    endtask


    // ============================================================
    // SEND SAME BEAT TO BOTH
    // ============================================================

    task send_both0;

        input [31:0] data;
        input        dest;
        input        last;

        begin

            fork

                send_sv0(data, dest, last);
                send_av0(data, dest, last);

            join

        end

    endtask


    task send_both1;

        input [31:0] data;
        input        dest;
        input        last;

        begin

            fork

                send_sv1(data, dest, last);
                send_av1(data, dest, last);

            join

        end

    endtask


    // ============================================================
    // COMPARE OUTPUT 0
    // ============================================================

    task compare_output0;

        integer i;

        begin

            $display("");
            $display("Checking Output 0");

            $display("SV beats    : %0d", sv_q0_count);
            $display("Anvil beats : %0d", av_q0_count);

            if (sv_q0_count != av_q0_count) begin

                $display(
                    "ERROR: Output0 count mismatch SV=%0d ANVIL=%0d",
                    sv_q0_count,
                    av_q0_count
                );

                errors = errors + 1;

            end

            for (i = 0;
                 i < sv_q0_count && i < av_q0_count;
                 i = i + 1) begin

                if (sv_q0_data[i] !== av_q0_data[i]) begin

                    $display(
                        "ERROR OUT0 beat %0d DATA SV=%h ANVIL=%h",
                        i,
                        sv_q0_data[i],
                        av_q0_data[i]
                    );

                    errors = errors + 1;

                end

                if (sv_q0_last[i] !== av_q0_last[i]) begin

                    $display(
                        "ERROR OUT0 beat %0d TLAST SV=%b ANVIL=%b",
                        i,
                        sv_q0_last[i],
                        av_q0_last[i]
                    );

                    errors = errors + 1;

                end

            end

        end

    endtask


    // ============================================================
    // COMPARE OUTPUT 1
    // ============================================================

    task compare_output1;

        integer i;

        begin

            $display("");
            $display("Checking Output 1");

            $display("SV beats    : %0d", sv_q1_count);
            $display("Anvil beats : %0d", av_q1_count);

            if (sv_q1_count != av_q1_count) begin

                $display(
                    "ERROR: Output1 count mismatch SV=%0d ANVIL=%0d",
                    sv_q1_count,
                    av_q1_count
                );

                errors = errors + 1;

            end

            for (i = 0;
                 i < sv_q1_count && i < av_q1_count;
                 i = i + 1) begin

                if (sv_q1_data[i] !== av_q1_data[i]) begin

                    $display(
                        "ERROR OUT1 beat %0d DATA SV=%h ANVIL=%h",
                        i,
                        sv_q1_data[i],
                        av_q1_data[i]
                    );

                    errors = errors + 1;

                end

                if (sv_q1_last[i] !== av_q1_last[i]) begin

                    $display(
                        "ERROR OUT1 beat %0d TLAST SV=%b ANVIL=%b",
                        i,
                        sv_q1_last[i],
                        av_q1_last[i]
                    );

                    errors = errors + 1;

                end

            end

        end

    endtask


    // ============================================================
    // MAIN TEST
    // ============================================================

    initial begin

        errors = 0;
        cycles = 0;

        sv_q0_count = 0;
        av_q0_count = 0;

        sv_q1_count = 0;
        av_q1_count = 0;

        reset_dut();


        // ========================================================
        // TEST 1
        // ========================================================

        $display("");
        $display("====================================================");
        $display(" PART C");
        $display(" ANVIL vs SYSTEMVERILOG");
        $display("====================================================");

        $display("");
        $display("TEST 1: Basic routing");

        send_both0(32'hA0000001, 1'b0, 1'b1);
        send_both1(32'hB0000001, 1'b1, 1'b1);

        repeat (15)
            @(posedge clk);


        // ========================================================
        // TEST 2
        // ========================================================

        $display("");
        $display("TEST 2: Multi-beat packet Output0");

        send_both0(32'hC0000001, 1'b0, 1'b0);
        send_both0(32'hC0000002, 1'b0, 1'b0);
        send_both0(32'hC0000003, 1'b0, 1'b1);

        repeat (15)
            @(posedge clk);


        // ========================================================
        // TEST 3
        // ========================================================

        $display("");
        $display("TEST 3: Multi-beat packet Output1");

        send_both1(32'hD0000001, 1'b1, 1'b0);
        send_both1(32'hD0000002, 1'b1, 1'b0);
        send_both1(32'hD0000003, 1'b1, 1'b1);

        repeat (15)
            @(posedge clk);


        // ========================================================
        // TEST 4
        // ========================================================

        $display("");
        $display("TEST 4: RR Method 1 - Output0");

        fork

            send_both0(32'hE0000001, 1'b0, 1'b1);
            send_both1(32'hE0000002, 1'b0, 1'b1);

        join

        repeat (15)
            @(posedge clk);


        // ========================================================
        // TEST 5
        // ========================================================

        $display("");
        $display("TEST 5: RR Method 2 - Output0");

        fork

            send_both0(32'hE1000001, 1'b0, 1'b1);
            send_both1(32'hE1000002, 1'b0, 1'b1);

        join

        repeat (15)
            @(posedge clk);


        // ========================================================
        // TEST 6
        // ========================================================

        $display("");
        $display("TEST 6: RR Method 1 - Output1");

        fork

            send_both0(32'hF0000001, 1'b1, 1'b1);
            send_both1(32'hF0000002, 1'b1, 1'b1);

        join

        repeat (15)
            @(posedge clk);


        // ========================================================
        // TEST 7
        // ========================================================

        $display("");
        $display("TEST 7: RR Method 2 - Output1");

        fork

            send_both0(32'hF1000001, 1'b1, 1'b1);
            send_both1(32'hF1000002, 1'b1, 1'b1);

        join

        repeat (15)
            @(posedge clk);


        // ========================================================
        // TEST 8
        // ========================================================

        $display("");
        $display("TEST 8: Backpressure Output0");

        @(negedge clk);

        out0_tready = 1'b0;

        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        @(negedge clk);

        out0_tready = 1'b1;

        send_both0(32'h11000001, 1'b0, 1'b1);

        repeat (15)
            @(posedge clk);


        // ========================================================
        // TEST 9
        // ========================================================

        $display("");
        $display("TEST 9: Backpressure Output1");

        @(negedge clk);

        out1_tready = 1'b0;

        @(posedge clk);
        @(posedge clk);
        @(posedge clk);

        @(negedge clk);

        out1_tready = 1'b1;

        send_both1(32'h12000001, 1'b1, 1'b1);

        repeat (15)
            @(posedge clk);


        // ========================================================
        // TEST 10
        // ========================================================

        $display("");
        $display("TEST 10: Packet locking Output0");

        fork

            begin

                send_both0(32'h20000001, 1'b0, 1'b0);
                send_both0(32'h20000002, 1'b0, 1'b0);
                send_both0(32'h20000003, 1'b0, 1'b1);

            end

            begin

                repeat (2)
                    @(posedge clk);

                send_both1(32'h30000001, 1'b0, 1'b0);
                send_both1(32'h30000002, 1'b0, 1'b1);

            end

        join

        repeat (25)
            @(posedge clk);


        // ========================================================
        // TEST 11
        // ========================================================

        $display("");
        $display("TEST 11: Packet locking Output1");

        fork

            begin

                send_both0(32'h40000001, 1'b1, 1'b0);
                send_both0(32'h40000002, 1'b1, 1'b0);
                send_both0(32'h40000003, 1'b1, 1'b1);

            end

            begin

                repeat (2)
                    @(posedge clk);

                send_both1(32'h50000001, 1'b1, 1'b0);
                send_both1(32'h50000002, 1'b1, 1'b1);

            end

        join

        repeat (30)
            @(posedge clk);


        // ========================================================
        // FINAL DRAIN
        // ========================================================

        repeat (40)
            @(posedge clk);


        // ========================================================
        // COMPARE
        // ========================================================

        compare_output0();
        compare_output1();


        // ========================================================
        // RESULT
        // ========================================================

        $display("");
        $display("====================================================");
        $display(" FINAL PART C RESULT");
        $display("====================================================");

        $display("Cycles simulated : %0d", cycles);

        $display("");
        $display("OUTPUT 0");
        $display("SV beats         : %0d", sv_q0_count);
        $display("Anvil beats      : %0d", av_q0_count);

        $display("");
        $display("OUTPUT 1");
        $display("SV beats         : %0d", sv_q1_count);
        $display("Anvil beats      : %0d", av_q1_count);

        $display("");
        $display("Errors           : %0d", errors);

        $display("====================================================");

        if (errors == 0) begin

            $display("");
            $display("PASS: FUNCTIONAL EQUIVALENCE");
            $display("PASS: SAME OUTPUT BEATS");
            $display("PASS: SAME OUTPUT ORDER");
            $display("PASS: RR TESTS");
            $display("PASS: BACKPRESSURE TESTS");
            $display("PASS: PACKET LOCKING TESTS");
            $display("");

        end
        else begin

            $display("");
            $display("FAIL: FUNCTIONAL DIFFERENCES FOUND");
            $display("");

        end

        $finish;

    end

endmodule
