module non_pipelined_test(
    input wire clk,
    input wire ena, 
    output[8:0] out
);
    // 4-bit inputs for the non-pipelined multiplier
    reg [3:0] inp1, inp2;
    reg [7:0] out;

    // Memory interface wires for BRAMs
    reg [2:0] addr;           // Address counter for BRAMs
    wire [3:0] b1, b2;        // Outputs from BRAMs

    // Instantiating blk_mem_gen modules for BRAMs
    blk_mem_gen_0 br1 (
        .clka(clk),
        .ena(ena),
        .wea(1'b0),            // Read-only mode
        .addra(addr),
        .dina(4'b0000),        // Unused in read mode
        .douta(b1)
    );

    blk_mem_gen_1 br2 (
        .clka(clk),
        .ena(ena),
        .wea(1'b0),            // Read-only mode
        .addra(addr),
        .dina(4'b0000),        // Unused in read mode
        .douta(b2)
    );

//    ila_0 your_instance_name (
//        .clk(clk),             // input wire clk
//        .probe0(out) ,          // input wire [7:0] probe0
//        .probe1(inp1), // input wire [3:0]  probe1 
//	    .probe2(inp2) // input wire [3:0]  probe2
//    );

    // Non-pipelined multiplier module code
    wire [3:0] pp0, pp1, pp2, pp3;       // Partial products
    wire [7:0] sum1, sum2, sum3;         // Sums for each addition stage
    wire [7:0] carry1, carry2, carry3;   // Carry bits for each stage

    // Generate partial products
    assign pp0 = inp1 & {4{inp2[0]}};
    assign pp1 = inp1 & {4{inp2[1]}};
    assign pp2 = inp1 & {4{inp2[2]}};
    assign pp3 = inp1 & {4{inp2[3]}};

    // Stage 1: Add pp0 and pp1 shifted by 1 bit
    assign sum1 = {pp1, 1'b0} + {4'b0, pp0};
    assign carry1 = (sum1 & {pp1, 1'b0}) | (sum1 & {4'b0, pp0}) | ({pp1, 1'b0} & {4'b0, pp0});

    // Stage 2: Add the result of stage 1 (sum1) and pp2 shifted by 2 bits
    assign sum2 = {pp2, 2'b00} + sum1;
    assign carry2 = (sum2 & {pp2, 2'b00}) | (sum2 & sum1) | ({pp2, 2'b00} & sum1);

    // Stage 3: Add the result of stage 2 (sum2) and pp3 shifted by 3 bits
    assign sum3 = {pp3, 3'b000} + sum2;
    assign carry3 = (sum3 & {pp3, 3'b000}) | (sum3 & sum2) | ({pp3, 3'b000} & sum2);

    // Final output (product)
    wire [7:0] product = sum3;

    // Sequential block to cycle through BRAM values and calculate the product
    always @(posedge clk) begin
        if (ena) begin
            // Read inputs from BRAMs
            inp1 <= b1;
            inp2 <= b2;

            // Only update `out` with `product` when `ena` is active
            out <= product;

            // Increment address for next read cycle, wrapping around if needed
            addr <= (addr == 3'b100) ? 3'b000 : addr + 1;  // Adjust wrap-around based on BRAM depth
        end
    end
endmodule
