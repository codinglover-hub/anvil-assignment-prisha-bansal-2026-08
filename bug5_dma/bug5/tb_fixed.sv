`timescale 1ns/1ps

module tb_fixed;

    localparam int TOTAL_DATA_SIZE = 12;

    logic clk = 0;
    logic rst_n = 0;
    logic start;

    logic done;
    logic [7:0] transfer_addr;
    logic [7:0] transfer_size;

    logic [TOTAL_DATA_SIZE-1:0] seen;

    dma_fixed dut (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .done(done),
        .transfer_addr(transfer_addr),
        .transfer_size(transfer_size)
    );

    always #5 clk = ~clk;

    initial begin
        start = 0;
        seen = '0;

        #12;
        rst_n = 1;
        start = 1;

        while (!done) begin
            @(posedge clk);
            #1;

            if (transfer_size != 0) begin

                int transaction_addr;

                // Recover the address used for the
                // transaction that just completed.
                //
                // The fixed design advances by actual_size,
                // so the previous address is:
                transaction_addr =
                    transfer_addr - transfer_size;

                $display(
                    "FIXED: address=%0d size=%0d",
                    transaction_addr,
                    transfer_size
                );

                for (int i = 0; i < transfer_size; i++) begin
                    if ((transaction_addr + i) < TOTAL_DATA_SIZE)
                        seen[transaction_addr + i] = 1'b1;
                end
            end
        end

        #1;

        $display("");
        $display("Fixed transfer coverage:");

        for (int i = 0; i < TOTAL_DATA_SIZE; i++) begin
            $display(
                "byte %0d: %s",
                i,
                seen[i] ? "TRANSFERRED" : "MISSING"
            );
        end

        // Every byte must have been transferred.
        for (int i = 0; i < TOTAL_DATA_SIZE; i++) begin
            if (!seen[i])
                $fatal(
                    1,
                    "FAIL: byte %0d was not transferred",
                    i
                );
        end

        $display("");
        $display("PASS: all 12 bytes were transferred.");

        $finish;
    end

endmodule
