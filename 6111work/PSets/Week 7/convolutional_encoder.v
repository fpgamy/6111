module convolutional_encoder(
								clk_in,
								start_in,
								data_in,
								done_out,
								fec_out
							);

	input			 clk_in;
	input			 start_in;
	input			 data_in;
	output 		     done_out;
	output    [95:0] fec_out;


	localparam WIN_SIZE = 4;
	localparam DONE_COUNT = 48;

	reg [WIN_SIZE-1:0] data_in_sr = 'b0;
	reg 			   started    = 1'b0;
	reg 		[95:0] fec_out    = 96'b0;
	reg         [5:0]  counter    = DONE_COUNT;

	wire p0;
	wire p1;

	assign p0       = data_in ^ data_in_sr[0] ^ data_in_sr[1] ^ data_in_sr[2];
	assign p1       = data_in ^ data_in_sr[1] ^ data_in_sr[2];
	assign done_out = ~(|counter); 

	always @(posedge clk_in) 
	begin
		if ((~started) & start_in)
		begin
			counter    <= DONE_COUNT;
			fec_out    <= 96'b0;
			started    <= 1'b1;
			data_in_sr <= {data_in_sr[3:0], data_in};
		end
		else if (started & (~done_out))
		begin
			counter    <= counter - 1;
			fec_out    <= {fec_out[93:0], p1, p0};
			data_in_sr <= {data_in_sr[3:0], data_in};
		end
	end

endmodule