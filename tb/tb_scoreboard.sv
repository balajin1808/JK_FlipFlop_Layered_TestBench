// Scoreboard layer: maintains a reference model and checks every sampled
// output against the expected JK flip-flop behavior.
module tb_scoreboard (
    input  logic clk,
    input  logic rst_n,
    input  logic mon_valid,
    input  logic mon_j,
    input  logic mon_k,
    input  logic mon_q,
    input  logic mon_q_bar,
    output integer checks
);

    logic expected_q;

    initial begin
        expected_q = 1'b0;
        checks     = 0;
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            expected_q = 1'b0;
        end else begin
            // Monitor samples at +1 time unit; check after that sample arrives.
            #2;

            if (mon_valid) begin
                case ({mon_j, mon_k})
                    2'b00: expected_q = expected_q;
                    2'b01: expected_q = 1'b0;
                    2'b10: expected_q = 1'b1;
                    2'b11: expected_q = ~expected_q;
                    default: expected_q = 1'b0;
                endcase
            end

            checks = checks + 1;

            if (mon_q !== expected_q) begin
                $display("[SCOREBOARD] ERROR: J=%0b K=%0b expected Q=%0b, got Q=%0b at time %0t",
                         mon_j, mon_k, expected_q, mon_q, $time);
                $fatal(1, "JK flip-flop Q mismatch");
            end

            if (mon_q_bar !== ~expected_q) begin
                $display("[SCOREBOARD] ERROR: expected Q_bar=%0b, got Q_bar=%0b at time %0t",
                         ~expected_q, mon_q_bar, $time);
                $fatal(1, "JK flip-flop Q_bar mismatch");
            end
        end
    end

endmodule
