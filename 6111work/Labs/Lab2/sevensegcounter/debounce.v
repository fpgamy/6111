`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:07:30 09/16/2018 
// Design Name: 
// Module Name:    debounce 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
// clk_in is a 27MHz input clock
// rst_in is an asyncronous reset
// raw_in is the signal to debounce
// clean_out is the debounced signal
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module debounce #(
	 parameter ACTIVE_HIGH_IN = 1
	 )
	 (
    input      clk_in,
	 input      reset_in,
    input      raw_in,
    output reg clean_out
    );
	 
	 // as clk_in is 27MHz, raw_in edges which are
	 // less than 10ms apart are bounces
	 localparam MAX_BOUNCE_DELAY = 19'd270000;
	 localparam HIGH_DELAY       = 19'd270;
	 
	 reg [18:0] count;
	 
	 always @(posedge clk_in)
	 begin
	     if (reset_in)
		  begin
		     count     <= 19'b0;
			  clean_out <= 1'b0;
		  end
		  else
		  begin
			  if (count > 19'b0)
			  begin
					if (count <= HIGH_DELAY)
					begin
						 clean_out <= 1'b1;
					end
					
					count     <= count - 1;
			  end
			  else if (raw_in == ACTIVE_HIGH_IN) // button could be pressed
			  begin
					count     <= MAX_BOUNCE_DELAY;
			  end
			  else
			  begin
				  clean_out <= 1'b0;
			  end
		  end
	 end


endmodule
