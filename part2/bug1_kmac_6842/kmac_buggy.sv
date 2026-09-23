module kmac_buggy (
    input  logic clk,
    input  logic rst_n,

    input  logic cmd_start,
    input  logic cmd_process,
    input  logic cmd_done,

    // In the real bug, CmdDone can be invalid in the current state.
    input  logic cmd_valid,

    output logic [1:0] state
);

    typedef enum logic [1:0] {
        IDLE    = 2'b00,
        ABSORB  = 2'b01,
        PROCESS = 2'b10
    } state_t;

    state_t current_state;

    assign state = current_state;

    always_ff @(posedge clk or negedge rst_n) begin

        if (!rst_n) begin
            current_state <= IDLE;
        end

        else begin

            case (current_state)

                IDLE: begin
                    if (cmd_start)
                        current_state <= ABSORB;
                end

                ABSORB: begin
                    if (cmd_process)
                        current_state <= PROCESS;

                    // BUG:
                    // CmdDone is accepted even when it is invalid
                    // for the current state.
                    else if (cmd_done)
                        current_state <= IDLE;
                end

                PROCESS: begin
                    if (cmd_done)
                        current_state <= IDLE;
                end

                default: begin
                    current_state <= IDLE;
                end

            endcase

        end

    end

endmodule
