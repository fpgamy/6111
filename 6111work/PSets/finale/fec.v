module fec 	(
				data_in,
				fec_out
			);
	// calculate the fec combinationally
	localparam DATA_WIDTH = 48;

	input	   [DATA_WIDTH - 1:0]   data_in;
	output     [(2*DATA_WIDTH-1):0] fec_out;

	wire	   [DATA_WIDTH - 1:0]   data_in_rev;
	wire       [(2*DATA_WIDTH-1):0] fec_out_rev;

	// assign the first 6 values of the fec because x[n-3] is not defined
	// do it so p[1] and p[0] are reversed as we will reverse later on
	assign fec_out_rev[1] = data_in_rev[0];
	assign fec_out_rev[0] = data_in_rev[0];

	assign fec_out_rev[3] = data_in_rev[1] ^ data_in_rev[0];
	assign fec_out_rev[2] = data_in_rev[1];

	assign fec_out_rev[5] = data_in_rev[2] ^ data_in_rev[1] ^ data_in_rev[0];
	assign fec_out_rev[4] = data_in_rev[2] ^ data_in_rev[0];

	// generate the rest of the fec
	generate
		genvar i;
		for (i = 3; i < DATA_WIDTH; i = i + 1)
		begin:fec_rev_gen
			assign fec_out_rev[2*i + 1]     = data_in_rev[i] ^ data_in_rev[i-1] ^ data_in_rev[i-2] ^ data_in_rev[i-3];
			assign fec_out_rev[2*i]         = data_in_rev[i] ^ data_in_rev[i-2] ^ data_in_rev[i-3];
		end
	endgenerate

	// reverse the fec so it is the correct endianness
	generate
		genvar j;
		for (j = 0; j < 2*DATA_WIDTH; j = j + 1)
		begin:fec_gen
			assign fec_out[j] = fec_out_rev[(2*DATA_WIDTH-1)-j];
		end
	endgenerate

	// revese the data input endianness
	generate
		genvar k;
		for (k = 0; k < DATA_WIDTH; k = k + 1)
		begin:input_rev
			assign data_in_rev[k] = data_in[(DATA_WIDTH-1)-k];		
		end
	endgenerate

endmodule