`include "pipelined_MAC.v"
`timescale 1ns / 1ps

module tb_pipelined_MAC;

                     // Parameters
    reg  [3:0] a;    // Input a
    reg  [3:0] y;    // Input x
    reg  clk;        // Clock signal
    wire [5:0] out;  // Output

      // Internal Signals (Add all relevant internal signals here)
      // reg L11_sum, L12_sum, L13_sum, L14_sum;
      // reg L11_carry, L12_carry, L13_carry, L14_carry;
      // reg L15_y1, L16_y2, L17_y3;
      // reg L11_a3, L12_a2, L13_a1, L14_a0;

      // Instantiate the pipelined_MAC module
    pipelined_MAC uut (
        .a(a),
        .y(y),
        .clk(clk),
        .out(out)
    );

      // Clock generation
    initial begin
                clk    = 0;
        forever #5 clk = ~clk;  // 10ns clock period
    end

      // Test stimulus
    initial begin
          // Initialize inputs
        a = 4'b1001;
        y = 4'b0110;
            // Monitor signal changes
        #10 $display("Time: %d | a: %b | y: %b | L11_a3 = %b | L12_a2 = %b | L13_a1 = %b | L14_a0 = %b | L15_y1 = %b | L16_y2 = %b | L17_y3 = %b | L11_sum = %b | L12_sum = %b | L13_sum = %b | L14_sum = %b | L11_carry = %b | L12_carry = %b | L13_carry = %b | L14_carry = %b", $time, a, y, uut.L11_a3, uut.L12_a2, uut.L13_a1, uut.L14_a0, uut.L15_y1, uut.L16_y2, uut.L17_y3, uut.L11_sum, uut.L12_sum, uut.L13_sum, uut.L14_sum, uut.L11_carry, uut.L12_carry, uut.L13_carry, uut.L14_carry);
        #10 $display("Time: %d | a: %b | y: %b | L21_a3 = %b | L22_a2 = %b | L23_a1 = %b | L24_a0 = %b | L26_y2 = %b | L27_y3 = %b | L21_sum = %b | L22_sum = %b | L23_sum = %b | L24_sum = %b | L21_carry = %b | L22_carry = %b | L23_carry = %b | L24_carry = %b", $time, a, y, uut.L21_a3, uut.L22_a2, uut.L23_a1, uut.L24_a0, uut.L26_y2, uut.L27_y3, uut.L21_sum, uut.L22_sum, uut.L23_sum, uut.L24_sum, uut.L21_carry, uut.L22_carry, uut.L23_carry, uut.L24_carry);
        #10 $display("Time: %d | a: %b | y: %b | L31_a3 = %b | L32_a2 = %b | L33_a1 = %b | L34_a0 = %b | L37_y3 = %b | L31_sum = %b | L32_sum = %b | L33_sum = %b | L34_sum = %b | L31_carry = %b | L32_carry = %b | L33_carry = %b | L34_carry = %b", $time, a, y, uut.L31_a3, uut.L32_a2, uut.L33_a1, uut.L34_a0, uut.L37_y3, uut.L31_sum, uut.L32_sum, uut.L33_sum, uut.L34_sum, uut.L31_carry, uut.L32_carry, uut.L33_carry, uut.L34_carry);

          // Apply test cases
          // #200 a = 4'b0011; y = 4'b0010; // Test Case 1
          // #200 a = 4'b1010; y = 4'b0101; // Test Case 2
          // #200 a = 4'b1111; y = 4'b1111; // Test Case 3
          // #200 a = 4'b1100; y = 4'b0011; // Test Case 4
          // #200 a = 4'b0101; y = 4'b0110; // Test Case 5

          // Finish simulation
        #130 $finish;
    end

endmodule

