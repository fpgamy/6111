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

	wire     [47:0] fec_input_intermediate;

	reg      [31:0] data_shift_reg = 32'b0;

	reg       [5:0] cycle_count_out = 0;
	wire    [179:0] msg_for_the_ta;

	assign msg_for_the_ta = 180'h073032108111118101032121111117032071105109046;
	assign fsm_state_out  = msg_for_the_ta;

	crc crc1(
				.clk_in(clk_in),
				.start_in(start_in),
				.data_in(data_in),
				.done_out(done_out),
				.r_out(crc)
			);

	assign fec_input_intermediate = {data_shift_reg, crc};

	fec f1  (
				.data_in(fec_input_intermediate),
				.fec_out(fec_out)
			);

	reg start_in_prev = 1'b0;
	always @(posedge clk_in or posedge start_in) 
	begin
		start_in_prev <= start_in;
		if (start_in & ~start_in_prev) 
		begin
			cycle_count_out <= 6'b0;
			data_shift_reg  <= 32'b0;	
		end
		else 
		begin
			cycle_count_out <= cycle_count_out + 1;
			data_shift_reg  <= {data_shift_reg[30:0], data_in};			
		end
	end

endmodule

`include "crc.v"
`include "fec.v"
