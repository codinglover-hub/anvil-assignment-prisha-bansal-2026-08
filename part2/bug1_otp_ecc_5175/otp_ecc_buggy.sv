
module otp_ecc_buggy (
    input  logic       clk,
    input  logic       rst_n,
    input  logic       otp_err_i,
    input  logic       otp_rvalid_i,
    output logic       status_err_o,
    output logic [2:0] err_code_o
);

    localparam logic [2:0] NO_ERROR = 3'd0;
    localparam logic [2:0] ECC_ERROR = 3'd2;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            status_err_o <= 1'b0;
            err_code_o   <= NO_ERROR;
        end else if (otp_rvalid_i) begin
            // BUG: Samples otp_err_i only when response-valid
            // is asserted. An earlier error can be lost.
            if (otp_err_i) begin
                status_err_o <= 1'b1;
                err_code_o   <= ECC_ERROR;
            end
        end
    end

endmodule

