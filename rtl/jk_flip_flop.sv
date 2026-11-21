// JK flip-flop with an active-low asynchronous reset.
module jk_flip_flop (
    input  logic clk,
    input  logic rst_n,
    input  logic j,
    input  logic k,
    output logic q,
    output logic q_bar
);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            q <= 1'b0;
        end else begin
            case ({j, k})
                2'b00: q <= q;       // Hold
                2'b01: q <= 1'b0;    // Reset
                2'b10: q <= 1'b1;    // Set
                2'b11: q <= ~q;      // Toggle
                default: q <= 1'b0;
            endcase
        end
    end

    assign q_bar = ~q;

endmodule
