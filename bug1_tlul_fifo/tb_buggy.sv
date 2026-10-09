module tb_buggy;
    logic is_access_ack_data_i;
    logic [31:0] data_i, data_o;
    logic [6:0] data_intg_i, data_intg_o;

    tlul_fifo_buggy dut(.*);

    // Counterexample-specific ECC values from OpenTitan issue #31187.
    // This is deliberately not a general SECDED encoder.
    function automatic logic [6:0] reported_ecc(input logic [31:0] data);
        case (data)
            32'h42032080: reported_ecc = 7'h45;
            32'h00000000: reported_ecc = 7'h2A;
            default:      reported_ecc = 7'hxx;
        endcase
    endfunction

    initial begin
        is_access_ack_data_i = 1'b0; // AccessAck response
        data_i = 32'h42032080;
        data_intg_i = 7'h45;
        #1;

        if (data_o !== 32'h00000000)
            $fatal(1, "Expected faulty mux to zero non-AccessAckData response");
        if (data_intg_o !== 7'h45)
            $fatal(1, "Expected original integrity bits to pass through");
        if (data_intg_o !== reported_ecc(data_o))
            $fatal(1, "BUG REPRODUCED: output data/integrity pair is invalid");

        $display("ERROR: expected counterexample did not occur");
        $finish;
    end
endmodule
