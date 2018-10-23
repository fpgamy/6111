`default_nettype none
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:53:15 10/17/2018 
// Design Name: 
// Module Name:    fir31 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
//
// 31-tap FIR filter, 8-bit signed data, 10-bit signed coefficients.
// ready is asserted whenever there is a new sample on the X input,
// the Y output should also be sampled at the same time.  Assumes at
// least 32 clocks between ready assertions.  Note that since the
// coefficients have been scaled by 2**10, so has the output (it's
// expanded from 8 bits to 18 bits).  To get an 8-bit result from the
// filter just divide by 2**10, ie, use Y[17:10].
//
///////////////////////////////////////////////////////////////////////////////

module fir31(
	input wire clock,reset,ready,
	input wire signed [7:0] x,
	output reg signed [17:0] y
	);
	// When ready is asserted, increment the offset and store the incoming data at sample[offset]. 
	// Set both the accumulator and index to 0.
	// Over the next 31 system clock cycles (@ 27MHz) compute coeff[index] * sample[offset-index], 
	// add the result to the accumulator, and increment the index. 
	// Remember to declare coeff and the sample memory as signed so that the multiply operation is performed correctly.
	// When index reaches 31, it's done and the accumulator contains the desired filter output! 
	// Now the module just waits until ready is asserted again and starts over.
	reg signed [7:0] sample_buff [30:0];
	reg signed [17:0] acc;
	reg [4:0] offset = 0;
	reg [4:0] ind = 0;
	reg ready_prev;

	always @(posedge clock) 
	begin
		ready_prev <= ready;
	end

	// for now just pass data through
	always @(posedge clock) 
	begin
		if (reset)
		begin
			sample_buff[1]  <= 8'sb0;
			sample_buff[2]  <= 8'sb0;
			sample_buff[3]  <= 8'sb0;
			sample_buff[4]  <= 8'sb0;
			sample_buff[5]  <= 8'sb0;
			sample_buff[6]  <= 8'sb0;
			sample_buff[7]  <= 8'sb0;
			sample_buff[8]  <= 8'sb0;
			sample_buff[9]  <= 8'sb0;
			sample_buff[10] <= 8'sb0;
			sample_buff[11] <= 8'sb0;
			sample_buff[12] <= 8'sb0;
			sample_buff[13] <= 8'sb0;
			sample_buff[14] <= 8'sb0;
			sample_buff[15] <= 8'sb0;
			sample_buff[16] <= 8'sb0;
			sample_buff[17] <= 8'sb0;
			sample_buff[18] <= 8'sb0;
			sample_buff[19] <= 8'sb0;
			sample_buff[20] <= 8'sb0;
			sample_buff[21] <= 8'sb0;
			sample_buff[22] <= 8'sb0;
			sample_buff[23] <= 8'sb0;
			sample_buff[24] <= 8'sb0;
			sample_buff[25] <= 8'sb0;
			sample_buff[26] <= 8'sb0;
			sample_buff[27] <= 8'sb0;
			sample_buff[28] <= 8'sb0;
			sample_buff[29] <= 8'sb0;
			sample_buff[30] <= 8'sb0;
			sample_buff[31] <= 8'sb0;
			offset <= 0;
			acc <= 0;
			ind <= 0;
		end
		if ((~ready_prev) & ready)
		begin
			acc <= 0;
			ind <= 0;
			offset <= offset + 1;
			sample_buff[offset] <= x;
		end
		else
		begin
			acc <= acc + sample_buff[offset-ind-1]*coeffs31(ind);
			y <= acc;
			if (~&ind)
			begin
				ind <= ind + 1;
			end
		end
	end

	function signed [9:0] coeffs31;
	input [4:0] index;
	begin
		case (index)
			5'd0:  coeffs31 = -10'sd1;
			5'd1:  coeffs31 = -10'sd1;
			5'd2:  coeffs31 = -10'sd3;
			5'd3:  coeffs31 = -10'sd5;
			5'd4:  coeffs31 = -10'sd6;
			5'd5:  coeffs31 = -10'sd7;
			5'd6:  coeffs31 = -10'sd5;
			5'd7:  coeffs31 = 10'sd0;
			5'd8:  coeffs31 = 10'sd10;
			5'd9:  coeffs31 = 10'sd26;
			5'd10: coeffs31 = 10'sd46;
			5'd11: coeffs31 = 10'sd69;
			5'd12: coeffs31 = 10'sd91;
			5'd13: coeffs31 = 10'sd110;
			5'd14: coeffs31 = 10'sd123;
			5'd15: coeffs31 = 10'sd128;
			5'd16: coeffs31 = 10'sd123;
			5'd17: coeffs31 = 10'sd110;
			5'd18: coeffs31 = 10'sd91;
			5'd19: coeffs31 = 10'sd69;
			5'd20: coeffs31 = 10'sd46;
			5'd21: coeffs31 = 10'sd26;
			5'd22: coeffs31 = 10'sd10;
			5'd23: coeffs31 = 10'sd0;
			5'd24: coeffs31 = -10'sd5;
			5'd25: coeffs31 = -10'sd7;
			5'd26: coeffs31 = -10'sd6;
			5'd27: coeffs31 = -10'sd5;
			5'd28: coeffs31 = -10'sd3;
			5'd29: coeffs31 = -10'sd1;
			5'd30: coeffs31 = -10'sd1;
			default: coeffs31 = 10'hXXX;
		endcase
	end
	endfunction

endmodule
