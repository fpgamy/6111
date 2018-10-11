`default_nettype none
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
   input wire CLK100MHZ,
   input wire [15:0] SW, 
   input wire BTNC, BTNU, BTNL, BTNR, BTND,
   output wire [3:0] VGA_R, 
   output wire [3:0] VGA_B, 
   output wire [3:0] VGA_G,
   output wire [7:0] JA, 
   output wire VGA_HS, 
   output wire VGA_VS, 
   output wire LED16_B, LED16_G, LED16_R,
   output wire LED17_B, LED17_G, LED17_R,
   output wire [15:0] LED,
   output wire [7:0] SEG,  // segments A-G (0-6), DP (7)
   output wire [7:0] AN    // Display 0-7
   );

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
// T_PASSENGER_DELAY = length of countdown before the alarm sounds after opening the passenger's door
// T_ALARM_ON = length of time the siren sounds
    
    wire clock_25mhz;
    wire clock_1hz;
    wire reset_sig;
    //wire timer_enable;
    wire [15:0] sw;
    wire reprog;
    wire brake_pedal;
    wire ignition;
    wire hidden_button;
    wire btnd;

    assign VGA_R = 0;
    assign VGA_B = 0;
    assign VGA_G = 0;
    assign VGA_HS = 0;
    assign VGA_VS = 0;
    assign LED16_B = 0;
    assign LED16_G = 0;
    assign LED16_R = 0;
    assign LED17_B = 0;
    assign LED17_G = 0;
    assign LED17_R = 0;
    assign JA[7:1] = 0;
    assign LED[15:12] = 0;
    assign reset_sig = sw[13];
    generate
      genvar i;
      for (i = 0; i < 16; i = i + 1)
      begin: gen_debouncers
        debounce debouncer(
                            .reset(reset_sig),
                            .clock(CLK100MHZ),
                            .noisy(SW[i]),
                            .clean(sw[i])
                          );
      end
    endgenerate
    debounce dbb1(
                        .reset(reset_sig),
                        .clock(CLK100MHZ),
                        .noisy(BTNC),
                        .clean(reprog)
                      );

    debounce dbb2(
                        .reset(reset_sig),
                        .clock(CLK100MHZ),
                        .noisy(BTNU),
                        .clean(brake_pedal)
                      );

    debounce dbb3(
                        .reset(reset_sig),
                        .clock(CLK100MHZ),
                        .noisy(BTNL),
                        .clean(ignition)
                      );

    debounce dbb4(
                        .reset(reset_sig),
                        .clock(CLK100MHZ),
                        .noisy(BTNR),
                        .clean(hidden_button)
                      );

    debounce dbb5(
                        .reset(reset_sig),
                        .clock(CLK100MHZ),
                        .noisy(BTND),
                        .clean(btnd)
                      );

// create 25mhz system clock
    clock_quarter_divider clockgen(
                                    .clk100_mhz(CLK100MHZ), 
                                    .clock_25mhz(clock_25mhz)
                                  );
// create a 1Hz clock
    clk_divider second_timer(
                              .clk_in(clock_25mhz), 
                              .reset_in(reset_sig), 
                              .en_in(1'b1), 
                              .clk_out(clock_1hz)
                            );

    wire [1:0] time_param_selector;
    assign time_param_selector = {sw[1], sw[0]};
    wire [3:0] time_value;
    assign time_value          = {sw[5], sw[4], sw[3], sw[2]};
    wire driver_door_sensor;
    assign driver_door_sensor = sw[15];
    wire passenger_door_sensor;
    assign passenger_door_sensor = sw[14];
    wire [3:0] time_param_for_timer;
    wire [1:0] interval_sel;
    time_controller tc(
                        .clk_in(clock_25mhz),
                        .reset_in(reset_sig),
                        .set_in(reprog),
                        .sel_in(time_param_selector),
                        .out_sel_in(interval_sel),
                        .value_in(time_value),
                        .value_out(time_param_for_timer)
                        );
    assign LED[11:8] = time_param_for_timer;
    wire start_timer;
    wire expire;
    wire [3:0] counter_val;
    wire [31:0] counter_disp;

    assign counter_disp = {27'b0, counter_val};

    display_8hex d8h(
                      .clk(CLK100MHZ),
                      .data(counter_disp),
                      .seg(SEG),
                      .strobe(AN)
                    );

    timer t1(
              .clk_in(clock_25mhz),
              .clk_1hz_in(clock_1hz),
              .start_in(start_timer),
              .value_in(time_param_for_timer),
              .counter_out(counter_val),
              .expire_out(expire)
            );
            
    assign LED[4] = expire;
    assign LED[5] = start_timer;

    fuel_pump_controller fc1(
                              .clk_in(clock_25mhz),
                              .reset_in(reset_sig),
                              .brake_in(brake_pedal),
                              .hidden_switch_in(hidden_button),
                              .ignition_in(ignition),
                              .fuel_power_out(LED[0])
                            );

    wire siren_en;
    assign LED[3] = clock_1hz;
    alarm_fsm af1(
                    .clk_in(clock_25mhz),
                    .clk_1Hz_in(clock_1hz),
                    .ignition_in(ignition),
                    .driver_door_in(driver_door_sensor),
                    .passenger_door_in(passenger_door_sensor),
                    .program_in(reprog | reset_sig),
                    .expired_in(expire),
                    .siren_out(siren_en),
                    .start_time_out(start_timer),
                    .interval_out(interval_sel),
                    .status_out(LED[1]),
                    .state_out({LED[7], LED[6]})
                  );

    siren_controller sc1(
                          .clk_in(CLK100MHZ),
                          .en_in(siren_en),
                          .pwm_out(JA[0])
                        );

    assign LED[2] = JA[0];


endmodule

module clock_quarter_divider(input wire clk100_mhz, output reg clock_25mhz = 0);
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

module vga(input wire vga_clock,
            output reg [9:0] hcount = 0,    // pixel number on current line
            output reg [9:0] vcount = 0,    // line number
            output reg vsync, hsync, 
            output wire at_display_area);

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

