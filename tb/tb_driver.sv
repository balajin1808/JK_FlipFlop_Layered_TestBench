// Driver layer: forwards the generated transaction to the DUT pins.
// Kept intentionally simple so the generator and DUT remain decoupled.
module tb_driver (
    input  wire gen_j,
    input  wire gen_k,
    input  wire gen_valid,
    output wire j,
    output wire k,
    output wire valid
);
    assign j     = gen_j;
    assign k     = gen_k;
    assign valid = gen_valid;
endmodule
