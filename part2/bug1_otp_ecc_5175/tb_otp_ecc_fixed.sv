`timescale 1ns/1ps
module tb_otp_ecc_fixed;
logic clk = 1'b0;
    logic rst_n = 1'b0;
    logic otp_err_i = 1'b0;
    logic otp_rvalid_i = 1'b0;
logic status_err_o;
    logic [2:0] err_code_o;
otp_ecc_fixed dut (
        .clk(clk),
        .rst_n(rst_n),
        .otp_err_i(otp_err_i),
        .otp_rvalid_i(otp_rvalid_i),
        .status_err_o(status_err_o),
        .err_code_o(err_code_o)
    );
    always #5 clk = ~clk;
initial begin
        $display("=== FIXED OTP ECC TEST ===");
// Apply reset.
        repeat (2) @(negedge clk);
        rst_n = 1'b1;
// Inject an ECC error before the final response.
        @(negedge clk);
        otp_err_i = 1'b1;
        otp_rvalid_i = 1'b0;
// Error pulse disappears.
        @(negedge clk);
        otp_err_i = 1'b0;
// Additional internal read cycles.
        repeat (2) @(negedge clk);
// Final response arrives.
        otp_rvalid_i = 1'b1;
@(posedge clk);
        #1;
$display("status_err_o = %b", status_err_o);
        $display("err_code_o   = %0d", err_code_o);
if (status_err_o !== 1'b1 ||
            err_code_o !== 3'd2)
            $fatal(1, "FAIL: ECC error was not reported");
$display("PASS: ECC error correctly reported.");
        $finish;
    end
endmodule
