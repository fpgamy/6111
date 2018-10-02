`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Updated 9/29/2017 V2.0
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


module labkit(
   input CLK100MHZ,
   input[15:0] SW, 
   input BTNC, BTNU, BTNL, BTNR, BTND,
   output[3:0] VGA_R, 
   output[3:0] VGA_B, 
   output[3:0] VGA_G,
   output[7:0] JA, 
   output VGA_HS, 
   output VGA_VS, 
   output LED16_B, LED16_G, LED16_R,
   output LED17_B, LED17_G, LED17_R,
   output[15:0] LED,
   output[7:0] SEG,  // segments A-G (0-6), DP (7)
   output[7:0] AN    // Display 0-7
   );
   

// create 25mhz system clock
    wire clock_25mhz;
    clock_quarter_divider clockgen(.clk100_mhz(CLK100MHZ), .clock_25mhz(clock_25mhz));

// Once the system has been armed, opening the driver's door the system begins a countdown. If the 
// ignition is not turned on within the countdown interval (T_DRIVER_DELAY), the siren sounds. The 
// siren remains on as long as the door is open and for some additional interval (T_ALARM_ON) after
//  the door closes, at which time the system resets to the armed but silent state. If the ignition 
// is turned on within the countdown interval, the system is disarmed.

// When the passenger door is opened first, a separate, presumably longer, delay (T_PASSENGER_DELAY) 
// is used for the countdown interval

// There is a status indicator LED on the dash. It blinks with a two-second period when the system 
// is armed. It is constantly illuminated either if the system is in the countdown waiting for the 
// ignition to turn on or if the siren is on. The LED is off is the system is disarmed.

// When the ignition is off power to fuel pump is cut off. Power is only restored when first the 
// ignition is turned on and then the driver presses both a hidden switch and the brake pedal 
// simultaneously. Power is then latched on until the ignition is again turned off.

// T_ARM_DELAY = time between exiting car and arming alarm
// T_DRIVER_DELAY = length of countdown before the alarm sounds after opening the driver's door
// T_PASSENGER_DELAY = length of countdown before the alarm sounds after opening the passender's door
// T_ALARM_ON = length of time the siren sounds
endmodule

module clock_quarter_divider(input clk100_mhz, output reg clock_25mhz = 0);
    reg counter = 0;

    // VERY BAD VERILOG
    // VERY BAD VERILOG
    // VERY BAD VERILOG
    // But it's a quick and dirty way to create a 25Mhz clock
    // Please use the IP Clock Wizard under FPGA Features/Clocking
    //
    // For 1 Hz pulse, it's okay to use a counter to create the pulse as in
    // assign onehz = (counter == 100_000_000); 
    // be sure to have the right number of bits.

    always @(posedge clk100_mhz) begin
        counter <= counter + 1;
        if (counter == 0) begin
            clock_25mhz <= ~clock_25mhz;
        end
    end
endmodule

module vga(input vga_clock,
            output reg [9:0] hcount = 0,    // pixel number on current line
            output reg [9:0] vcount = 0,    // line number
            output reg vsync, hsync, 
            output at_display_area);

   // Comments applies to XVGA 1024x768, left in for reference
   // horizontal: 1344 pixels total
   // display 1024 pixels per line
   reg hblank,vblank;
   wire hsyncon,hsyncoff,hreset,hblankon;
   assign hblankon = (hcount == 639);    // active H  1023
   assign hsyncon = (hcount == 655);     // active H + FP 1047
   assign hsyncoff = (hcount == 751);    // active H + fp + sync  1183
   assign hreset = (hcount == 799);      // active H + fp + sync + bp 1343

   // vertical: 806 lines total
   // display 768 lines
   wire vsyncon,vsyncoff,vreset,vblankon;
   assign vblankon = hreset & (vcount == 479);    // active V   767
   assign vsyncon = hreset & (vcount ==490 );     // active V + fp   776
   assign vsyncoff = hreset & (vcount == 492);    // active V + fp + sync  783
   assign vreset = hreset & (vcount == 523);      // active V + fp + sync + bp 805

   // sync and blanking
   wire next_hblank,next_vblank;
   assign next_hblank = hreset ? 0 : hblankon ? 1 : hblank;
   assign next_vblank = vreset ? 0 : vblankon ? 1 : vblank;
   always @(posedge vga_clock) begin
      hcount <= hreset ? 0 : hcount + 1;
      hblank <= next_hblank;
      hsync <= hsyncon ? 0 : hsyncoff ? 1 : hsync;  // active low

      vcount <= hreset ? (vreset ? 0 : vcount + 1) : vcount;
      vblank <= next_vblank;
      vsync <= vsyncon ? 0 : vsyncoff ? 1 : vsync;  // active low

   end

   assign at_display_area = ((hcount >= 0) && (hcount < 640) && (vcount >= 0) && (vcount < 480));

endmodule

