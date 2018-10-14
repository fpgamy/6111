module fec_tb;
	wire [47:0] data_input;
	wire [47:0] data_input_rev;
	wire [95:0] fec_value;
	wire [95:0] fec_value_rev;
	wire [95:0] correct_fec_value;
	wire [95:0] correct_fec_value_rev;

	assign correct_fec_value = 96'h000E8C037C0DF00E828C0E5E;
	assign data_input = 48'h03010203303A;

	generate
		genvar i;
		for (i = 0; i < 96; i = i + 1)
		begin:rev
			assign correct_fec_value_rev[i] = correct_fec_value[95-i];
		end
	endgenerate
	generate
		genvar j;
		for (j = 0; j < 48; j = j + 1)
		begin:rev_test
			assign data_input_rev[j] = data_input[47-j];
		end
	endgenerate

	fec f1(.data_in(data_input), .fec_out(fec_value));
	fec f2(.data_in(data_input_rev), .fec_out(fec_value_rev));


	initial
	begin
		$dumpfile("fec_test.vcd");
		$dumpvars(0, fec_tb);
		#50;
	end
endmodule
