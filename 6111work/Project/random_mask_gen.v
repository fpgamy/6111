module random_mask_gen	(
							clk_in,
							reset_in,
							mask_1_to_2_out,
							mask_1_to_3_out,
							mask_1_to_4_out,
							mask_1_to_5_out,
							mask_1_to_6_out,
							mask_1_to_7_out,
							mask_1_to_8_out,
							mask_1_to_9_out
						);
	input clk_in;
	input reset_in;
	output [8:0] mask_1_to_2_out;
	output [8:0] mask_1_to_3_out;
	output [8:0] mask_1_to_4_out;
	output [8:0] mask_1_to_5_out;
	output [8:0] mask_1_to_6_out;
	output [8:0] mask_1_to_7_out;
	output [8:0] mask_1_to_8_out;
	output [8:0] mask_1_to_9_out;

	// INCLUDES
	//
	`include "soduku_lib.v"

	wire [3:0] rand_1_to_2;
	wire [3:0] rand_1_to_3;
	wire [3:0] rand_1_to_4;
	wire [3:0] rand_1_to_5;
	wire [3:0] rand_1_to_6;
	wire [3:0] rand_1_to_7;
	wire [3:0] rand_1_to_8;
	wire [3:0] rand_1_to_9;

	assign mask_1_to_2_out = one_hot(rand_1_to_2);
	assign mask_1_to_3_out = one_hot(rand_1_to_3);
	assign mask_1_to_4_out = one_hot(rand_1_to_4);
	assign mask_1_to_5_out = one_hot(rand_1_to_5);
	assign mask_1_to_6_out = one_hot(rand_1_to_6);
	assign mask_1_to_7_out = one_hot(rand_1_to_7);
	assign mask_1_to_8_out = one_hot(rand_1_to_8);
	assign mask_1_to_9_out = one_hot(rand_1_to_9);

	crc_rand_num_gen r1 (
							.clk_in    (clk_in)  ,
							.reset_in  (reset_in),
							.rand_1_to_2_out(rand_1_to_2),
							.rand_1_to_3_out(rand_1_to_3),
							.rand_1_to_4_out(rand_1_to_4),
							.rand_1_to_5_out(rand_1_to_5),
							.rand_1_to_6_out(rand_1_to_6),
							.rand_1_to_7_out(rand_1_to_7),
							.rand_1_to_8_out(rand_1_to_8),
							.rand_1_to_9_out(rand_1_to_9)
						);
endmodule