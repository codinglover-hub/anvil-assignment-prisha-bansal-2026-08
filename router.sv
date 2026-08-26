`timescale 1ns/1ps

module router (
    input  logic        clk,
    input  logic        rst_n,

    // ============================================================
    // Input 0
    // ============================================================

    input  logic [31:0] in0_tdata,
    input  logic        in0_tvalid,
    output logic        in0_tready,
    input  logic        in0_tlast,
    input  logic        in0_tdest,

    // ============================================================
    // Input 1
    // ============================================================

    input  logic [31:0] in1_tdata,
    input  logic        in1_tvalid,
    output logic        in1_tready,
    input  logic        in1_tlast,
    input  logic        in1_tdest,

    // ============================================================
    // Output 0
    // ============================================================

    output logic [31:0] out0_tdata,
    output logic        out0_tvalid,
    input  logic        out0_tready,
    output logic        out0_tlast,

    // ============================================================
    // Output 1
    // ============================================================

    output logic [31:0] out1_tdata,
    output logic        out1_tvalid,
    input  logic        out1_tready,
    output logic        out1_tlast
);

    // ============================================================
    // PACKET LOCK STATE
    //
    // lock0 = Output 0 is currently reserved by a packet.
    // lock1 = Output 1 is currently reserved by a packet.
    //
    // owner0 / owner1:
    //   0 = Input 0 owns the output
    //   1 = Input 1 owns the output
    // ============================================================

    logic  lock0;
    logic  lock1;

    logic  owner0;
    logic  owner1;

    // ============================================================
    // ROUND-ROBIN STATE
    //
    // rr0:
    //   0 = Input 0 gets priority for Output 0
    //   1 = Input 1 gets priority for Output 0
    //
    // rr1:
    //   0 = Input 0 gets priority for Output 1
    //   1 = Input 1 gets priority for Output 1
    // ============================================================

    logic rr0;
    logic rr1;

    // ============================================================
    // ARBITRATION SIGNALS
    // ============================================================

    logic grant0;
    logic grant1;

    logic sel0;
    logic sel1;

    // ============================================================
    // REQUEST SIGNALS
    // ============================================================

    logic req0_from_in0;
    logic req0_from_in1;

    logic req1_from_in0;
    logic req1_from_in1;

    // ============================================================
    // HANDSHAKE SIGNALS
    // ============================================================

    logic out0_xfer;
    logic out1_xfer;

    // ============================================================
    // REQUEST GENERATION
    //
    // Input 0 requests Output 0 when:
    //   valid = 1
    //   destination = 0
    //
    // Input 0 requests Output 1 when:
    //   valid = 1
    //   destination = 1
    //
    // Same for Input 1.
    // ============================================================

    assign req0_from_in0 =
        in0_tvalid && (in0_tdest == 1'b0);

    assign req0_from_in1 =
        in1_tvalid && (in1_tdest == 1'b0);

    assign req1_from_in0 =
        in0_tvalid && (in0_tdest == 1'b1);

    assign req1_from_in1 =
        in1_tvalid && (in1_tdest == 1'b1);

    // ============================================================
    // OUTPUT 0 ARBITRATION
    // ============================================================

    always_comb begin

        grant0 = 1'b0;
        sel0   = 1'b0;

        // --------------------------------------------------------
        // If Output 0 is locked, only the packet owner can use it.
        // --------------------------------------------------------

        if (lock0) begin

            sel0 = owner0;

            if (owner0 == 1'b0)
                grant0 = req0_from_in0;
            else
                grant0 = req0_from_in1;

        end

        // --------------------------------------------------------
        // Output 0 is not locked.
        // Perform normal arbitration.
        // --------------------------------------------------------

        else begin

            case ({req0_from_in1, req0_from_in0})

                // No requester
                2'b00: begin
                    grant0 = 1'b0;
                    sel0   = 1'b0;
                end

                // Only Input 0 requests Output 0
                2'b01: begin
                    grant0 = 1'b1;
                    sel0   = 1'b0;
                end

                // Only Input 1 requests Output 0
                2'b10: begin
                    grant0 = 1'b1;
                    sel0   = 1'b1;
                end

                // Both inputs request Output 0.
                // Use round-robin priority.
                2'b11: begin
                    grant0 = 1'b1;
                    sel0   = rr0;
                end

                default: begin
                    grant0 = 1'b0;
                    sel0   = 1'b0;
                end

            endcase

        end

    end

    // ============================================================
    // OUTPUT 1 ARBITRATION
    // ============================================================

    always_comb begin

        grant1 = 1'b0;
        sel1   = 1'b0;

        // --------------------------------------------------------
        // If Output 1 is locked, only the packet owner can use it.
        // --------------------------------------------------------

        if (lock1) begin

            sel1 = owner1;

            if (owner1 == 1'b0)
                grant1 = req1_from_in0;
            else
                grant1 = req1_from_in1;

        end

        // --------------------------------------------------------
        // Output 1 is not locked.
        // Perform normal arbitration.
        // --------------------------------------------------------

        else begin

            case ({req1_from_in1, req1_from_in0})

                // No requester
                2'b00: begin
                    grant1 = 1'b0;
                    sel1   = 1'b0;
                end

                // Only Input 0 requests Output 1
                2'b01: begin
                    grant1 = 1'b1;
                    sel1   = 1'b0;
                end

                // Only Input 1 requests Output 1
                2'b10: begin
                    grant1 = 1'b1;
                    sel1   = 1'b1;
                end

                // Both inputs request Output 1.
                // Use round-robin priority.
                2'b11: begin
                    grant1 = 1'b1;
                    sel1   = rr1;
                end

                default: begin
                    grant1 = 1'b0;
                    sel1   = 1'b0;
                end

            endcase

        end

    end

    // ============================================================
    // OUTPUT 0 DATA PATH
    // ============================================================

    always_comb begin

        out0_tvalid = 1'b0;
        out0_tdata  = 32'b0;
        out0_tlast  = 1'b0;

        if (grant0) begin

            if (sel0 == 1'b0) begin

                out0_tvalid = in0_tvalid;
                out0_tdata  = in0_tdata;
                out0_tlast  = in0_tlast;

            end

            else begin

                out0_tvalid = in1_tvalid;
                out0_tdata  = in1_tdata;
                out0_tlast  = in1_tlast;

            end

        end

    end

    // ============================================================
    // OUTPUT 1 DATA PATH
    // ============================================================

    always_comb begin

        out1_tvalid = 1'b0;
        out1_tdata  = 32'b0;
        out1_tlast  = 1'b0;

        if (grant1) begin

            if (sel1 == 1'b0) begin

                out1_tvalid = in0_tvalid;
                out1_tdata  = in0_tdata;
                out1_tlast  = in0_tlast;

            end

            else begin

                out1_tvalid = in1_tvalid;
                out1_tdata  = in1_tdata;
                out1_tlast  = in1_tlast;

            end

        end

    end

    // ============================================================
    // READY GENERATION
    //
    // An input is ready when the output it has been selected for
    // is ready.
    //
    // Since tdest selects only one output, an input cannot normally
    // be selected by both outputs at the same time.
    // ============================================================

    always_comb begin

        in0_tready = 1'b0;
        in1_tready = 1'b0;

        // Input 0 selected for Output 0
        if (grant0 && (sel0 == 1'b0))
            in0_tready = out0_tready;

        // Input 0 selected for Output 1
        if (grant1 && (sel1 == 1'b0))
            in0_tready = out1_tready;

        // Input 1 selected for Output 0
        if (grant0 && (sel0 == 1'b1))
            in1_tready = out0_tready;

        // Input 1 selected for Output 1
        if (grant1 && (sel1 == 1'b1))
            in1_tready = out1_tready;

    end

    // ============================================================
    // HANDSHAKE DETECTION
    //
    // A transfer occurs only when:
    //
    //     valid && ready
    //
    // Therefore state changes associated with packet progress
    // happen only after a successful transfer.
    // ============================================================

    assign out0_xfer =
        out0_tvalid && out0_tready;

    assign out1_xfer =
        out1_tvalid && out1_tready;

    // ============================================================
    // SEQUENTIAL STATE
    //
    // Packet locking:
    //
    // If a transferred beat has tlast = 0, the packet continues.
    // The output is therefore locked to that input.
    //
    // If a transferred beat has tlast = 1, the packet is complete
    // and the output becomes available for arbitration again.
    //
    // Round-robin:
    //
    // The round-robin pointer changes ONLY when there was actual
    // contention. This prevents a non-contended transfer from
    // unnecessarily changing arbitration priority.
    // ============================================================

    always_ff @(posedge clk or negedge rst_n) begin

        if (!rst_n) begin

            lock0  <= 1'b0;
            lock1  <= 1'b0;

            owner0 <= 1'b0;
            owner1 <= 1'b0;

            rr0    <= 1'b0;
            rr1    <= 1'b0;

        end

        else begin

            // ====================================================
            // OUTPUT 0 STATE
            // ====================================================

            if (out0_xfer) begin

                // ------------------------------------------------
                // Packet completed.
                // ------------------------------------------------

                if (out0_tlast) begin

                    lock0 <= 1'b0;

                    // Update priority only if both inputs were
                    // competing for Output 0.
                    if (req0_from_in0 && req0_from_in1)
                        rr0 <= ~sel0;

                end

                // ------------------------------------------------
                // Packet continues.
                // Lock Output 0 to current packet owner.
                // ------------------------------------------------

                else begin

                    lock0  <= 1'b1;
                    owner0 <= sel0;

                end

            end

            // ====================================================
            // OUTPUT 1 STATE
            // ====================================================

            if (out1_xfer) begin

                // ------------------------------------------------
                // Packet completed.
                // ------------------------------------------------

                if (out1_tlast) begin

                    lock1 <= 1'b0;

                    // Update priority only if both inputs were
                    // competing for Output 1.
                    if (req1_from_in0 && req1_from_in1)
                        rr1 <= ~sel1;

                end

                // ------------------------------------------------
                // Packet continues.
                // Lock Output 1 to current packet owner.
                // ------------------------------------------------

                else begin

                    lock1  <= 1'b1;
                    owner1 <= sel1;

                end

            end

        end

    end

endmodule
