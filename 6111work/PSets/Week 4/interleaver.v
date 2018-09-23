module interleaver(
	input  [7:0] byte0,
	input  [7:0] byte1,
	input  [7:0] byte2,
	input  [7:0] byte3,
	output [7:0] out0,
	output [7:0] out1,
	output [7:0] out2,
	output [7:0] out3
	);
	
	assign out0 = { byte3[1], byte3[0], byte2[1], byte2[0], byte1[1], byte1[0], byte0[1], byte0[0] };
	assign out1 = { byte3[3], byte3[2], byte2[3], byte2[2], byte1[3], byte1[2], byte0[3], byte0[2] };
	assign out2 = { byte3[5], byte3[4], byte2[5], byte2[4], byte1[5], byte1[4], byte0[5], byte0[4] };
	assign out3 = { byte3[7], byte3[6], byte2[7], byte2[6], byte1[7], byte1[6], byte0[7], byte0[6] };

endmodule

// Note they are the same!
module deinterleaver(
	input  [7:0] byte0,
	input  [7:0] byte1,
	input  [7:0] byte2,
	input  [7:0] byte3,
	output [7:0] out0,
	output [7:0] out1,
	output [7:0] out2,
	output [7:0] out3
	);
	
	assign out0 = { byte3[1], byte3[0], byte2[1], byte2[0], byte1[1], byte1[0], byte0[1], byte0[0] };
	assign out1 = { byte3[3], byte3[2], byte2[3], byte2[2], byte1[3], byte1[2], byte0[3], byte0[2] };
	assign out2 = { byte3[5], byte3[4], byte2[5], byte2[4], byte1[5], byte1[4], byte0[5], byte0[4] };
	assign out3 = { byte3[7], byte3[6], byte2[7], byte2[6], byte1[7], byte1[6], byte0[7], byte0[6] };

endmodule