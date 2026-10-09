
module otp_ecc_sva (
    input logic       clk,
    input logic       rst_n,
    input logic       otp_err_i,
    input logic       otp_rvalid_i,
    input logic       status_err_o,
    input logic [2:0] err_code_o
);

    localparam logic [2:0] ECC_ERROR = 3'd2;

    // Remember an ECC error observed before the response.
    logic err_seen_q;

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            err_seen_q <= 1'b0;
        else if (otp_rvalid_i)
            err_seen_q <= 1'b0;
        else if (otp_err_i)
            err_seen_q <= 1'b1;
    end

    // Property 1:
    // An earlier ECC error must be reported when the response arrives.
    property p_ecc_error_reported;
        @(posedge clk)
        disable iff (!rst_n)
        (err_seen_q && otp_rvalid_i)
        |=> (status_err_o && err_code_o == ECC_ERROR);
    endproperty

    assert property (p_ecc_error_reported)
        else $error("ECC error was lost before the response");

    // Property 2:
    // An error on the response-valid cycle must also be reported.
    property p_ecc_error_on_response;
        @(posedge clk)
        disable iff (!rst_n)
        (otp_err_i && otp_rvalid_i)
        |=> (status_err_o && err_code_o == ECC_ERROR);
    endproperty

    assert property (p_ecc_error_on_response)
        else $error("ECC error on response cycle was not reported");

endmodule
