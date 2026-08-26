`timescale 1ns/1ps

// ================================================================
// 2-Input, 2-Output Concurrent Packet Router
//
// Features:
//   - 2 input ports
//   - 2 output ports
//   - 1-bit destination
//   - Ready/Valid handshake
//   - Multi-beat packets using TLAST
//   - Packet locking
//   - Per-output round-robin arbitration
//   - Backpressure support
// ================================================================

module router #(
    parameter DATA_WIDTH = 32
)(
    input  logic clk,
    input  logic rst_n,

    // ============================================================
    // INPUT 0
    // ============================================================
    input  logic [DATA_WIDTH-1:0] tdata0,
    input  logic                 tvalid0,
    input  logic                 tlast0,
    input  logic                 tdest0,
    output logic                 tready0,

    // ============================================================
    // INPUT 1
    // ============================================================
    input  logic [DATA_WIDTH-1:0] tdata1,
    input  logic                 tvalid1,
    input  logic                 tlast1,
    input  logic                 tdest1,
    output logic                 tready1,

    // ============================================================
    // OUTPUT 0
    // ============================================================
    output logic [DATA_WIDTH-1:0] out_data0,
    output logic                  out_valid0,
    output logic                  out_last0,
    output logic                  out_src0,
    input  logic                  out_ready0,

    // ============================================================
    // OUTPUT 1
    // ============================================================
    output logic [DATA_WIDTH-1:0] out_data1,
    output logic                  out_valid1,
    output logic                  out_last1,
    output logic                  out_src1,
    input  logic                  out_ready1
);

    // ============================================================
    // ARBITRATION STATE
    //
    // rr0 = next preferred input for output 0
    // rr1 = next preferred input for output 1
    //
    // 0 -> prefer input 0
    // 1 -> prefer input 1
    // ============================================================

    logic rr0;
    logic rr1;

    // ============================================================
    // PACKET LOCK STATE
    //
    // lock0 = output 0 currently belongs to a packet
    // lock1 = output 1 currently belongs to a packet
    //
    // owner0 / owner1 tells us which input owns the output.
    // ============================================================

    logic lock0;
    logic lock1;

    logic owner0;
    logic owner1;

    // ============================================================
    // GRANT SIGNALS
    // ============================================================

    logic grant0;
    logic grant1;

    // selected input for each output
    logic sel0;
    logic sel1;

    // ============================================================
    // ARBITRATION FOR OUTPUT 0
    // ============================================================

    always_comb begin

        grant0 = 1'b0;
        sel0   = 1'b0;

        // --------------------------------------------------------
        // If output 0 is locked, keep using the same input.
        // --------------------------------------------------------

        if (lock0) begin

            if (owner0 == 1'b0) begin
                if (tvalid0 && (tdest0 == 1'b0)) begin
                    grant0 = 1'b1;
                    sel0   = 1'b0;
                end
            end
            else begin
                if (tvalid1 && (tdest1 == 1'b0)) begin
                    grant0 = 1'b1;
                    sel0   = 1'b1;
                end
            end

        end

        // --------------------------------------------------------
        // Otherwise perform round-robin arbitration.
        // --------------------------------------------------------

        else begin

            if (rr0 == 1'b0) begin

                if (tvalid0 && (tdest0 == 1'b0)) begin
                    grant0 = 1'b1;
                    sel0   = 1'b0;
                end
                else if (tvalid1 && (tdest1 == 1'b0)) begin
                    grant0 = 1'b1;
                    sel0   = 1'b1;
                end

            end
            else begin

                if (tvalid1 && (tdest1 == 1'b0)) begin
                    grant0 = 1'b1;
                    sel0   = 1'b1;
                end
                else if (tvalid0 && (tdest0 == 1'b0)) begin
                    grant0 = 1'b1;
                    sel0   = 1'b0;
                end

            end
        end
    end

    // ============================================================
    // ARBITRATION FOR OUTPUT 1
    // ============================================================

    always_comb begin

        grant1 = 1'b0;
        sel1   = 1'b0;

        // --------------------------------------------------------
        // If output 1 is locked, keep using the same input.
        // --------------------------------------------------------

        if (lock1) begin

            if (owner1 == 1'b0) begin
                if (tvalid0 && (tdest0 == 1'b1)) begin
                    grant1 = 1'b1;
                    sel1   = 1'b0;
                end
            end
            else begin
                if (tvalid1 && (tdest1 == 1'b1)) begin
                    grant1 = 1'b1;
                    sel1   = 1'b1;
                end
            end

        end

        // --------------------------------------------------------
        // Otherwise perform round-robin arbitration.
        // --------------------------------------------------------

        else begin

            if (rr1 == 1'b0) begin

                if (tvalid0 && (tdest0 == 1'b1)) begin
                    grant1 = 1'b1;
                    sel1   = 1'b0;
                end
                else if (tvalid1 && (tdest1 == 1'b1)) begin
                    grant1 = 1'b1;
                    sel1   = 1'b1;
                end

            end
            else begin

                if (tvalid1 && (tdest1 == 1'b1)) begin
                    grant1 = 1'b1;
                    sel1   = 1'b1;
                end
                else if (tvalid0 && (tdest0 == 1'b1)) begin
                    grant1 = 1'b1;
                    sel1   = 1'b0;
                end

            end
        end
    end

    // ============================================================
    // OUTPUT DATA MUX
    // ============================================================

    always_comb begin

        // Defaults
        out_data0  = '0;
        out_valid0 = 1'b0;
        out_last0  = 1'b0;
        out_src0   = 1'b0;

        out_data1  = '0;
        out_valid1 = 1'b0;
        out_last1  = 1'b0;
        out_src1   = 1'b0;

        // --------------------------------------------------------
        // OUTPUT 0
        // --------------------------------------------------------

        if (grant0) begin

            if (sel0 == 1'b0) begin
                out_data0  = tdata0;
                out_valid0 = tvalid0;
                out_last0  = tlast0;
                out_src0   = 1'b0;
            end
            else begin
                out_data0  = tdata1;
                out_valid0 = tvalid1;
                out_last0  = tlast1;
                out_src0   = 1'b1;
            end

        end

        // --------------------------------------------------------
        // OUTPUT 1
        // --------------------------------------------------------

        if (grant1) begin

            if (sel1 == 1'b0) begin
                out_data1  = tdata0;
                out_valid1 = tvalid0;
                out_last1  = tlast0;
                out_src1   = 1'b0;
            end
            else begin
                out_data1  = tdata1;
                out_valid1 = tvalid1;
                out_last1  = tlast1;
                out_src1   = 1'b1;
            end

        end
    end

    // ============================================================
    // INPUT READY
    //
    // An input is ready if the selected output is ready.
    //
    // An input can only be selected by one output because tdest
    // determines the destination.
    // ============================================================

    always_comb begin

        tready0 = 1'b0;
        tready1 = 1'b0;

        if (grant0 && out_ready0 && (sel0 == 1'b0))
            tready0 = 1'b1;

        if (grant1 && out_ready1 && (sel1 == 1'b0))
            tready0 = 1'b1;

        if (grant0 && out_ready0 && (sel0 == 1'b1))
            tready1 = 1'b1;

        if (grant1 && out_ready1 && (sel1 == 1'b1))
            tready1 = 1'b1;
    end

    // ============================================================
    // SEQUENTIAL STATE
    // ============================================================

    always_ff @(posedge clk or negedge rst_n) begin

        if (!rst_n) begin

            rr0    <= 1'b0;
            rr1    <= 1'b0;

            lock0  <= 1'b0;
            lock1  <= 1'b0;

            owner0 <= 1'b0;
            owner1 <= 1'b0;

        end
        else begin

            // ====================================================
            // OUTPUT 0 PACKET LOCKING
            // ====================================================

            if (!lock0) begin

                if (grant0) begin

                    owner0 <= sel0;

                    // If first beat is not last, lock output.
                    if (!(sel0 ? tlast1 : tlast0))
                        lock0 <= 1'b1;
                    else
                        lock0 <= 1'b0;

                end

            end
            else begin

                // Locked packet continues.
                if (grant0 && out_ready0) begin

                    if (out_last0)
                        lock0 <= 1'b0;

                end
            end

            // ====================================================
            // OUTPUT 1 PACKET LOCKING
            // ====================================================

            if (!lock1) begin

                if (grant1) begin

                    owner1 <= sel1;

                    if (!(sel1 ? tlast1 : tlast0))
                        lock1 <= 1'b1;
                    else
                        lock1 <= 1'b0;

                end

            end
            else begin

                if (grant1 && out_ready1) begin

                    if (out_last1)
                        lock1 <= 1'b0;

                end
            end

            // ====================================================
            // ROUND-ROBIN UPDATE FOR OUTPUT 0
            //
            // Only change priority after a successful transfer.
            // ====================================================

            if (grant0 && out_ready0) begin

                if (sel0 == 1'b0)
                    rr0 <= 1'b1;
                else
                    rr0 <= 1'b0;

            end

            // ====================================================
            // ROUND-ROBIN UPDATE FOR OUTPUT 1
            // ====================================================

            if (grant1 && out_ready1) begin

                if (sel1 == 1'b0)
                    rr1 <= 1'b1;
                else
                    rr1 <= 1'b0;

            end

        end
    end

endmodule
