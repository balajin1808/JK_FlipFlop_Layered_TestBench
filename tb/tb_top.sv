// Test layer / simulation top.
module tb_top;

    logic clk;
    logic rst_n;
    wire j;
    wire k;
    wire q;
    wire q_bar;
    wire done;
    integer checks;

    // 10 ns clock period.
    initial clk = 1'b0;
    always #5 clk = ~clk;

    // Keep reset active initially, then release it.
    initial begin
        rst_n = 1'b0;
        #17 rst_n = 1'b1;
    end

    jk_flip_flop dut (
        .clk   (clk),
        .rst_n (rst_n),
        .j     (j),
        .k     (k),
        .q     (q),
        .q_bar (q_bar)
    );

    tb_environment env (
        .clk    (clk),
        .rst_n  (rst_n),
        .q      (q),
        .q_bar  (q_bar),
        .j      (j),
        .k      (k),
        .done   (done),
        .checks (checks)
    );

    initial begin
        wait (done === 1'b1);
        repeat (2) @(posedge clk);
        #3;
        $display("[TEST] PASS: JK flip-flop test completed successfully (%0d scoreboard checks).", checks);
        $finish;
    end

    initial begin
        #1000;
        $fatal(1, "[TEST] TIMEOUT: test did not finish.");
    end

endmodule
