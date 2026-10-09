`timescale 1ns/1ps

module tb_buggy;

    localparam int TOTAL_DATA_SIZE = 12;

    logic clk = 0;
    logic rst_n = 0;
    logic start;

    logic done;
    logic [7:0] transfer_addr;
    logic [7:0] transfer_size;

    logic [TOTAL_DATA_SIZE-1:0] seen;

    dma_buggy dut (
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

            // The DUT has already updated its outputs,
            // so reconstruct the transaction that occurred
            // on this clock edge.

            if (transfer_size != 0) begin

                // transfer_addr currently points to the NEXT
                // transaction. Recover the address used for
                // the transaction that just completed.
                int transaction_addr;

                transaction_addr =
                    transfer_addr - 4;

                $display(
                    "BUGGY: address=%0d size=%0d",
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
        $display("Buggy transfer coverage:");

        for (int i = 0; i < TOTAL_DATA_SIZE; i++) begin
            $display(
                "byte %0d: %s",
                i,
                seen[i] ? "TRANSFERRED" : "MISSING"
            );
        end

        if (!seen[6] && !seen[7]) begin
            $display("");
            $display("BUG REPRODUCED");
            $display("Bytes 6 and 7 were skipped.");
        end
        else begin
            $fatal(
                1,
                "Expected bytes 6 and 7 to be skipped."
            );
        end

        $finish;
    end

endmodule
