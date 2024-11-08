//`include "combinational_array_multiplier.v"
//`include "half_adder.v"
//`include "full_adder.v"
`timescale 1ns / 1ps

module pipelined_MAC(
	input clk, reset
//	output [5:0] out
);

wire  [2:0] a;
wire  [2:0] y;

wire [5:0] out;

// Defining the reg files
reg a2_initial, a1_initial, a0_initial;
reg y2_initial, y1_initial, y0_initial;

reg L11_a2, L12_a1, L13_a0;
reg L11_sum, L12_sum, L13_sum;
reg L11_carry, L12_carry, L13_carry;
reg L14_y1, L15_y2;

reg L21_a2, L22_a1, L23_a0;
reg L21_sum, L22_sum, L23_sum;
reg L21_carry, L22_carry, L23_carry;
reg L25_y2;

reg L31_sum, L32_sum, L33_sum;
reg L31_carry, L32_carry, L33_carry;

reg L41_sum, L42_sum, L43_sum, L44_sum;
reg L41_carry, L42_carry, L43_carry, L44_carry;

reg L51_sum, L52_sum, L53_sum;
reg L51_carry, L52_carry, L53_carry;

reg L61_sum, L62_sum, L63_sum, L64_sum;
reg L61_carry, L62_carry, L63_carry, L64_carry;

reg L71_sum, L72_sum;
reg L71_carry, L72_carry, L73_carry;

reg L81_sum, L82_sum;
reg L81_carry, L82_carry, L83_carry;

reg L91_sum;
reg L91_carry, L92_carry;

reg L101_sum;
reg L101_carry, L102_carry;


reg propagate_p0_1, propagate_p0_2, propagate_p0_3, propagate_p0_4, propagate_p0_5, propagate_p0_6;

reg propagate_p1_1, propagate_p1_2, propagate_p1_3, propagate_p1_4, propagate_p1_5;

reg propagate_p2_1, propagate_p2_2, propagate_p2_3, propagate_p2_4;

reg propagate_p3_1, propagate_p3_2, propagate_p3_3;

reg propagate_p4_1, propagate_p4_2;

reg propagate_p5_1;

reg P5, P4, P3, P2, P1, P0;

reg ena, wea;
reg [3:0] addr;

// Defining the temorary registers for exact multiplier
//reg propagate_u0_1, propagate_u0_2, propagate_u0_3, propagate_u0_4, propagate_u0_5, propagate_u0_6, propagate_u0_7, propagate_u0_8, propagate_u0_9, propagate_u0_10;
//reg propagate_u1_1, propagate_u1_2, propagate_u1_3, propagate_u1_4, propagate_u1_5, propagate_u1_6, propagate_u1_7, propagate_u1_8, propagate_u1_9;
//reg propagate_u2_1, propagate_u2_2, propagate_u2_3, propagate_u2_4, propagate_u2_5, propagate_u2_6, propagate_u2_7, propagate_u2_8;
//reg propagate_u3_1, propagate_u3_2, propagate_u3_3, propagate_u3_4, propagate_u3_5, propagate_u3_6, propagate_u3_7;
//reg U3, U2, U1, U0;


blk_mem_gen_0 a_i (
  .clka(clk),    // input wire clka
  .ena(ena),      // input wire ena
  .wea(wea),      // input wire [0 : 0] wea
  .addra(addr),  // input wire [3 : 0] addra
  .dina(),    // input wire [3 : 0] dina
  .douta(a)  // output wire [3 : 0] douta
);

blk_mem_gen_1 x_i (
  .clka(clk),    // input wire clka
  .ena(ena),      // input wire ena
  .wea(wea),      // input wire [0 : 0] wea
  .addra(addr),  // input wire [3 : 0] addra
  .dina(),    // input wire [3 : 0] dina
  .douta(y)  // output wire [3 : 0] douta
);

ila_0 your_instance_name (
	.clk(clk), // input wire clk


	.probe0(reset), // input wire [0:0]  probe0  
	.probe1(a), // input wire [3:0]  probe1 
	.probe2(y), // input wire [3:0]  probe2 
	.probe3(addr), // input wire [3:0]  probe3 
	.probe4(out), // input wire [9:0]  probe4
	.probe5(L13_carry), // input wire [0:0]  probe5 
	.probe6(L23_carry), // input wire [0:0]  probe6 
	.probe7(L33_carry), // input wire [0:0]  probe7 
	.probe8(L43_carry), // input wire [0:0]  probe8 
	.probe9(L53_sum), // input wire [0:0]  probe9 
	.probe10(L43_sum) // input wire [0:0]  probe10
);

assign out[5] = P5;
assign out[4] = P4;
assign out[3] = P3;
assign out[2] = P2;
assign out[1] = P1;
assign out[0] = P0;

always @(posedge clk)
    begin
        if (reset == 1)
        begin
            ena <= 1'b1;
            wea <= 1'b0;
            addr <= 4'b0000;
        end
        else
        begin
            addr <= addr + 4'b0001;
        end
    end
    
always @(posedge clk)
    begin
        if (reset == 1)
        begin
            a2_initial <= 1'b0;
            a1_initial <= 1'b0;
            a0_initial <= 1'b0;
            
            y2_initial <= 1'b0;
            y1_initial <= 1'b0;
            y0_initial <= 1'b0;
            
        end
        else
        begin
            a2_initial <= a[2];
            a1_initial <= a[1];
            a0_initial <= a[0];
            
            y2_initial <= y[2];
            y1_initial <= y[1];
            y0_initial <= y[0];
        end
    end
// Stage 1
wire sum1_1, sum2_1, sum3_1;
wire carry1_1, carry2_1, carry3_1;
combinational_array_multiplier CAM_11(.a_i(a[2]), .x_i(y[0]), .Sum_in(1'b0), .Carry_in(1'b0), .Sum_out(sum1_1), .Carry_out(carry1_1));
combinational_array_multiplier CAM_12(.a_i(a[1]), .x_i(y[0]), .Sum_in(1'b0), .Carry_in(1'b0), .Sum_out(sum2_1), .Carry_out(carry2_1));
combinational_array_multiplier CAM_13(.a_i(a[0]), .x_i(y[0]), .Sum_in(1'b0), .Carry_in(1'b0), .Sum_out(sum3_1), .Carry_out(carry3_1));
always @(posedge clk)
	begin		

		if (reset == 1)
		begin
			L11_sum <= 1'b0;
			L12_sum <= 1'b0;
			
			propagate_p0_1 <= 1'b0;
			
			L11_carry <= 1'b0;
			L12_carry <= 1'b0;
			L13_carry <= 1'b0;

			L14_y1 <= 1'b0;
			L15_y2 <= 1'b0;
			
			L11_a2 <= 1'b0;
			L12_a1 <= 1'b0;
			L13_a0 <= 1'b0;
			
		end

		else
		begin
			L11_sum <= sum1_1;
			L12_sum <= sum2_1;
			
			propagate_p0_1 <= sum3_1;
			
			L11_carry <= carry1_1;
			L12_carry <= carry2_1;
			L13_carry <= carry3_1;

			L14_y1 <= y[1];
			L15_y2 <= y[2];


			L11_a2 <= a[2];
			L12_a1 <= a[1];
			L13_a0 <= a[0];
		end	
	end

// Stage 2
wire sum1_2, sum2_2, sum3_2;
wire carry1_2, carry2_2, carry3_2;
combinational_array_multiplier CAM_21(.a_i(L11_a2), .x_i(L14_y1), .Sum_in(1'b0), .Carry_in(1'b0), .Sum_out(sum1_2), .Carry_out(carry1_2));
combinational_array_multiplier CAM_22(.a_i(L12_a1), .x_i(L14_y1), .Sum_in(L11_sum), .Carry_in(L12_carry), .Sum_out(sum2_2), .Carry_out(carry2_2));
combinational_array_multiplier CAM_23(.a_i(L13_a0), .x_i(L14_y1), .Sum_in(L12_sum), .Carry_in(L13_carry), .Sum_out(sum3_2), .Carry_out(carry3_2));
always @(posedge clk)
	begin
		if (reset == 1)
		begin
			L21_sum <= 1'b0;
			L22_sum <= 1'b0;
			
			propagate_p0_2 <= 1'b0;
			propagate_p1_1 <= 1'b0;

			
			L21_carry <= 1'b0;
			L22_carry <= 1'b0;
			L23_carry <= 1'b0;
			
			L25_y2 <= 1'b0;
			
			L21_a2 <= 1'b0;
			L22_a1 <= 1'b0;
			L23_a0 <= 1'b0;

		end

		else
		begin
			L21_sum <= sum1_2;
			L22_sum <= sum2_2;

			propagate_p0_2 <= propagate_p0_1;
			propagate_p1_1 <= sum3_2;
			
			L21_carry <= carry1_2;
			L22_carry <= carry2_2;
			L23_carry <= carry3_2;
			
			L25_y2 <= L15_y2;

			L21_a2 <= L11_a2;
			L22_a1 <= L12_a1;
			L23_a0 <= L13_a0;
		end
	end

 // Stage 3
wire sum1_3, sum2_3, sum3_3;
wire carry1_3, carry2_3, carry3_3;
combinational_array_multiplier CAM_31(.a_i(L21_a2), .x_i(L25_y2), .Sum_in(1'b0), .Carry_in(1'b0), .Sum_out(sum1_3), .Carry_out(carry1_3));
combinational_array_multiplier CAM_32(.a_i(L22_a1), .x_i(L25_y2), .Sum_in(L21_sum), .Carry_in(L22_carry), .Sum_out(sum2_3), .Carry_out(carry2_3));
combinational_array_multiplier CAM_33(.a_i(L23_a0), .x_i(L25_y2), .Sum_in(L22_sum), .Carry_in(L23_carry), .Sum_out(sum3_3), .Carry_out(carry3_3));

always @(posedge clk)
    	begin
        	if (reset == 1)
		begin
			L31_sum <= 1'b0;
        	L32_sum <= 1'b0;

            propagate_p0_3 <= 1'b0;
            propagate_p1_2 <= 1'b0;
            propagate_p2_1 <= 1'b0;
        	
        	L31_carry <= 1'b0;
        	L32_carry <= 1'b0;
        	L33_carry <= 1'b0;

		end

		else
		begin
			L31_sum <= sum1_3;
        	L32_sum <= sum2_3;
        	
        	propagate_p0_3 <= propagate_p0_2;
            propagate_p1_2 <= propagate_p1_1;
            propagate_p2_1 <= sum3_3;
        	
        	L31_carry <= carry1_3;
        	L32_carry <= carry2_3;
        	L33_carry <= carry3_3;


		end
    	end

// Stage 4
wire sum1_4, sum2_4;
wire carry1_4, carry2_4;
half_adder HA41(.A(L31_sum), .B(L32_carry), .S(sum1_4), .C(carry1_4));
half_adder HA42(.A(L32_sum), .B(L33_carry), .S(sum2_4), .C(carry2_4));


always @(posedge clk)
	begin
		if (reset == 1)
		begin
			L41_sum <= 1'b0;
			
			propagate_p0_4 <= 1'b0;
            propagate_p1_3 <= 1'b0;
            propagate_p2_2 <= 1'b0;
            propagate_p3_1 <= 1'b0;

			L41_carry <= 1'b0;
			L42_carry <= 1'b0;
		end

		else
		begin
			L41_sum <= sum1_4;
			
			propagate_p0_4 <= propagate_p0_3;
            propagate_p1_3 <= propagate_p1_2;
            propagate_p2_2 <= propagate_p2_1;
            propagate_p3_1 <= sum2_4;
			
			L41_carry <= carry1_4;
			L42_carry <= carry2_4;

		end
	end

// Stage 5
wire sum1_5, sum2_5;
wire carry1_5, carry2_5;
half_adder HA51(.A(1'b0), .B(L41_carry), .S(sum1_5), .C(carry1_5));
half_adder HA52(.A(L41_sum), .B(L42_carry), .S(sum2_5), .C(carry2_5));

always @(posedge clk)
	begin
		if (reset == 1)
		begin
		    
		    L51_sum <= 1'b0;
		    L52_carry <= 1'b0;
		    
			propagate_p0_5 <= 1'b0;
            propagate_p1_4 <= 1'b0;
            propagate_p2_3 <= 1'b0;
            propagate_p3_2 <= 1'b0;
            propagate_p4_1 <= 1'b0;


		end

		else
		begin
			L51_sum <= sum1_5;
			L52_carry <= carry2_5;
			
			propagate_p0_5 <= propagate_p0_4;
            propagate_p1_4 <= propagate_p1_3;
            propagate_p2_3 <= propagate_p2_2;
            propagate_p3_2 <= propagate_p3_1;
            propagate_p4_1 <= sum2_5;
            
		end
	end
	
// Stage 6
half_adder HA61(.A(L51_sum), .B(L52_carry), .S(sum1_6), .C(carry1_6));

always @(posedge clk)
	begin
		if (reset == 1)
		begin
		    
			propagate_p0_6 <= 1'b0;
            propagate_p1_5 <= 1'b0;
            propagate_p2_4 <= 1'b0;
            propagate_p3_3 <= 1'b0;
            propagate_p4_2 <= 1'b0;
            propagate_p5_1 <= 1'b0;

		end

		else
		begin

			
			propagate_p0_6 <= propagate_p0_5;
            propagate_p1_5 <= propagate_p1_4;
            propagate_p2_4 <= propagate_p2_3;
            propagate_p3_3 <= propagate_p3_2;
            propagate_p4_2 <= propagate_p4_1;
            propagate_p5_1 <= sum1_6;
            
		end
	end
	
 
// Stage 7:
always @(posedge clk)
    begin
        if (reset == 1)
		begin
			P0 <= 1'b0;
			P1 <= 1'b0;
			P2 <= 1'b0;
			P3 <= 1'b0;
			P4 <= 1'b0;
			P5 <= 1'b0;

		end

		else
		begin
			// Final output assignment
			P0 <= propagate_p0_6;
			P1 <= propagate_p1_5;
			P2 <= propagate_p2_4;
			P3 <= propagate_p3_3;
			P4 <= propagate_p4_2;
			P5 <= propagate_p5_1;
		end
        
    end
endmodule
