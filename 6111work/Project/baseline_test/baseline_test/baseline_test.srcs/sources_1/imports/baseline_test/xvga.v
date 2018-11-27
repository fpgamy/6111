`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/02/2015 02:05:19 AM; comments added 7/24/2018
// Design Name: 
// Module Name: xvga
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Revision:
// Revision 1.0 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
// xvga: Generate XVGA display signals (1024 x 768 @ 60Hz)
// vga: 640x480 verilog is also included by commented out
//
////////////////////////////////////////////////////////////////////////////////


module xvga(input vclock,
            output reg [9:0] hcount,    // pixel number on current line
            output reg [9:0] vcount,	 // line number
            output reg vsync,hsync,
            output reg blank);

   // horizontal: 800 pixels total
   // display 640 pixels per line
   reg hblank,vblank;
   wire hsyncon,hsyncoff,hreset,hblankon;
   assign hblankon = (hcount == 639);    
   assign hsyncon = (hcount == 655);
   assign hsyncoff = (hcount == 751);
   assign hreset = (hcount == 799);

   // vertical: 525 lines total
   // display 480 lines
   wire vsyncon,vsyncoff,vreset,vblankon;
   assign vblankon = hreset & (vcount == 479);    
   assign vsyncon = hreset & (vcount == 489);
   assign vsyncoff = hreset & (vcount == 491);
   assign vreset = hreset & (vcount == 524);

   // sync and blanking
   wire next_hblank,next_vblank;
   assign next_hblank = hreset ? 0 : hblankon ? 1 : hblank;
   assign next_vblank = vreset ? 0 : vblankon ? 1 : vblank;
   always @(posedge vclock) begin
      hcount <= hreset ? 0 : hcount + 1;
      hblank <= next_hblank;
      hsync <= hsyncon ? 0 : hsyncoff ? 1 : hsync;  // active low

      vcount <= hreset ? (vreset ? 0 : vcount + 1) : vcount;
      vblank <= next_vblank;
      vsync <= vsyncon ? 0 : vsyncoff ? 1 : vsync;  // active low

      blank <= next_vblank | (next_hblank & ~hreset);
   end
   
endmodule
