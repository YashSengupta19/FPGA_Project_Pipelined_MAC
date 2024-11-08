//`include "combinational_array_multiplier.v"
//`include "half_adder.v"
//`include "full_adder.v"
`timescale 1ns / 1ps

module pipelined_MAC(
	input clk, reset
);

wire  [3:0] a;
wire  [3:0] y;

wire [9:0] out;

// Defining the reg files
reg a3_initial, a2_initial, a1_initial, a0_initial;
reg y3_initial, y2_initial, y1_initial, y0_initial;

reg L11_a3, L12_a2, L13_a1, L14_a0;
reg L11_sum, L12_sum, L13_sum, L14_sum;
reg L11_carry, L12_carry, L13_carry, L14_carry;
reg L15_y1, L16_y2, L17_y3;

reg L21_a3, L22_a2, L23_a1, L24_a0;
reg L21_sum, L22_sum, L23_sum, L24_sum;
reg L21_carry, L22_carry, L23_carry, L24_carry;
reg L26_y2, L27_y3;

reg L31_a3, L32_a2, L33_a1, L34_a0;
reg L31_sum, L32_sum, L33_sum, L34_sum;
reg L31_carry, L32_carry, L33_carry, L34_carry;
reg L37_y3;

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


reg propagate_p0_1, propagate_p0_2, propagate_p0_3, propagate_p0_4, propagate_p0_5;

reg propagate_p1_1, propagate_p1_2, propagate_p1_3, propagate_p1_4;

reg propagate_p2_1, propagate_p2_2, propagate_p2_3;

reg propagate_p3_1, propagate_p3_2;

reg propagate_p4_1;

reg P5, P4, P3, P2, P1, P0;

reg ena, wea;
reg [3:0] addr;

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

assign out[4] = P0;
assign out[5] = P1;
assign out[6] = P2;
assign out[7] = P3;
assign out[8] = P4;
assign out[9] = P5;
assign out[3] = 1'b0;
assign out[2] = 1'b0;
assign out[1] = 1'b0;
assign out[0] = 1'b0;

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
            a3_initial <= 0;
            a2_initial <= 0;
            a1_initial <= 0;
            a0_initial <= 0;
            
            y3_initial <= 0;
            y2_initial <= 0;
            y1_initial <= 0;
            y0_initial <= 0;
            
        end
        else
        begin
            a3_initial <= a[3];
            a2_initial <= a[2];
            a1_initial <= a[1];
            a0_initial <= a[0];
            
            y3_initial <= y[3];
            y2_initial <= y[2];
            y1_initial <= y[1];
            y0_initial <= y[0];
        end
    end
// Stage 1
wire sum1_1, sum2_1, sum3_1, sum4_1;
wire carry1_1, carry2_1, carry3_1, carry4_1;
combinational_array_multiplier CAM_11(.a_i(a[3]), .x_i(y[0]), .Sum_in(1'b0), .Carry_in(1'b0), .Sum_out(sum1_1), .Carry_out(carry1_1));
combinational_array_multiplier CAM_12(.a_i(a[2]), .x_i(y[0]), .Sum_in(1'b0), .Carry_in(1'b0), .Sum_out(sum2_1), .Carry_out(carry2_1));
combinational_array_multiplier CAM_13(.a_i(a[1]), .x_i(y[0]), .Sum_in(1'b0), .Carry_in(1'b0), .Sum_out(sum3_1), .Carry_out(carry3_1));
combinational_array_multiplier CAM_14(.a_i(a[0]), .x_i(y[0]), .Sum_in(1'b0), .Carry_in(1'b0), .Sum_out(sum4_1), .Carry_out(carry4_1));
always @(posedge clk)
	begin		

		if (reset == 1)
		begin
			L11_sum <= 1'b0;
			L12_sum <= 1'b0;
			L13_sum <= 1'b0;
			L14_sum <= 1'b0;
			L11_carry <= 1'b0;
			L12_carry <= 1'b0;
			L13_carry <= 1'b0;
			L14_carry <= 1'b0;
			L15_y1 <= 1'b0;
			L16_y2 <= 1'b0;
			L17_y3 <= 1'b0;
			L11_a3 <= 1'b0;
			L12_a2 <= 1'b0;
			L13_a1 <= 1'b0;
			L14_a0 <= 1'b0;
		end

		else
		begin
			L11_sum <= sum1_1;
			L12_sum <= sum2_1;
			L13_sum <= sum3_1;
			L14_sum <= sum4_1;
			L11_carry <= carry1_1;
			L12_carry <= carry2_1;
			L13_carry <= carry3_1;
			L14_carry <= carry4_1;
			L15_y1 <= y1_initial;
			L16_y2 <= y2_initial;
			L17_y3 <= y3_initial;
			L11_a3 <= a3_initial;
			L12_a2 <= a2_initial;
			L13_a1 <= a1_initial;
			L14_a0 <= a0_initial;
		end	
	end

// Stage 2
wire sum1_2, sum2_2, sum3_2, sum4_2;
wire carry1_2, carry2_2, carry3_2, carry4_2;
combinational_array_multiplier CAM_21(.a_i(L11_a3), .x_i(L15_y1), .Sum_in(1'b0), .Carry_in(1'b0), .Sum_out(sum1_2), .Carry_out(carry1_2));
combinational_array_multiplier CAM_22(.a_i(L12_a2), .x_i(L15_y1), .Sum_in(L11_sum), .Carry_in(L12_carry), .Sum_out(sum2_2), .Carry_out(carry2_2));
combinational_array_multiplier CAM_23(.a_i(L13_a1), .x_i(L15_y1), .Sum_in(L12_sum), .Carry_in(L13_carry), .Sum_out(sum3_2), .Carry_out(carry3_2));
combinational_array_multiplier CAM_24(.a_i(L14_a0), .x_i(L15_y1), .Sum_in(L13_sum), .Carry_in(L14_carry), .Sum_out(sum4_2), .Carry_out(carry4_2));
always @(posedge clk)
	begin
		if (reset == 1)
		begin
			L21_sum <= 1'b0;
			L22_sum <= 1'b0;
			L23_sum <= 1'b0;
			L24_sum <= 1'b0;
			L21_carry <= 1'b0;
			L22_carry <= 1'b0;
			L23_carry <= 1'b0;
			L24_carry <= 1'b0;
			L26_y2 <= 1'b0;
			L27_y3 <= 1'b0;
			L21_a3 <= 1'b0;
			L22_a2 <= 1'b0;
			L23_a1 <= 1'b0;
			L24_a0 <= 1'b0;
		end

		else
		begin
			L21_sum <= sum1_2;
			L22_sum <= sum2_2;
			L23_sum <= sum3_2;
			L24_sum <= sum4_2;
			L21_carry <= carry1_2;
			L22_carry <= carry2_2;
			L23_carry <= carry3_2;
			L24_carry <= carry4_2;
			L26_y2 <= L16_y2;
			L27_y3 <= L17_y3;
			L21_a3 <= L11_a3;
			L22_a2 <= L12_a2;
			L23_a1 <= L13_a1;
			L24_a0 <= L14_a0;
		end
	end

 // Stage 3
wire sum1_3, sum2_3, sum3_3, sum4_3;
wire carry1_3, carry2_3, carry3_3, carry4_3;
combinational_array_multiplier CAM_31(.a_i(L21_a3), .x_i(L26_y2), .Sum_in(1'b0), .Carry_in(1'b0), .Sum_out(sum1_3), .Carry_out(carry1_3));
combinational_array_multiplier CAM_32(.a_i(L22_a2), .x_i(L26_y2), .Sum_in(L21_sum), .Carry_in(L22_carry), .Sum_out(sum2_3), .Carry_out(carry2_3));
combinational_array_multiplier CAM_33(.a_i(L23_a1), .x_i(L26_y2), .Sum_in(L22_sum), .Carry_in(L23_carry), .Sum_out(sum3_3), .Carry_out(carry3_3));
combinational_array_multiplier CAM_34(.a_i(L24_a0), .x_i(L26_y2), .Sum_in(L23_sum), .Carry_in(L24_carry), .Sum_out(sum4_3), .Carry_out(carry4_3));

always @(posedge clk)
    	begin
        	if (reset == 1)
		begin
			L31_sum <= 1'b0;
        	L32_sum <= 1'b0;
        	L33_sum <= 1'b0;
        	L34_sum <= 1'b0;
        	L31_carry <= 1'b0;
        	L32_carry <= 1'b0;
        	L33_carry <= 1'b0;
        	L34_carry <= 1'b0;
        	L37_y3 <= 1'b0;

        	L31_a3 <= 1'b0;
        	L32_a2 <= 1'b0;
        	L33_a1 <= 1'b0;
        	L34_a0 <= 1'b0;
		end

		else
		begin
			L31_sum <= sum1_3;
        	L32_sum <= sum2_3;
        	L33_sum <= sum3_3;
        	L34_sum <= sum4_3;
        	L31_carry <= carry1_3;
        	L32_carry <= carry2_3;
        	L33_carry <= carry3_3;
        	L34_carry <= carry4_3;
        	L37_y3 <= L27_y3;

        	L31_a3 <= L21_a3;
        	L32_a2 <= L22_a2;
        	L33_a1 <= L23_a1;
        	L34_a0 <= L24_a0;
		end
    	end

// Stage 4
wire sum1_4, sum2_4, sum3_4, sum4_4;
wire carry1_4, carry2_4, carry3_4, carry4_4;
combinational_array_multiplier CAM_41(.a_i(L31_a3), .x_i(L37_y3), .Sum_in(1'b0), .Carry_in(1'b0), .Sum_out(sum1_4), .Carry_out(carry1_4));
combinational_array_multiplier CAM_42(.a_i(L32_a2), .x_i(L37_y3), .Sum_in(L31_sum), .Carry_in(L32_carry), .Sum_out(sum2_4), .Carry_out(carry2_4));
combinational_array_multiplier CAM_43(.a_i(L33_a1), .x_i(L37_y3), .Sum_in(L32_sum), .Carry_in(L33_carry), .Sum_out(sum3_4), .Carry_out(carry3_4));
combinational_array_multiplier CAM_44(.a_i(L34_a0), .x_i(L37_y3), .Sum_in(L33_sum), .Carry_in(L34_carry), .Sum_out(sum4_4), .Carry_out(carry4_4));

always @(posedge clk)
	begin
		if (reset == 1)
		begin
			L41_sum <= 1'b0;
        	L42_sum <= 1'b0;
        	L43_sum <= 1'b0;
        	L44_sum <= 1'b0;
        	L41_carry <= 1'b0;
       		L42_carry <= 1'b0;
        	L43_carry <= 1'b0;
        	L44_carry <= 1'b0;
		end

		else
		begin
			L41_sum <= sum1_4;
        	L42_sum <= sum2_4;
        	L43_sum <= sum3_4;
        	L44_sum <= sum4_4;
        	L41_carry <= carry1_4;
       		L42_carry <= carry2_4;
        	L43_carry <= carry3_4;
        	L44_carry <= carry4_4;
		end	
    	end
    

// Stage 5
wire sum1_5, sum2_5, sum3_5;
wire carry1_5, carry2_5, carry3_5;
half_adder HA51(.A(L41_sum), .B(L42_carry), .S(sum1_5), .C(carry1_5));
half_adder HA52(.A(L42_sum), .B(L43_carry), .S(sum2_5), .C(carry2_5));
half_adder HA53(.A(L43_sum), .B(L44_carry), .S(sum3_5), .C(carry3_5));

always @(posedge clk)
	begin
		if (reset == 1)
		begin
			L51_sum <= 1'b0;
			L52_sum <= 1'b0;
			L53_sum <= 1'b0;
			L51_carry <= 1'b0;
			L52_carry <= 1'b0;
			L53_carry <= 1'b0;
		end

		else
		begin
			L51_sum <= sum1_5;
			L52_sum <= sum2_5;
			L53_sum <= sum3_5;
			
			L51_carry <= carry1_5;
			L52_carry <= carry2_5;
			L53_carry <= carry3_5;
		end
	end

// Stage 6
wire sum1_6, sum2_6, sum3_6, sum4_6;
wire carry1_6, carry2_6, carry3_6, carry4_6;
half_adder HA61(.A(1'b0), .B(L51_carry), .S(sum1_6), .C(carry1_6));
half_adder HA62(.A(L51_sum), .B(L52_carry), .S(sum2_6), .C(carry2_6));
half_adder HA63(.A(L52_sum), .B(L53_carry), .S(sum3_6), .C(carry3_6));
half_adder HA64(.A(L53_sum), .B(propagate_p0_1), .S(sum4_6), .C(carry4_6));
always @(posedge clk)
	begin
		if (reset == 1)
		begin
			L61_sum <= 1'b0;
			L62_sum <= 1'b0;
			L63_sum <= 1'b0;
			propagate_p0_1 <= 1'b0;
			L61_carry <= 1'b0;
			L62_carry <= 1'b0;
			L63_carry <= 1'b0;
			L64_carry <= 1'b0;
		end

		else
		begin
			L61_sum <= sum1_6;
			L62_sum <= sum2_6;
			L63_sum <= sum3_6;
			propagate_p0_1 <= sum4_6;
			L61_carry <= carry1_6;
			L62_carry <= carry2_6;
			L63_carry <= carry3_6;
			L64_carry <= carry4_6;
		end
	end
	
// Stage 7
wire sum1_7, sum2_7, sum3_7;
wire carry1_7, carry2_7, carry3_7;
full_adder FA71(.A(L63_sum), .B(propagate_p1_1), .Cin(L64_carry), .S(sum3_7), .Cout(carry3_7));
half_adder HA71(.A(L61_sum), .B(L62_carry), .S(sum1_7), .C(carry1_7));
half_adder HA72(.A(L62_sum), .B(L63_carry), .S(sum2_7), .C(carry2_7));

always @(posedge clk)
	begin
		if (reset == 1)
		begin
			L71_sum <= 1'b0;
			L72_sum <= 1'b0;
			propagate_p1_1 <= 1'b0;
			L71_carry <= 1'b0;
			L72_carry <= 1'b0;
			L73_carry <= 1'b0;
			propagate_p0_2 <= 1'b0;
		end

		else
		begin
			L71_sum <= sum1_7;
			L72_sum <= sum2_7;
			propagate_p1_1 <= sum3_7;
			L71_carry <= carry1_7;
			L72_carry <= carry2_7;
			L73_carry <= carry3_7;
			propagate_p0_2 <= propagate_p0_1;
		end
	end

// Stage 8
wire sum1_8, sum2_8, sum3_8;
wire carry1_8, carry2_8, carry3_8;
full_adder FA81(.A(L72_sum), .B(propagate_p2_1), .Cin(L73_carry), .S(sum3_8), .Cout(carry3_8));
half_adder HA81(.A(1'b0), .B(L71_carry), .S(sum1_8), .C(carry1_8));
half_adder HA82(.A(L71_sum), .B(L72_carry), .S(sum2_8), .C(carry2_8));

always @(posedge clk)
    begin
        if (reset == 1)
		begin
			L81_sum <= 1'b0;
			L82_sum <= 1'b0;
			propagate_p2_1 <= 1'b0;
			L81_carry <= 1'b0;
			L82_carry <= 1'b0;
			L83_carry <= 1'b0;
			propagate_p0_3 <= 1'b0;
			propagate_p1_2 <= 1'b0;
		end

		else
		begin
			L81_sum <= sum1_8;
			L82_sum <= sum2_8;
			propagate_p2_1 <= sum3_8;
			L81_carry <= carry1_8;
			L82_carry <= carry2_8;
			L83_carry <= carry3_8;
			propagate_p0_3 <= propagate_p0_2;
			propagate_p1_2 <= propagate_p1_1;
		end
        
    end

// Stage 9
wire sum1_9, sum2_9;
wire carry1_9, carry2_9;
half_adder HA91(.A(L81_sum), .B(L82_carry), .S(sum1_9), .C(carry1_9));
full_adder FA91(.A(L82_sum), .B(propagate_p3_1), .Cin(L83_carry), .S(sum2_9), .Cout(carry2_9));

always @(posedge clk)
    begin
        if (reset == 1)
		begin
			L91_sum <= 1'b0;
			propagate_p3_1 <= 1'b0;
			L91_carry <= 1'b0;
			L92_carry <= 1'b0;
			propagate_p0_4 <= 1'b0;
			propagate_p1_3 <= 1'b0;
			propagate_p2_2 <= 1'b0;
		end

		else
		begin
			L91_sum <= sum1_9;
			propagate_p3_1 <= sum2_9;
			L91_carry <= carry1_9;
			L92_carry <= carry2_9;
			propagate_p0_4 <= propagate_p0_3;
			propagate_p1_3 <= propagate_p1_2;
			propagate_p2_2 <= propagate_p2_1;
		end
    end
 
// Stage 10
wire sum1_10, sum2_10;
wire carry1_10, carry2_10;
half_adder HA101(.A(L91_carry), .B(1'b0), .S(sum1_10), .C(carry1_10));
full_adder FA101(.A(L91_sum), .B(propagate_p4_1), .Cin(L92_carry), .S(sum2_10), .Cout(carry2_10));

always @(posedge clk)
    begin
        if (reset == 1)
		begin
			L101_sum <= 1'b0;
			propagate_p4_1 <= 1'b0;
			L101_carry <= 1'b0;
			L102_carry <= 1'b0;
			propagate_p0_5 <= 1'b0;
			propagate_p1_4 <= 1'b0;
			propagate_p2_3 <= 1'b0;
			propagate_p3_2 <= 1'b0;
		end

		else
		begin
			L101_sum <= sum1_10;
			propagate_p4_1 <= sum2_10;
			L101_carry <= carry1_10;
			L102_carry <= carry2_10;
			propagate_p0_5 <= propagate_p0_4;
			propagate_p1_4 <= propagate_p1_3;
			propagate_p2_3 <= propagate_p2_2;
			propagate_p3_2 <= propagate_p3_1;
		end
    end


 
// Stage 11:
wire sum1_11;
wire carry1_11;
full_adder FA111(.A(L101_sum), .B(P5), .Cin(L102_carry), .S(sum1_11), .Cout(carry1_11));

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
			P0 <= propagate_p0_5;
			P1 <= propagate_p1_4;
			P2 <= propagate_p2_3;
			P3 <= propagate_p3_2;
			P4 <= propagate_p4_1;
			P5 <= sum1_11;
		end
        
    end
endmodule