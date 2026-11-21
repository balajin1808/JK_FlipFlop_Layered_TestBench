// Environment layer: connects generator, driver, monitor, and scoreboard.
module tb_environment (
    input  logic clk,
    input  logic rst_n,
    input  logic q,
    input  logic q_bar,
    output wire  j,
    output wire  k,
    output wire  done,
    output integer checks
);

    wire gen_j;
    wire gen_k;
    wire gen_valid;
    wire driven_valid;

    wire mon_valid;
    wire mon_j;
    wire mon_k;
    wire mon_q;
    wire mon_q_bar;

    tb_generator u_generator (
        .clk       (clk),
        .rst_n     (rst_n),
        .gen_j     (gen_j),
        .gen_k     (gen_k),
        .gen_valid (gen_valid),
        .done      (done)
    );

    tb_driver u_driver (
        .gen_j     (gen_j),
        .gen_k     (gen_k),
        .gen_valid (gen_valid),
        .j         (j),
        .k         (k),
        .valid     (driven_valid)
    );

    tb_monitor u_monitor (
        .clk      (clk),
        .rst_n    (rst_n),
        .valid    (driven_valid),
        .j        (j),
        .k        (k),
        .q        (q),
        .q_bar    (q_bar),
        .mon_valid(mon_valid),
        .mon_j    (mon_j),
        .mon_k    (mon_k),
        .mon_q    (mon_q),
        .mon_q_bar(mon_q_bar)
    );

    tb_scoreboard u_scoreboard (
        .clk       (clk),
        .rst_n     (rst_n),
        .mon_valid (mon_valid),
        .mon_j     (mon_j),
        .mon_k     (mon_k),
        .mon_q     (mon_q),
        .mon_q_bar (mon_q_bar),
        .checks    (checks)
    );

endmodule
