`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:05:24 09/16/2018 
// Design Name: 
// Module Name:    sevensegcounter 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
// toggles the seven segment counter every time button_in has a positive edger
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module counter #(
   parameter WIDTH = 4
   )
   (
    input                   tick_in,
	 input                   reset_in,
    output reg [WIDTH-1:0] count_out
    );
	 
	 always @(posedge tick_in)
	 begin
	     if (reset_in)
		  begin
		     count_out <= 0;
		  end
		  else
		  begin
	         count_out <= count_out + 1;
		  end
	 end
	 
endmodule
