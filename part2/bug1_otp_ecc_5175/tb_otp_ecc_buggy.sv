
`timescale 1ns/1ps

module tb_otp_ecc_buggy;

    logic clk = 0;
    logic rst_n = 0;
    logic otp_err_i = 0;
    logic otp_rvalid_i = 0;

    logic status_err_o;
    logic [2:0] err_code_o;

    otp_ecc_buggy dut (
        .clk(clk),
        .rst_n(rst_n),
        .otp_err_i(otp_err_i),
        .otp_rvalid_i(otp_rvalid_i),
        .status_err_o(status_err_o),
        .err_code_o(err_code_o)
    );

    always #5 clk = ~clk;

    initial begin
        repeat (2) @(negedge clk);
        rst_n = 1;

        // Error occurs before the final valid response.
        @(negedge clk);
        otp_err_i = 1;
        otp_rvalid_i = 0;

        @(negedge clk);
        otp_err_i = 0;

        repeat (2) @(negedge clk);

        // Final response arrives, but the error has disappeared.
        otp_rvalid_i = 1;

        @(posedge clk);
        #1;

        if (status_err_o !== 1'b1 ||
            err_code_o !== 3'd2)
            $fatal(1, "FAIL: ECC error was lost");

        $display("PASS: ECC error correctly reported");
        $finish;
    end

endmodule

