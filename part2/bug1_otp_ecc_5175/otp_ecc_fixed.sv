module otp_ecc_fixed (
    input  logic       clk,
    input  logic       rst_n,
    input  logic       otp_err_i,
    input  logic       otp_rvalid_i,
    output logic       status_err_o,
    output logic [2:0] err_code_o
);
localparam logic [2:0] NO_ERROR  = 3'd0;
    localparam logic [2:0] ECC_ERROR = 3'd2;
    logic err_seen_q;
always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            err_seen_q   <= 1'b0;
            status_err_o <= 1'b0;
            err_code_o   <= NO_ERROR;
        end else begin
// Remember an error even if it arrives before valid.
            if (otp_err_i)
                err_seen_q <= 1'b1;
// Report the accumulated error with the final response.
            if (otp_rvalid_i) begin
                if (otp_err_i || err_seen_q) begin
                    status_err_o <= 1'b1;
                    err_code_o   <= ECC_ERROR;
                end
// Clear the accumulated error for the next operation.
                err_seen_q <= 1'b0;
            end
        end
    end
endmodule
