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
// toggles the seven segment counter every time button_in has a positive edge
// Dependencies: 
// seven_seg_out gives active low outputs from a (MSB) to g
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module binary_to_seven_seg_decoder(
    input [3:0]      count_in,
	 input             reset_in,
    output reg [6:0] seven_seg_out,
	 output            dp
    );
	 
    localparam SEVEN_SEG_ZERO  = 7'b1111110;
    localparam SEVEN_SEG_ONE   = 7'b0110000;
    localparam SEVEN_SEG_TWO   = 7'b1101101;
    localparam SEVEN_SEG_THREE = 7'b1111001;
    localparam SEVEN_SEG_FOUR  = 7'b0110011;
    localparam SEVEN_SEG_FIVE  = 7'b1011011;
    localparam SEVEN_SEG_SIX   = 7'b1011111;
    localparam SEVEN_SEG_SEVEN = 7'b1110000;
    localparam SEVEN_SEG_EIGHT = 7'b1111111;
    localparam SEVEN_SEG_NINE  = 7'b1111011;
    localparam SEVEN_SEG_A     = 7'b1110111;
    localparam SEVEN_SEG_B     = 7'b0011111;
    localparam SEVEN_SEG_C     = 7'b0001101;
    localparam SEVEN_SEG_D     = 7'b0111101;
    localparam SEVEN_SEG_E     = 7'b1001111;
    localparam SEVEN_SEG_F     = 7'b1000111;
    localparam SEVEN_SEG_ERROR = 7'b1101111;
	 
	 assign dp = 1'b0;
	 
	 always @(*)
	 begin
		 if (reset_in)
		 begin
		    seven_seg_out = SEVEN_SEG_ZERO;
		 end
		 else
		 begin
			 case(count_in)
				 4'h0: seven_seg_out       = SEVEN_SEG_ZERO;
				 4'h1: seven_seg_out       = SEVEN_SEG_ONE;
				 4'h2: seven_seg_out       = SEVEN_SEG_TWO;
				 4'h3: seven_seg_out       = SEVEN_SEG_THREE;
				 4'h4: seven_seg_out       = SEVEN_SEG_FOUR;
				 4'h5: seven_seg_out       = SEVEN_SEG_FIVE;
				 4'h6: seven_seg_out       = SEVEN_SEG_SIX;
				 4'h7: seven_seg_out       = SEVEN_SEG_SEVEN;
				 4'h8: seven_seg_out       = SEVEN_SEG_EIGHT;
				 4'h9: seven_seg_out       = SEVEN_SEG_NINE;
				 4'ha: seven_seg_out       = SEVEN_SEG_A;
				 4'hb: seven_seg_out       = SEVEN_SEG_B;
				 4'hc: seven_seg_out       = SEVEN_SEG_C;
				 4'hd: seven_seg_out       = SEVEN_SEG_D;
				 4'he: seven_seg_out       = SEVEN_SEG_E;
				 4'hf: seven_seg_out       = SEVEN_SEG_F;
				 default: seven_seg_out    = SEVEN_SEG_ERROR;
			 endcase
		 end
	 end

endmodule
