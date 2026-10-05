module dma_buggy #(
    parameter int TOTAL_DATA_SIZE = 12,
    parameter int CHUNK_DATA_SIZE = 6,
    parameter int TRANSFER_WIDTH  = 4
) (
    input  logic       clk,
    input  logic       rst_n,
    input  logic       start,

    output logic       done,
    output logic [7:0] transfer_addr,
    output logic [7:0] transfer_size
);

    logic [7:0] total_count;
    logic [7:0] chunk_count;

    logic [7:0] remaining_total;
    logic [7:0] remaining_chunk;
    logic [7:0] actual_size;

    always_comb begin
        remaining_total = TOTAL_DATA_SIZE - total_count;
        remaining_chunk = CHUNK_DATA_SIZE - chunk_count;

        if (remaining_total < remaining_chunk)
            actual_size = remaining_total;
        else
            actual_size = remaining_chunk;

        if (actual_size > TRANSFER_WIDTH)
            actual_size = TRANSFER_WIDTH;
    end

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            total_count  <= 0;
            chunk_count  <= 0;
            transfer_addr <= 0;
            transfer_size <= 0;
            done <= 0;
        end
        else if (start && !done) begin

            transfer_size <= actual_size;

            // BUG:
            // Address advances by the fixed transfer width
            // even when the final transaction contains fewer bytes.
            transfer_addr <= transfer_addr + TRANSFER_WIDTH;

            total_count <= total_count + actual_size;

            if (chunk_count + actual_size >= CHUNK_DATA_SIZE)
                chunk_count <= 0;
            else
                chunk_count <= chunk_count + actual_size;

            if (total_count + actual_size >= TOTAL_DATA_SIZE)
                done <= 1;
        end
    end

endmodule
