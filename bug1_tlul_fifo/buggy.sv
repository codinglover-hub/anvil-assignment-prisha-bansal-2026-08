module tlul_fifo_buggy (
    input  logic        is_access_ack_data_i,
    input  logic [31:0] data_i,
    input  logic [6:0]  data_intg_i,
    output logic [31:0] data_o,
    output logic [6:0]  data_intg_o
);
    always_comb begin
        data_o      = is_access_ack_data_i ? data_i : 32'b0;
        data_intg_o = data_intg_i;
    end
endmodule
