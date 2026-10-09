module tb_fixed;
    logic is_access_ack_data_i;
    logic [31:0] data_i, data_o;
    logic [6:0] data_intg_i, data_intg_o;

    tlul_fifo_fixed dut(.*);

    function automatic logic [6:0] reported_ecc(input logic [31:0] data);
        case (data)
            32'h42032080: reported_ecc = 7'h45;
            32'h00000000: reported_ecc = 7'h2A;
            default:      reported_ecc = 7'hxx;
        endcase
    endfunction

    initial begin
        is_access_ack_data_i = 1'b0;
        data_i = 32'h42032080;
        data_intg_i = 7'h45;
        #1;

        if (data_o !== data_i || data_intg_o !== data_intg_i)
            $fatal(1, "Fixed model failed to preserve response pair");
        if (data_intg_o !== reported_ecc(data_o))
            $fatal(1, "Fixed model produced invalid data/integrity pair");

        $display("PASS: response data and integrity remain consistent");
        $finish;
    end
endmodule
