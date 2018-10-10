module convolutional_encoder_tb;
	// This is the count value which we start decrementing from 
	// After 48 input cycles we are done
	localparam DONE_COUNT = 48;
	// This is the clock
	reg         clk   = 1'b0;
	// This is the start signal
	reg         start = 1'b0;
	// This is the data signal
	reg         data  = 1'b0;
	// This is the done output signal
	wire        done;
	// This is the output of the FEC encoder
	wire [95:0] fec;
	// This is the instantiation of the FEC encoder
	convolutional_encoder ce1(
								.clk_in    (clk),
								.start_in  (start),
								.data_in   (data),
								.done_out  (done),
								.fec_out   (fec)
								);
	// This is the input test data
	reg [DONE_COUNT-1:0] data_sr = 48'h03010203303A;
	// This ensures that we haven't started yet, so do not 
	// shift data in
	reg                  started = 1'b0;

	// alonzi
	initial
	begin
		// This is so we can plot stuff in vcd viewer
		$dumpfile("test.vcd");
		// This is so we can see all the signals
		$dumpvars(0, convolutional_encoder_tb);
		// This tells the dut to start
		start   = 0;
		#10;
		start   = 1;
		// This is some delay so we get some output
		#500;
		// This is to deassert and make sure the 
		// output stays fixed
		start   = 0;
		#10;
		// bye bye
		$finish;
	end

	// This is the always block where we shift in the cereal data 
	always @(posedge clk) 
	begin
		// if we start or have started
		if ( (~done) & (start | started))
		begin
			// This is so we know next clock tick that we have started
			started <= 1'b1;
			// This puts the cereal into out encoder
			data    <= data_sr[DONE_COUNT-1];
			// This makes the cereal data
			data_sr <= {data_sr[DONE_COUNT-2:0], 1'b0};
		end
	end
	// This is how we clock
	always #5 clk = ~clk;
endmodule