`include "combinational_array_multiplier.v"
`timescale 1ns / 1ps

module testbench;

// Inputs
reg a_i;
reg x_i;
reg Sum_in;
reg Carry_in;

// Outputs
wire Sum_out;
wire Carry_out;

// Instantiate the combinational_array_multiplier module
combinational_array_multiplier uut (
    .a_i(a_i),
    .x_i(x_i),
    .Sum_in(Sum_in),
    .Carry_in(Carry_in),
    .Sum_out(Sum_out),
    .Carry_out(Carry_out)
);

// Test procedure
initial begin
    // Display header
    $display("a_i x_i Sum_in Carry_in | Sum_out Carry_out");
    $display("----------------------|-------------------");

    // Apply test vectors
    a_i = 0; x_i = 0; Sum_in = 0; Carry_in = 0;
    #10 $display("%b   %b     %b      %b      |    %b       %b", a_i, x_i, Sum_in, Carry_in, Sum_out, Carry_out);

    a_i = 0; x_i = 1; Sum_in = 0; Carry_in = 0;
    #10 $display("%b   %b     %b      %b      |    %b       %b", a_i, x_i, Sum_in, Carry_in, Sum_out, Carry_out);

    a_i = 1; x_i = 0; Sum_in = 0; Carry_in = 0;
    #10 $display("%b   %b     %b      %b      |    %b       %b", a_i, x_i, Sum_in, Carry_in, Sum_out, Carry_out);

    a_i = 1; x_i = 1; Sum_in = 0; Carry_in = 0;
    #10 $display("%b   %b     %b      %b      |    %b       %b", a_i, x_i, Sum_in, Carry_in, Sum_out, Carry_out);

    a_i = 1; x_i = 1; Sum_in = 1; Carry_in = 0;
    #10 $display("%b   %b     %b      %b      |    %b       %b", a_i, x_i, Sum_in, Carry_in, Sum_out, Carry_out);

    a_i = 1; x_i = 1; Sum_in = 1; Carry_in = 1;
    #10 $display("%b   %b     %b      %b      |    %b       %b", a_i, x_i, Sum_in, Carry_in, Sum_out, Carry_out);

    // End simulation
    $finish;
end

endmodule
