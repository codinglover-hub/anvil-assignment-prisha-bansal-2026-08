module tb_buggy;

    logic clk = 0;
    logic rst_n = 0;
    logic req;

    logic [7:0] otp_key;
    logic [7:0] otp_rand_key;

    logic [7:0] addr_key;
    logic [7:0] rand_addr_key;

    always #5 clk = ~clk;

    flash_lcmgr_bug dut (
        .clk_i(clk),
        .rst_ni(rst_n),
        .req_i(req),
        .otp_key_i(otp_key),
        .otp_rand_key_i(otp_rand_key),
        .addr_key_o(addr_key),
        .rand_addr_key_o(rand_addr_key)
    );

    initial begin
        req = 0;
        otp_key = 8'hA5;
        otp_rand_key = 8'h3C;

        #12;
        rst_n = 1;

        #8;
        req = 1;

        #10;
        req = 0;

        if (rand_addr_key !== otp_key) begin
            $display("BUG DETECTED: rand_addr_key is incorrect");
            $display("Expected: %h", otp_key);
            $display("Actual:   %h", rand_addr_key);
        end else begin
            $display("ERROR: BUG NOT DETECTED");
        end

        $finish;
    end

endmodule
