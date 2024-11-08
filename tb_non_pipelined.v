`timescale 1ns / 1ps
`include "non_pipelined.v"

module tb_non_pipelined;

    // Inputs
    reg [3:0] inp1;    // 4-bit input 1
    reg [3:0] inp2;    // 4-bit input 2

    // Outputs
    wire [7:0] out;    // 8-bit output (product)

    // Instantiate the Unit Under Test (UUT)
    non_pipelined uut (
        .inp1(inp1), 
        .inp2(inp2), 
        .out(out)
    );

    // Test sequence
    initial begin
        // Test case 1: 3 * 2
        inp1 = 4'b0011; // 3
        inp2 = 4'b0010; // 2
        #10; // Wait for 10 ns
        $display("Time: %0dns | Test 1: %d * %d = %d", $time, inp1, inp2, out); // Expect 6

        // Test case 2: 5 * 7
        inp1 = 4'b0101; // 5
        inp2 = 4'b0111; // 7
        #10;
        $display("Time: %0dns | Test 2: %d * %d = %d", $time, inp1, inp2, out); // Expect 35

        // Test case 3: 9 * 9
        inp1 = 4'b1001; // 9
        inp2 = 4'b1001; // 9
        #10;
        $display("Time: %0dns | Test 3: %d * %d = %d", $time, inp1, inp2, out); // Expect 81

        // Test case 4: 15 * 15
        inp1 = 4'b1111; // 15
        inp2 = 4'b1111; // 15
        #10;
        $display("Time: %0dns | Test 4: %d * %d = %d", $time, inp1, inp2, out); // Expect 225

        // Test case 5: 8 * 8
        inp1 = 4'b1000; // 8
        inp2 = 4'b1000; // 8
        #10;
        $display("Time: %0dns | Test 5: %d * %d = %d", $time, inp1, inp2, out); // Expect 64

        // Test case 6: 12 * 5
        inp1 = 4'b1100; // 12
        inp2 = 4'b0101; // 5
        #10;
        $display("Time: %0dns | Test 6: %d * %d = %d", $time, inp1, inp2, out); // Expect 60

        // End of simulation
        $finish;
    end

endmodule
