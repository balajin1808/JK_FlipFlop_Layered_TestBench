// Monitor layer: samples the applied inputs and DUT outputs after the
// DUT's nonblocking assignments have settled at the rising clock edge.
module tb_monitor (
    input  logic clk,
    input  logic rst_n,
    input  logic valid,
    input  logic j,
    input  logic k,
    input  logic q,
    input  logic q_bar,
    output logic mon_valid,
    output logic mon_j,
    output logic mon_k,
    output logic mon_q,
    output logic mon_q_bar
);

    initial begin
        mon_valid = 1'b0;
        mon_j     = 1'b0;
        mon_k     = 1'b0;
        mon_q     = 1'b0;
        mon_q_bar = 1'b1;
    end

    always @(posedge clk) begin
        #1;
        if (!rst_n) begin
            mon_valid = 1'b0;
            mon_j     = 1'b0;
            mon_k     = 1'b0;
            mon_q     = 1'b0;
            mon_q_bar = 1'b1;
        end else begin
            mon_valid = valid;
            mon_j     = j;
            mon_k     = k;
            mon_q     = q;
            mon_q_bar = q_bar;
        end
    end

endmodule
