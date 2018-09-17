module problem1_tb;
	wire  [7:0] byte0;
	wire  [7:0] byte1;
	wire  [7:0] byte2;
	wire  [7:0] byte3;
	wire  [7:0] out0;
	wire  [7:0] out1;
	wire  [7:0] out2;
	wire  [7:0] out3;

	assign byte0 = 8'h00;
	assign byte1 = 8'h0E;
	assign byte2 = 8'h8C;
	assign byte3 = 8'h03;

	interleaver i1 (
						.byte0(byte0),
						.byte1(byte1),
						.byte2(byte2),
						.byte3(byte3),
						.out0(out0),
						.out1(out1),
						.out2(out2),
						.out3(out3)
					);

	initial
	begin
	    $dumpfile("test.vcd");
		$dumpvars(0,problem1_tb);
		#10;
	end

endmodule