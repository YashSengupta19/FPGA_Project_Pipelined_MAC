`timescale 1ns / 1ps

module combinational_array_multiplier (
    input a_i,         // Single-bit input from multiplier
    input x_i,         // Single-bit input from multiplicand
    input Sum_in,      // Sum input from previous full adder
    input Carry_in,    // Carry input from previous full adder
    output Sum_out,    // Sum output
    output Carry_out   // Carry output
);

    wire mul;

    // Multiply bits (this is equivalent to AND for single-bit inputs)
    assign mul = a_i & x_i; 
    
    // Full Adder Logic: Type 0 full adder
    assign Sum_out = mul ^ Sum_in ^ Carry_in;  // Sum is XOR of mul, Sum_in, and Carry_in
    assign Carry_out = (mul & Sum_in) | (mul & Carry_in) | (Sum_in & Carry_in);  // Carry logic

endmodule
