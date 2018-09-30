`default_nettype none
///////////////////////////////////////////////////////////////////////////////
//
// Pushbutton Debounce Module (video version - 24 bits)  
//
///////////////////////////////////////////////////////////////////////////////

module debounce (input reset, clock, noisy,
                 output reg clean);

   reg [19:0] count;
   reg new;

   always @(posedge clock)
      if (reset)
      begin
         new <= noisy; 
         clean <= noisy; 
         count <= 0; 
      end
      else if (noisy != new) 
      begin 
         new <= noisy; 
         count <= 0; 
      end
      else if (count == 650000)
      begin
         clean <= new;
      end
      else
      begin
         count <= count+1;
      end

endmodule

///////////////////////////////////////////////////////////////////////////////
//
// 6.111 FPGA Labkit -- Template Toplevel Module
//
// For Labkit Revision 004
//
//
// Created: October 31, 2004, from revision 003 file
// Author: Nathan Ickes
//
///////////////////////////////////////////////////////////////////////////////
//
// CHANGES FOR BOARD REVISION 004
//
// 1) Added signals for logic analyzer pods 2-4.
// 2) Expanded "tv_in_ycrcb" to 20 bits.
// 3) Renamed "tv_out_data" to "tv_out_i2c_data" and "tv_out_sclk" to
//    "tv_out_i2c_clock".
// 4) Reversed disp_data_in and disp_data_out signals, so that "out" is an
//    output of the FPGA, and "in" is an input.
//
// CHANGES FOR BOARD REVISION 003
//
// 1) Combined flash chip enables into a single signal, flash_ce_b.
//
// CHANGES FOR BOARD REVISION 002
//
// 1) Added SRAM clock feedback path input and output
// 2) Renamed "mousedata" to "mouse_data"
// 3) Renamed some ZBT memory signals. Parity bits are now incorporated into 
//    the data bus, and the byte write enables have been combined into the
//    4-bit ram#_bwe_b bus.
// 4) Removed the "systemace_clock" net, since the SystemACE clock is now
//    hardwired on the PCB to the oscillator.
//
///////////////////////////////////////////////////////////////////////////////
//
// Complete change history (including bug fixes)
//
// 2012-Sep-15: Converted to 24bit RGB
//
// 2005-Sep-09: Added missing default assignments to "ac97_sdata_out",
//              "disp_data_out", "analyzer[2-3]_clock" and
//              "analyzer[2-3]_data".
//
// 2005-Jan-23: Reduced flash address bus to 24 bits, to match 128Mb devices
//              actually populated on the boards. (The boards support up to
//              256Mb devices, with 25 address lines.)
//
// 2004-Oct-31: Adapted to new revision 004 board.
//
// 2004-May-01: Changed "disp_data_in" to be an output, and gave it a default
//              value. (Previous versions of this file declared this port to
//              be an input.)
//
// 2004-Apr-29: Reduced SRAM address busses to 19 bits, to match 18Mb devices
//              actually populated on the boards. (The boards support up to
//              72Mb devices, with 21 address lines.)
//
// 2004-Apr-29: Change history started
//
///////////////////////////////////////////////////////////////////////////////

module lab3   (beep, audio_reset_b, ac97_sdata_out, ac97_sdata_in, ac97_synch,
	       ac97_bit_clock,
	       
	       vga_out_red, vga_out_green, vga_out_blue, vga_out_sync_b,
	       vga_out_blank_b, vga_out_pixel_clock, vga_out_hsync,
	       vga_out_vsync,

	       tv_out_ycrcb, tv_out_reset_b, tv_out_clock, tv_out_i2c_clock,
	       tv_out_i2c_data, tv_out_pal_ntsc, tv_out_hsync_b,
	       tv_out_vsync_b, tv_out_blank_b, tv_out_subcar_reset,

	       tv_in_ycrcb, tv_in_data_valid, tv_in_line_clock1,
	       tv_in_line_clock2, tv_in_aef, tv_in_hff, tv_in_aff,
	       tv_in_i2c_clock, tv_in_i2c_data, tv_in_fifo_read,
	       tv_in_fifo_clock, tv_in_iso, tv_in_reset_b, tv_in_clock,

	       ram0_data, ram0_address, ram0_adv_ld, ram0_clk, ram0_cen_b,
	       ram0_ce_b, ram0_oe_b, ram0_we_b, ram0_bwe_b, 

	       ram1_data, ram1_address, ram1_adv_ld, ram1_clk, ram1_cen_b,
	       ram1_ce_b, ram1_oe_b, ram1_we_b, ram1_bwe_b,

	       clock_feedback_out, clock_feedback_in,

	       flash_data, flash_address, flash_ce_b, flash_oe_b, flash_we_b,
	       flash_reset_b, flash_sts, flash_byte_b,

	       rs232_txd, rs232_rxd, rs232_rts, rs232_cts,

	       mouse_clock, mouse_data, keyboard_clock, keyboard_data,

	       clock_27mhz, clock1, clock2,

	       disp_blank, disp_data_out, disp_clock, disp_rs, disp_ce_b,
	       disp_reset_b, disp_data_in,

	       button0, button1, button2, button3, button_enter, button_right,
	       button_left, button_down, button_up,

	       switch,

	       led,
	       
	       user1, user2, user3, user4,
	       
	       daughtercard,

	       systemace_data, systemace_address, systemace_ce_b,
	       systemace_we_b, systemace_oe_b, systemace_irq, systemace_mpbrdy,
	       
	       analyzer1_data, analyzer1_clock,
 	       analyzer2_data, analyzer2_clock,
 	       analyzer3_data, analyzer3_clock,
 	       analyzer4_data, analyzer4_clock);

   output beep, audio_reset_b, ac97_synch, ac97_sdata_out;
   input  ac97_bit_clock, ac97_sdata_in;
   
   output [7:0] vga_out_red, vga_out_green, vga_out_blue;
   output vga_out_sync_b, vga_out_blank_b, vga_out_pixel_clock, vga_out_hsync, vga_out_vsync;

   output [9:0] tv_out_ycrcb;
   output tv_out_reset_b, tv_out_clock, tv_out_i2c_clock, tv_out_i2c_data, tv_out_pal_ntsc, tv_out_hsync_b, tv_out_vsync_b, tv_out_blank_b, tv_out_subcar_reset;
   
   input  [19:0] tv_in_ycrcb;
   input  tv_in_data_valid, tv_in_line_clock1, tv_in_line_clock2, tv_in_aef, tv_in_hff, tv_in_aff;
   output tv_in_i2c_clock, tv_in_fifo_read, tv_in_fifo_clock, tv_in_iso, tv_in_reset_b, tv_in_clock;
   inout  tv_in_i2c_data;
        
   inout  [35:0] ram0_data;
   output [18:0] ram0_address;
   output ram0_adv_ld, ram0_clk, ram0_cen_b, ram0_ce_b, ram0_oe_b, ram0_we_b;
   output [3:0] ram0_bwe_b;
   
   inout  [35:0] ram1_data;
   output [18:0] ram1_address;
   output ram1_adv_ld, ram1_clk, ram1_cen_b, ram1_ce_b, ram1_oe_b, ram1_we_b;
   output [3:0] ram1_bwe_b;

   input  clock_feedback_in;
   output clock_feedback_out;
   
   inout  [15:0] flash_data;
   output [23:0] flash_address;
   output flash_ce_b, flash_oe_b, flash_we_b, flash_reset_b, flash_byte_b;
   input  flash_sts;
   
   output rs232_txd, rs232_rts;
   input  rs232_rxd, rs232_cts;

   input  mouse_clock, mouse_data, keyboard_clock, keyboard_data;

   input  clock_27mhz, clock1, clock2;

   output disp_blank, disp_clock, disp_rs, disp_ce_b, disp_reset_b;  
   input  disp_data_in;
   output  disp_data_out;
   
   input  button0, button1, button2, button3, button_enter, button_right, button_left, button_down, button_up;
   input  [7:0] switch;
   output [7:0] led;

   inout [31:0] user1, user2, user3, user4;
   
   inout [43:0] daughtercard;

   inout  [15:0] systemace_data;
   output [6:0]  systemace_address;
   output systemace_ce_b, systemace_we_b, systemace_oe_b;
   input  systemace_irq, systemace_mpbrdy;

   output [15:0] analyzer1_data, analyzer2_data, analyzer3_data, analyzer4_data;
   output analyzer1_clock, analyzer2_clock, analyzer3_clock, analyzer4_clock;

   ////////////////////////////////////////////////////////////////////////////
   //
   // I/O Assignments
   //
   ////////////////////////////////////////////////////////////////////////////
   
   // Audio Input and Output
   assign beep= 1'b0;
   assign audio_reset_b = 1'b0;
   assign ac97_synch = 1'b0;
   assign ac97_sdata_out = 1'b0;
   // ac97_sdata_in is an input

   // Video Output
   assign tv_out_ycrcb = 10'h0;
   assign tv_out_reset_b = 1'b0;
   assign tv_out_clock = 1'b0;
   assign tv_out_i2c_clock = 1'b0;
   assign tv_out_i2c_data = 1'b0;
   assign tv_out_pal_ntsc = 1'b0;
   assign tv_out_hsync_b = 1'b1;
   assign tv_out_vsync_b = 1'b1;
   assign tv_out_blank_b = 1'b1;
   assign tv_out_subcar_reset = 1'b0;
   
   // Video Input
   assign tv_in_i2c_clock = 1'b0;
   assign tv_in_fifo_read = 1'b0;
   assign tv_in_fifo_clock = 1'b0;
   assign tv_in_iso = 1'b0;
   assign tv_in_reset_b = 1'b0;
   assign tv_in_clock = 1'b0;
   assign tv_in_i2c_data = 1'bZ;
   // tv_in_ycrcb, tv_in_data_valid, tv_in_line_clock1, tv_in_line_clock2, 
   // tv_in_aef, tv_in_hff, and tv_in_aff are inputs
   
   // SRAMs
   assign ram0_data = 36'hZ;
   assign ram0_address = 19'h0;
   assign ram0_adv_ld = 1'b0;
   assign ram0_clk = 1'b0;
   assign ram0_cen_b = 1'b1;
   assign ram0_ce_b = 1'b1;
   assign ram0_oe_b = 1'b1;
   assign ram0_we_b = 1'b1;
   assign ram0_bwe_b = 4'hF;
   assign ram1_data = 36'hZ; 
   assign ram1_address = 19'h0;
   assign ram1_adv_ld = 1'b0;
   assign ram1_clk = 1'b0;
   assign ram1_cen_b = 1'b1;
   assign ram1_ce_b = 1'b1;
   assign ram1_oe_b = 1'b1;
   assign ram1_we_b = 1'b1;
   assign ram1_bwe_b = 4'hF;
   assign clock_feedback_out = 1'b0;
   // clock_feedback_in is an input
   
   // Flash ROM
   assign flash_data = 16'hZ;
   assign flash_address = 24'h0;
   assign flash_ce_b = 1'b1;
   assign flash_oe_b = 1'b1;
   assign flash_we_b = 1'b1;
   assign flash_reset_b = 1'b0;
   assign flash_byte_b = 1'b1;
   // flash_sts is an input

   // RS-232 Interface
   assign rs232_txd = 1'b1;
   assign rs232_rts = 1'b1;
   // rs232_rxd and rs232_cts are inputs

   // PS/2 Ports
   // mouse_clock, mouse_data, keyboard_clock, and keyboard_data are inputs

   // LED Displays
   assign disp_blank = 1'b1;
   assign disp_clock = 1'b0;
   assign disp_rs = 1'b0;
   assign disp_ce_b = 1'b1;
   assign disp_reset_b = 1'b0;
   assign disp_data_out = 1'b0;
   // disp_data_in is an input

   // Buttons, Switches, and Individual LEDs
   //lab3 assign led = 8'hFF;
   // button0, button1, button2, button3, button_enter, button_right,
   // button_left, button_down, button_up, and switches are inputs

   // User I/Os
   assign user1 = 32'hZ;
   assign user2 = 32'hZ;
   assign user3 = 32'hZ;
   assign user4 = 32'hZ;

   // Daughtercard Connectors
   assign daughtercard = 44'hZ;

   // SystemACE Microprocessor Port
   assign systemace_data = 16'hZ;
   assign systemace_address = 7'h0;
   assign systemace_ce_b = 1'b1;
   assign systemace_we_b = 1'b1;
   assign systemace_oe_b = 1'b1;
   // systemace_irq and systemace_mpbrdy are inputs

   // Logic Analyzer
   assign analyzer1_data = 16'h0;
   assign analyzer1_clock = 1'b1;
   assign analyzer2_data = 16'h0;
   assign analyzer2_clock = 1'b1;
   assign analyzer3_data = 16'h0;
   assign analyzer3_clock = 1'b1;
   assign analyzer4_data = 16'h0;
   assign analyzer4_clock = 1'b1;
			    
   ////////////////////////////////////////////////////////////////////////////
   //
   // lab3 : a simple pong game
   //
   ////////////////////////////////////////////////////////////////////////////

   // use FPGA's digital clock manager to produce a
   // 65MHz clock (actually 64.8MHz)
   wire clock_65mhz_unbuf,clock_65mhz;
   DCM vclk1(
               .CLKIN(clock_27mhz),
               .CLKFX(clock_65mhz_unbuf)
            );

   // synthesis attribute CLKFX_DIVIDE of vclk1 is 10
   // synthesis attribute CLKFX_MULTIPLY of vclk1 is 24
   // synthesis attribute CLK_FEEDBACK of vclk1 is NONE
   // synthesis attribute CLKIN_PERIOD of vclk1 is 37
   BUFG vclk2(
               .O(clock_65mhz),
               .I(clock_65mhz_unbuf)
            );

   // power-on reset generation
   wire power_on_reset;    // remain high for first 16 clocks
   SRL16 reset_sr (
                     .D(1'b0), 
                     .CLK(clock_65mhz), 
                     .Q(power_on_reset),
                     .A0(1'b1), 
                     .A1(1'b1), 
                     .A2(1'b1), 
                     .A3(1'b1)
                  );

   defparam reset_sr.INIT = 16'hFFFF;

   // ENTER button is user reset
   wire reset,user_reset;
   debounce db1(
                  .reset(power_on_reset),
                  .clock(clock_65mhz),
                  .noisy(~button_enter),
                  .clean(user_reset)
               );

   assign reset = user_reset | power_on_reset;
   
   // UP and DOWN buttons for pong paddle
   wire up,down;
   debounce db2(
                  .reset(reset),
                  .clock(clock_65mhz),
                  .noisy(~button_up),
                  .clean(up)
               );

   debounce db3(
                  .reset(reset),
                  .clock(clock_65mhz),
                  .noisy(~button_down),
                  .clean(down)
               );

   // generate basic XVGA video signals
   wire [10:0] hcount;
   wire [9:0]  vcount;
   wire hsync,vsync,blank;
   xvga xvga1(
               .vclock(clock_65mhz),
               .hcount(hcount),
               .vcount(vcount),
               .hsync(hsync),
               .vsync(vsync),
               .blank(blank)
            );

   // feed XVGA signals to user's pong game
   wire [23:0] pixel;
   wire phsync,pvsync,pblank;
   pong_game pg(
                  .vclock_in(clock_65mhz),
                  .reset_in(reset),
                  .up_in(up),
                  .down_in(down),
                  .pspeed_in(switch[7:4]),
	               .hcount_in(hcount),
                  .vcount_in(vcount),
                  .hsync_in(hsync),
                  .vsync_in(vsync),
                  .blank_in(blank),
                  .phsync_out(phsync),
                  .pvsync_out(pvsync),
                  .pblank_out(pblank),
                  .pixel_out(pixel)
               );

   // switch[1:0] selects which video generator to use:
   //  00: user's pong game
   //  01: 1 pixel outline of active video area (adjust screen controls)
   //  10: color bars
   reg [23:0] rgb;
   wire border = (hcount==0 | hcount==1023 | vcount==0 | vcount==767);
   
   reg b,hs,vs;
   always @(posedge clock_65mhz) 
   begin
      if (switch[1:0] == 2'b01) 
      begin
         // 1 pixel outline of visible area (white)
         hs <= hsync;
         vs <= vsync;
         b <= blank;
      	rgb <= {24{border}};
      end 
      else if (switch[1:0] == 2'b10) 
      begin         // color bars
         hs <= hsync;
         vs <= vsync;
         b <= blank;
         rgb <= {{8{hcount[8]}}, {8{hcount[7]}}, {8{hcount[6]}}} ;
      end
      else 
      begin
         // default: pong
         hs <= phsync;
         vs <= pvsync;
         b <= pblank;
         rgb <= pixel;
      end
   end

   // VGA Output.  In order to meet the setup and hold times of the
   // AD7125, we send it ~clock_65mhz.
   assign vga_out_red = rgb[23:16];
   assign vga_out_green = rgb[15:8];
   assign vga_out_blue = rgb[7:0];
   assign vga_out_sync_b = 1'b1;    // not used
   assign vga_out_blank_b = ~b;
   assign vga_out_pixel_clock = ~clock_65mhz;
   assign vga_out_hsync = hs;
   assign vga_out_vsync = vs;
   
   assign led = ~{3'b000,up,down,reset,switch[1:0]};

endmodule

////////////////////////////////////////////////////////////////////////////////
//
// xvga: Generate XVGA display signals (1024 x 768 @ 60Hz)
//
////////////////////////////////////////////////////////////////////////////////

module xvga(input vclock,
            output reg [10:0] hcount,    // pixel number on current line
            output reg [9:0] vcount,	 // line number
            output reg vsync,hsync,blank);

   // horizontal: 1344 pixels total
   // display 1024 pixels per line
   reg hblank,vblank;
   wire hsyncon,hsyncoff,hreset,hblankon;
   assign hblankon = (hcount == 1023);    
   assign hsyncon = (hcount == 1047);
   assign hsyncoff = (hcount == 1183);
   assign hreset = (hcount == 1343);

   // vertical: 806 lines total
   // display 768 lines
   wire vsyncon,vsyncoff,vreset,vblankon;
   assign vblankon = hreset & (vcount == 767);    
   assign vsyncon = hreset & (vcount == 776);
   assign vsyncoff = hreset & (vcount == 782);
   assign vreset = hreset & (vcount == 805);

   // sync and blanking
   wire next_hblank,next_vblank;
   assign next_hblank = hreset ? 0 : hblankon ? 1 : hblank;
   assign next_vblank = vreset ? 0 : vblankon ? 1 : vblank;
   always @(posedge vclock) 
   begin
      hcount <= hreset ? 0 : hcount + 1;
      hblank <= next_hblank;
      hsync <= hsyncon ? 0 : hsyncoff ? 1 : hsync;  // active low

      vcount <= hreset ? (vreset ? 0 : vcount + 1) : vcount;
      vblank <= next_vblank;
      vsync <= vsyncon ? 0 : vsyncoff ? 1 : vsync;  // active low

      blank <= next_vblank | (next_hblank & ~hreset);
   end
endmodule

////////////////////////////////////////////////////////////////////////////////
//
// pong_game: the game itself!
//
////////////////////////////////////////////////////////////////////////////////

`define INSIDE(pixel_x, pixel_y, region_x, region_y, region_w, region_h) \
			(((pixel_x > region_x) & (pixel_x < (region_x + region_w))) & ((pixel_y > region_y) & (pixel_y < (region_y + region_h))))

`define DISTSQ_PRIV(x1, x2, y1, y2) \
			((x2 - x1)*(x2 - x1) + (y2 - y1)*(y2 - y1))

`define DISTSQ(x1, x2, y1, y2) \
			`DISTSQ_PRIV( ((x2 > x1) ? x1 : x2), ((x2 > x1) ? x2 : x1), ((y2 > y1) ? y1 : y2), ((y2 > y1) ? y2 : y1))
			
`define INSIDERADIUS(x1, x2, y1, y2, r) \
			((r*r) > `DISTSQ(x1, x2, y1, y2)) 



module pong_game (
   input         vclock_in, 	// 65MHz clock
   input         reset_in,		// 1 to initialize module
   input         up_in,		   // 1 when paddle should move up
   input         down_in,     // 1 when paddle should move down
   input [3:0]   pspeed_in,   // puck speed in pixels/tick 
   input [10:0]  hcount_in,	// horizontal index of current pixel (0..1023)
   input [9:0]   vcount_in,   // vertical index of current pixel (0..767)
   input         hsync_in,    // XVGA horizontal sync signal (active low)
   input         vsync_in,    // XVGA vertical sync signal (active low)
   input         blank_in,    // XVGA blanking (1 means output black pixel)
 	
   output        phsync_out, 	// pong game's horizontal sync
   output        pvsync_out, 	// pong game's vertical sync
   output        pblank_out, 	// pong game's blanking
   output reg [23:0] pixel_out  	// pong game's pixel  // r=23:16, g=15:8, b=7:0 
   );
	
	localparam SCREEN_WIDTH  = 1023;
	localparam SCREEN_HEIGHT = 767;
	localparam PUCK_RADIUS   = 150;
	localparam PUCK_STARTX   = SCREEN_WIDTH/2;
	localparam PUCK_STARTY   = (SCREEN_HEIGHT+1)/2;
	
   // Make sure that if the puck has touched the left wall it is past the x position of the paddle
	localparam PADDLESTART_X = 10 + 2*PUCK_RADIUS;
	localparam PADDLESTART_Y = 300;
	localparam PADDLE_WIDTH  = 10;
	localparam PADDLE_HEIGHT = 168;
   
   assign phsync_out = hsync_in;
   assign pvsync_out = vsync_in;
   assign pblank_out = blank_in;
	
	reg[9:0] paddle_x = PADDLESTART_X;
	reg[9:0] paddle_y = PADDLESTART_Y;
	
	reg[9:0] puck_x = PUCK_STARTX;
	reg[9:0] puck_y = PUCK_STARTY;
	
   // Paddle x next is not necessary, but it could be cool if you could move
   // the paddle left and right! In this case paddle_x_next is necessary.
   // In any case synthesis gets rid of this register in the current implementation
	reg[9:0] paddle_x_next = PADDLESTART_X;
	reg[9:0] paddle_y_next = PADDLESTART_Y;
	
	reg[9:0] puck_x_next = PUCK_STARTX;
	reg[9:0] puck_y_next = PUCK_STARTY;
	
   // This makes sure that the movement logic is clocked at a
   // rate which can be perceived by the human eye
	reg [18:0] move_counter = 19'h7FFFF;
	reg [18:0] puck_counter = 19'h7FFFF;
	
	wire [3:0] puck_v_speed;
	wire [3:0] puck_h_speed;
	
   // 90 >> 7 is approx 1/sqrt(2)
   // This makes sure that the speed is given by puck_v_speed
	assign puck_v_speed = (pspeed_in*90) >> 7;
	assign puck_h_speed = (pspeed_in*90) >> 7;
			
   // Direction registers
	reg         down  = 0;
	reg         right = 0;
	reg         had_collision = 0;
	
	wire [7:0] image_red_intensity;
	wire [7:0] image_green_intensity;
	wire [7:0] image_blue_intensity;
	
	wire [7:0] colour_addr;
	
	wire [10:0] puck_x_tl;
	wire [10:0] puck_y_tl;
	wire [15:0] image_addr;

   // Calculate the address based on pixel position
	assign image_addr = (vcount_in - puck_y_tl)*PUCK_RADIUS*2 + (hcount_in - puck_x_tl);
   // top left corner coordinates of puck
	assign puck_x_tl = puck_x_next - PUCK_RADIUS;
	assign puck_y_tl = puck_y_next - PUCK_RADIUS;
	
	image_rom i_rom (
							.clka (vclock_in     ),
							.addra(image_addr),
							.douta(colour_addr)
							);
   // Uncomment for colour (limitations on labkit cause artifacts)							
	// red_rom   r_rom (
	// 						.clka (vclock_in      ),
	// 						.addra(colour_addr ),
	// 						.douta(image_red_intensity)
	// 						);
							
	// green_rom g_rom (
	// 						.clka (vclock_in      ),
	// 						.addra(colour_addr ),
	// 						.douta(image_green_intensity)
	// 						);
							
	blue_rom  b_rom (
							.clka (vclock_in      ),
							.addra(colour_addr ),
							.douta(image_blue_intensity)
							);
	
	always @(posedge vclock_in or posedge reset_in)
	begin
		if (reset_in)
		begin
			paddle_x       <= PADDLESTART_X;
			paddle_y       <= PADDLESTART_Y;
			move_counter <= 19'h7FFFF;
			puck_counter <= 19'h7FFFF;
			
			puck_x <= PUCK_STARTX;
			puck_y <= PUCK_STARTY;
			
			puck_x_next   <= PUCK_STARTX;
			puck_y_next   <= PUCK_STARTY;
			paddle_x_next <= PADDLESTART_X;
			paddle_y_next <= PADDLESTART_Y;
			had_collision <= 0;
		end
		else
		begin
         // Paddle logic
         if (move_counter == 0)
         begin
            // Should we move the paddle and is the paddle going to stay in the screen if we move up?
            if (up_in & `INSIDE(paddle_x_next, paddle_y_next-pspeed_in, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT))
            begin
               paddle_y_next <= paddle_y - pspeed_in;
               // Make sure the next move does not happen too soon
               move_counter <= 19'h7FFFF;
            end //if (up_in & `INSIDE(paddle_x_next, paddle_y_next-pspeed_in, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT))
            else if (down_in & `INSIDE(paddle_x_next, paddle_y_next+pspeed_in+PADDLE_HEIGHT, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT))
            begin
               paddle_y_next <= paddle_y + pspeed_in;
               // Make sure the next move does not happen too soon
               move_counter <= 19'h7FFFF;
            end //if (down_in & `INSIDE(paddle_x_next, paddle_y_next+pspeed_in+PADDLE_HEIGHT, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT))
         end //if (move_counter == 0)
         else
         begin
            move_counter <= move_counter - 1;
         end
			
			paddle_x <= paddle_x_next;
			paddle_y <= paddle_y_next;

         // Only update the puck position if we haven't touched the LHS of the screen
			if (puck_x_next >= PUCK_RADIUS)
			begin
				puck_x <= puck_x_next;
				puck_y <= puck_y_next;
			end
			
			// Puck logic
			if (puck_counter == 0)
			begin
            // Make sure next move does not happen too fast
				puck_counter <= 19'h7FFFF;
            // Make sure we can't have 2 collisions between frames - puck gets "stuck"
            // Check if the bottom right corner of the paddle has had a collision
            // Check if the top right corner of the paddle has had a collision
				if ((~had_collision) && ( 
				       `INSIDERADIUS(paddle_x+PADDLE_WIDTH, puck_x_next, paddle_y+PADDLE_HEIGHT, puck_y_next, PUCK_RADIUS)
					  | `INSIDERADIUS(paddle_x+PADDLE_WIDTH, puck_x_next, paddle_y              , puck_y_next, PUCK_RADIUS) 
					 ))
				begin
               // If there is a collision, make sure we don't get stuck to the object.
					had_collision <= 1;
               // This is a corner collision - reverse both x and y directions
					right <= ~right;
					down  <= ~down;
				end //if ((~had_collision) && ( ...
				else if (~had_collision & `INSIDE(puck_x_next-PUCK_RADIUS, puck_y_next, paddle_x, paddle_y, PADDLE_WIDTH, PADDLE_HEIGHT))
				begin // Collision with right wall of paddle
					had_collision <= 1;
					right        <= 1;
				end
				else if (~had_collision & `INSIDE(puck_x_next, puck_y_next-PUCK_RADIUS, paddle_x, paddle_y, PADDLE_WIDTH, PADDLE_HEIGHT))
				begin // Collision with top wall of paddle
					had_collision <= 1;
					down          <= 1;
				end // Collision with bottom wall of paddle
				else if (~had_collision & `INSIDE(puck_x_next, puck_y_next+PUCK_RADIUS, paddle_x, paddle_y, PADDLE_WIDTH, PADDLE_HEIGHT))
				begin
					had_collision <= 1;
					down        <= 0;
				end
				else // not hitting the paddle - need to collide with sides of the screen
				begin
					had_collision <= 0;
					if (right) // check for collision with right side of the display
					begin
						if ((puck_x_next + PUCK_RADIUS) > SCREEN_WIDTH)
						begin // Collision! Rebound left
							right  <= 0;
							puck_x_next <= puck_x - puck_h_speed;
						end
						else
						begin // No collision - move right
							puck_x_next <= puck_x + puck_h_speed;
						end
					end
					else
					begin
						if (puck_x_next < PUCK_RADIUS)// check for collision with left side of the display
						begin // Collision! Respawn.
                     // make the game a bit easier by making sure the puck
                     // respawns moving away from the paddle
							right  <= 1; 
                     // reset puck position
							puck_x   <= PUCK_STARTX;
							puck_y   <= PUCK_STARTY;
							puck_x_next   <= PUCK_STARTX + puck_h_speed;
							puck_y_next   <= PUCK_STARTY + puck_v_speed;
						end
						else
						begin // No collision: move
							puck_x_next <= puck_x - puck_h_speed;
						end
					end
					// This is necessary to ensure the puck can collide with both the top and bottom
               // edges of the screen simultaneously
					if (puck_x_next >= PUCK_RADIUS) //we haven't lost yet
               begin
                  if (down) // We are moving down
   					begin // Collision! Rebound off bottom of screen
   						if ((puck_y_next + PUCK_RADIUS) > SCREEN_HEIGHT)
   						begin
   							down  <= 0;
   							puck_y_next <= puck_y - puck_v_speed;
   						end
   						else // No collision - move down
   						begin
   							puck_y_next <= puck_y + puck_v_speed;
   						end //if ((puck_y_next + PUCK_RADIUS) > SCREEN_HEIGHT)
   					end //if (down) // We are moving down
   					else // We are moving up
   					begin
   						if (puck_y_next < PUCK_RADIUS)
   						begin // Collision! Rebound off top of screen
   							down   <= 1;
   							puck_y_next <= puck_y + puck_v_speed;
   						end
   						else // No collision - move up
   						begin
   							puck_y_next <= puck_y - puck_v_speed;
   						end //if (puck_y_next < PUCK_RADIUS)
   					end //if (down) // We are moving down
               end //if (puck_x_next >= PUCK_RADIUS) //we haven't lost yet
				end //if (puck_x_next >= PUCK_RADIUS) //we haven't lost yet
			end //if (puck_counter == 0)
			else
			begin
				puck_counter <= puck_counter - 1;
			end
			
			if (`INSIDE(hcount_in, vcount_in, paddle_x, paddle_y, PADDLE_WIDTH, PADDLE_HEIGHT))
			begin
				pixel_out <= {8'hFF, 8'h00, 8'h00};
			end //if (`INSIDE(hcount_in, vcount_in, paddle_x, paddle_y, PADDLE_WIDTH, PADDLE_HEIGHT))
			else if (`INSIDERADIUS(hcount_in, puck_x, vcount_in, puck_y, PUCK_RADIUS))
         begin
				 pixel_out <= {image_blue_intensity, image_blue_intensity, image_blue_intensity};
			end //else if (`INSIDERADIUS(hcount_in, puck_x, vcount_in, puck_y, PUCK_RADIUS))
         else
			begin
				pixel_out <= 24'b0;
			end
		end
	end
endmodule