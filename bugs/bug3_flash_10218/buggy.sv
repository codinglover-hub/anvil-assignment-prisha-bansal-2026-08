module flash_lcmgr_bug (
    input  logic       clk_i,
    input  logic       rst_ni,
    input  logic       req_i,

    input  logic [7:0] otp_key_i,
    input  logic [7:0] otp_rand_key_i,

    output logic [7:0] addr_key_o,
    output logic [7:0] rand_addr_key_o
);

    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (!rst_ni) begin
            addr_key_o      <= 8'h00;
            rand_addr_key_o <= 8'h00;
        end else if (req_i) begin
            addr_key_o <= otp_key_i;

            // BUG: wrong OTP field assigned
            rand_addr_key_o <= otp_rand_key_i;
        end
    end

endmodule
