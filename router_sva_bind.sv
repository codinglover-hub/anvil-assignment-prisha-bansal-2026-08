`timescale 1ns/1ps

// Icarus-compatible connection module.
// The actual checker is instantiated here.

module router_sva_bind (
    input wire        clk,
    input wire        rst_n,

    input wire [31:0] tdata0,
    input wire        tvalid0,
    input wire        tlast0,
    input wire        tdest0,
    input wire        tready0,

    input wire [31:0] tdata1,
    input wire        tvalid1,
    input wire        tlast1,
    input wire        tdest1,
    input wire        tready1,

    input wire [31:0] out_data0,
    input wire        out_valid0,
    input wire        out_last0,
    input wire        out_src0,
    input wire        out_ready0,

    input wire [31:0] out_data1,
    input wire        out_valid1,
    input wire        out_last1,
    input wire        out_src1,
    input wire        out_ready1
);

    router_sva checker (
        .clk(clk),
        .rst_n(rst_n),

        .tdata0(tdata0),
        .tvalid0(tvalid0),
        .tlast0(tlast0),
        .tdest0(tdest0),
        .tready0(tready0),

        .tdata1(tdata1),
        .tvalid1(tvalid1),
        .tlast1(tlast1),
        .tdest1(tdest1),
        .tready1(tready1),

        .out_data0(out_data0),
        .out_valid0(out_valid0),
        .out_last0(out_last0),
        .out_src0(out_src0),
        .out_ready0(out_ready0),

        .out_data1(out_data1),
        .out_valid1(out_valid1),
        .out_last1(out_last1),
        .out_src1(out_src1),
        .out_ready1(out_ready1)
    );

endmodule
