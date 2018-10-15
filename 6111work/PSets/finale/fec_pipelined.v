module fec_pipelined(clk_in, start_in, data_in, done_out, fec_out, fsm_state_out, cycle_count_out);
	input 			clk_in;
	input  			start_in;
	input  			data_in;
	output 			done_out;
	output   [95:0] fec_out;
	output 	[179:0] fsm_state_out;
	output 	  [5:0] cycle_count_out;

	localparam CRC_WIDTH = 16;

	wire     [CRC_WIDTH-1:0] crc;

	// output of the crc combined with data which will go to fec
	wire     [47:0] fec_input_intermediate;
	// shift register for data
	reg      [31:0] data_shift_reg = 32'b0;
	// counter which detemines no of clock cycles
	reg       [5:0] cycle_count_out = 0;
	// fun little easter egg
	wire    [179:0] msg_for_the_ta;

	assign msg_for_the_ta = 180'h073032108111118101032121111117032071105109046;
	// as I'm doing the fec encoding in one clock cycle, is there a state?
	assign fsm_state_out  = msg_for_the_ta;

	crc crc1(
				.clk_in(clk_in),
				.start_in(start_in),
				.data_in(data_in),
				.done_out(done_out),
				.r_out(crc)
			);

	// concatenate the bits
	assign fec_input_intermediate = {data_shift_reg, crc};

	fec f1  (
				.data_in(fec_input_intermediate),
				.fec_out(fec_out)
			);

	always @(posedge clk_in or posedge start_in) 
	begin
		if (start_in) 
		begin
			cycle_count_out <= 6'b0;
			data_shift_reg  <= 32'b0;	
		end
		else if (~done_out)
		begin
			cycle_count_out <= cycle_count_out + 1;
			data_shift_reg  <= {data_shift_reg[30:0], data_in};			
		end
	end

endmodule

`include "crc.v"
`include "fec.v"
