// Generator layer: creates one JK input transaction per clock cycle.
module tb_generator (
    input  logic clk,
    input  logic rst_n,
    output logic gen_j,
    output logic gen_k,
    output logic gen_valid,
    output logic done
);

    task automatic send(input logic j_value, input logic k_value);
        begin
            @(negedge clk);
            gen_j     = j_value;
            gen_k     = k_value;
            gen_valid = 1'b1;
        end
    endtask

    initial begin
        gen_j     = 1'b0;
        gen_k     = 1'b0;
        gen_valid = 1'b0;
        done      = 1'b0;

        wait (rst_n === 1'b1);

        // Exercise hold, set, reset, and toggle (including repeated toggles).
        send(1'b0, 1'b0); // Hold from reset state (0)
        send(1'b1, 1'b0); // Set -> 1
        send(1'b0, 1'b0); // Hold -> 1
        send(1'b0, 1'b1); // Reset -> 0
        send(1'b1, 1'b1); // Toggle -> 1
        send(1'b1, 1'b1); // Toggle -> 0
        send(1'b1, 1'b1); // Toggle -> 1
        send(1'b1, 1'b0); // Set -> 1
        send(1'b0, 1'b1); // Reset -> 0
        send(1'b1, 1'b0); // Set -> 1
        send(1'b0, 1'b0); // Hold -> 1
        send(1'b0, 1'b1); // Reset -> 0

        @(negedge clk);
        gen_valid = 1'b0;
        done      = 1'b1;
    end

endmodule
