module tb_buggy;

    logic clk = 0;
    logic rst_n = 0;
    logic [2:0] op;

    logic disable_o;
    logic stuck_o;

    always #5 clk = ~clk;

    keymgr_bug dut (
        .clk_i(clk),
        .rst_ni(rst_n),
        .op_i(op),
        .disable_o(disable_o),
        .stuck_o(stuck_o)
    );

    initial begin
        op = 3'h5;       // Reserved operation
        #12 rst_n = 1;
        #10;

        if (disable_o !== 1'b0 || stuck_o !== 1'b1)
    $fatal(1, "FAIL: expected reserved encoding bug");

$fatal(1, "BUG REPRODUCED: reserved encoding is not Disable");

        $finish;
    end

endmodule
