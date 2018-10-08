module convolutional_encoder_tb;
	localparam DONE_COUNT = 48;
	
	reg         clk   = 1'b0;
	reg         start = 1'b0;
	reg         data  = 1'b0;
	wire        done;
	wire [95:0] fec;

	convolutional_encoder ce1(
								.clk_in    (clk),
								.start_in  (start),
								.data_in   (data),
								.done_out  (done),
								.fec_out   (fec)
								);

	reg [DONE_COUNT-1:0] data_sr = 48'h03010203303A;
	reg                  started = 1'b0;

	initial
	begin
		$dumpfile("test.vcd");
		$dumpvars(0, convolutional_encoder_tb);
		start   = 1;
		#10;
		start   = 1;
		#500;
		start   = 0;
		#10;
		$finish;
	end

	always @(posedge clk) 
	begin
		if (start | started)
		begin
			started <= 1'b1;
			data    <= data_sr[DONE_COUNT-1];
			data_sr <= {data_sr[DONE_COUNT-2:0], 1'b0};
		end
	end

	always #5 clk = ~clk;
endmodule