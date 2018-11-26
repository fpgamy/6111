`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Updated 8/12/2018 V2.lab5c
// Create Date: 10/1/2015 V1.0
// Design Name:
// Module Name: labkit
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

`define INSIDE(pixel_x, pixel_y, region_x, region_y, region_w, region_h) \
      (((pixel_x > region_x) & (pixel_x < (region_x + region_w))) & ((pixel_y > region_y) & (pixel_y < (region_y + region_h))))

module labkit(
   input CLK100MHZ,
   input[15:0] SW,
   input BTNC, BTNU, BTNL, BTNR, BTND,
   output[3:0] VGA_R,
   output[3:0] VGA_B,
   output[3:0] VGA_G,
   input[7:0] JB,
   output VGA_HS,
   output VGA_VS,
   output LED16_B, LED16_G, LED16_R,
   output LED17_B, LED17_G, LED17_R,
   output[15:0] LED,
   output[7:0] SEG,  // segments A-G (0-6), DP (7)
   output[7:0] AN    // Display 0-7
   );


// create 25mhz system clock for XVGA timing
    clk_wiz_0_clk_wiz clkdivider(.clk_in1(CLK100MHZ), .clk_out1(clock_25mhz));


//  instantiate 7-segment display;
    wire [31:0] data;
    wire [6:0] segments;
    display_8hex display(.clk(clock_25mhz),.data(data), .seg(segments), .strobe(AN));
    assign SEG[6:0] = segments;
    assign SEG[7] = 1'b1;

//////////////////////////////////////////////////////////////////////////////////
//
//  modify these lines as needed and insert your lab here

    assign LED = SW;
    //assign JB[7:0] = 8'b0;
    assign data = {28'h0123456, SW[3:0]};   // display 0123456 + SW
    assign LED16_R = BTNL;                  // left button -> red led
    assign LED16_G = BTNC;                  // center button -> green led
    assign LED16_B = BTNR;                  // right button -> blue led
    assign LED17_R = BTNL;
    assign LED17_G = BTNC;
    assign LED17_B = BTNR;

    wire [10:0] hcount;
    wire [9:0] vcount;
    wire hsync, vsync, at_display_area;
    xvga xvga1(.vclock(clock_25mhz),.hcount(hcount),.vcount(vcount),
          .hsync(hsync),.vsync(vsync),.blank(blank));
    wire [11:0] rgb;   // rgb is 12 bits

    wire border = (hcount==0 | hcount==1023 | vcount==0 | vcount==767 |
                   hcount == 512 | vcount == 384);

    wire [23:0] pixel;

    assign rgb = SW[0] ? {12{border}} : {{4{hcount[7]}}, {4{hcount[6]}}, {4{hcount[5]}}};

// the following lines are required for the Nexys4 VGA circuit
    assign VGA_R = ~blank ? rgb[11:8]: 0;
    assign VGA_G = ~blank ? rgb[7:4] : 0;
    assign VGA_B = ~blank ? rgb[3:0] : 0;

    synchronize syn1 (.clk(clock_25mhz), .in(hsync), .out(hsync2));
    synchronize syn2 (.clk(clock_25mhz), .in(vsync), .out(vsync2));

    assign VGA_HS = ~hsync2;
    assign VGA_VS = ~vsync2;
endmodule

module synchronize #(parameter NSYNC = 3)  // number of sync flops.  must be >= 2
                   (input clk,in,
                    output reg out);

  reg [NSYNC-2:0] sync;

  always @ (posedge clk)
  begin
    {out,sync} <= {sync[NSYNC-2:0],in};
  end
endmodule
