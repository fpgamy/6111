module convolutional_encoder(
								clk_in,
								start_in,
								data_in,
								done_out,
								fec_out
							);

	// This is the input clk, clk_in
	input			 clk_in;
	// This is the input start signal, start_in
	input			 start_in;
	// This is the input data signal, data_in
	// it is cereal.
	input			 data_in;
	// This is the done output signal
	output 		     done_out;
	// This is the 96 bit fec output signal 
	// given 48 bits input this block produces 2 outputs per input
	// 48 * 2 is 96
	output    [95:0] fec_out;

	// This is the local parameter window size
	localparam WIN_SIZE = 4;
	// This is the count value which we start decrementing from 
	// After 48 input cycles we are done
	localparam DONE_COUNT = 48;

	// This is the input data shift register. It is size 4 because
	// we need x[n-3]
	reg [WIN_SIZE-1:0] data_in_sr = 'b0;
	// This is the start state
	reg 			   started    = 1'b0;
	// This is the 96 bit fec output signal 
	// given 48 bits input this block produces 2 outputs per input
	// 48 * 2 is 96
	reg 		[95:0] fec_out    = 96'b0;
	// This is the counter to determine the number of bits in the shift 
	// register
	reg         [5:0]  counter    = DONE_COUNT;

	// This is a wire of P_0[n]
	wire p0;
	// This is a wire for P_1[n]
	wire p1;

	// This assigned the P_0[n] value to the value specified in the Pset
	assign p0       = data_in ^ data_in_sr[0] ^ data_in_sr[1] ^ data_in_sr[2];
	// This assigned the P_1[n] value to the value specified in the Pset
	assign p1       = data_in ^ data_in_sr[1] ^ data_in_sr[2];
	// We are done once the count hits 0
	assign done_out = ~(|counter); 

	//This is an always block so stuff is synchronous
	always @(posedge clk_in) 
	// This is the begin statement to look nice
	begin
		// This is an if statement which tells us to start if we 
		// get told to start but haven't started yet
		if ((~started) & start_in)
		// This is a begin statement to look nice
		begin
			// This is the beginning value of the counter
			counter    <= DONE_COUNT;
			// This initialised the fec_out to 0
			fec_out    <= 96'b0;
			// This tells us later that we have started
			started    <= 1'b1;
			// This is the shift in the shift register
			data_in_sr <= {data_in_sr[3:0], data_in};
			// This is an end statement for the if statement begin
		end
		// This is te check if we have started but aren't done yet
		else if (started & (~done_out))
		// This is the begin statement to look nice
		begin
			// This is the decrement of the counter
			counter    <= counter - 1;
			// This is the filling up of the fec register
			// We fill from the LSB
			fec_out    <= {fec_out[93:0], p1, p0};
			// This shifts the data into the shift register
			// We fill from the LSB
			data_in_sr <= {data_in_sr[3:0], data_in};
			// This is an end statement from the else if
		end
		// This is the end statement for the always block
	end
// This is an endmodule for the convolutional_encoder module
endmodule