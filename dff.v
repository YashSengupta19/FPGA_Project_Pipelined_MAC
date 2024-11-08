`timescale 1ns / 1ps

module d_ff (
    input clk,           // Clock signal
    input reset,         // Reset signal
    input d,             // Data input
    output reg q         // Data output
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 1'b0;
        else
            q <= d;
    end
endmodule
