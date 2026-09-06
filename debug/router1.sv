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
    // ============================================================
    logic  lock0;
    logic  lock1;
    logic  owner0;
    logic  owner1;

    // ============================================================
    // ROUND-ROBIN STATE
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
    // REQUEST GENERATION (Gated by Reset)
    // ============================================================
    assign req0_from_in0 = rst_n && in0_tvalid && (in0_tdest == 1'b0);
    assign req0_from_in1 = rst_n && in1_tvalid && (in1_tdest == 1'b0);
    assign req1_from_in0 = rst_n && in0_tvalid && (in0_tdest == 1'b1);
    assign req1_from_in1 = rst_n && in1_tvalid && (in1_tdest == 1'b1);

    // ============================================================
    // OUTPUT 0 ARBITRATION
    // ============================================================
    always_comb begin
        grant0 = 1'b0;
        sel0   = 1'b0;

        if (lock0) begin
            sel0   = owner0;
            grant0 = 1'b1; 
        end
        else begin
            case ({req0_from_in1, req0_from_in0})
                2'b00: begin grant0 = 1'b0; sel0 = 1'b0; end
                2'b01: begin grant0 = 1'b1; sel0 = 1'b0; end
                2'b10: begin grant0 = 1'b1; sel0 = 1'b1; end
                2'b11: begin grant0 = 1'b1; sel0 = rr0;  end
                default: begin grant0 = 1'b0; sel0 = 1'b0; end
            endcase
        end
    end

    // ============================================================
    // OUTPUT 1 ARBITRATION
    // ============================================================
    always_comb begin
        grant1 = 1'b0;
        sel1   = 1'b0;

        if (lock1) begin
            sel1   = owner1;
            grant1 = 1'b1; 
        end
        else begin
            case ({req1_from_in1, req1_from_in0})
                2'b00: begin grant1 = 1'b0; sel1 = 1'b0; end
                2'b01: begin grant1 = 1'b1; sel1 = 1'b0; end
                2'b10: begin grant1 = 1'b1; sel1 = 1'b1; end
                2'b11: begin grant1 = 1'b1; sel1 = rr1;  end
                default: begin grant1 = 1'b0; sel1 = 1'b0; end
            endcase
        end
    end

    // ============================================================
    // STATE MACHINE REGISTER CONTROLS (LOCK, OWNER, ROUND-ROBIN)
    // ============================================================
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            lock0  <= 1'b0;
            owner0 <= 1'b0;
            rr0    <= 1'b0;
            lock1  <= 1'b0;
            owner1 <= 1'b0;
            rr1    <= 1'b0;
        end else begin
            // --- Output 0 State Control ---
            if (!lock0) begin
                if (grant0 && out0_tready && out0_tvalid) begin
                    if (!out0_tlast) begin
                        lock0  <= 1'b1;
                        owner0 <= sel0;
                    end else begin
                        rr0    <= ~sel0;
                    end
                end
            end else begin
                if (out0_tvalid && out0_tready && out0_tlast) begin
                    lock0 <= 1'b0;
                    rr0   <= ~owner0; 
                end
            end

            // --- Output 1 State Control ---
            if (!lock1) begin
                if (grant1 && out1_tready && out1_tvalid) begin
                    if (!out1_tlast) begin
                        lock1  <= 1'b1;
                        owner1 <= sel1;
                    end else begin
                        rr1    <= ~sel1;
                    end
                end
            end else begin
                if (out1_tvalid && out1_tready && out1_tlast) begin
                    lock1 <= 1'b0;
                    rr1   <= ~owner1; 
                end
            end
        end
    end

    // ============================================================
    // OUTPUT 0 DATA PATH
    // ============================================================
    always_comb begin
        out0_tvalid = 1'b0;
        out0_tdata  = 32'b0;
        out0_tlast  = 1'b0;

        if (rst_n && grant0) begin
            if (sel0 == 1'b0) begin
                out0_tvalid = in0_tvalid;
                out0_tdata  = in0_tdata;
                out0_tlast  = in0_tlast;
            end else begin
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

        if (rst_n && grant1) begin
            if (sel1 == 1'b0) begin
                out1_tvalid = in0_tvalid;
                out1_tdata  = in0_tdata;
                out1_tlast  = in0_tlast;
            end else begin
                out1_tvalid = in1_tvalid;
                out1_tdata  = in1_tdata;
                out1_tlast  = in1_tlast;
            end
        end
    end

    // ============================================================
    // READY BACKPRESSURE GENERATION
    // ============================================================
    always_comb begin
        in0_tready = 1'b0;
        in1_tready = 1'b0;

        if (rst_n) begin
            if (grant0 && (sel0 == 1'b0)) begin
                in0_tready = out0_tready;
            end else if (grant1 && (sel1 == 1'b0)) begin
                in0_tready = out1_tready;
            end

            if (grant0 && (sel0 == 1'b1)) begin
                in1_tready = out0_tready;
            end else if (grant1 && (sel1 == 1'b1)) begin
                in1_tready = out1_tready;
            end
        end
    end

endmodule

