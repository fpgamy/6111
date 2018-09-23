`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:26:13 09/16/2018
// Design Name:   rs232send
// Module Name:   /afs/athena.mit.edu/user/m/a/magson/Documents/6111/6111work/Labs/Lab2B/lab2b/sendx_tb.v
// Project Name:  lab2b
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: rs232send
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module sendx_tb;

	// Inputs
	reg clk;
	reg rst;
	reg [7:0] data;
	reg start_send;

	// Outputs
	wire xmit_data;
	wire xmit_clk;
	wire led_debug;

	// Instantiate the Unit Under Test (UUT)
	rs232send uut (
		.clk(clk), 
		.rst(rst), 
		.data(data), 
		.start_send(start_send), 
		.xmit_data(xmit_data), 
		.xmit_clk(xmit_clk), 
		.led_debug(led_debug)
	);
	
	always #5 clk = !clk;

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		data = 0;
		start_send = 0;

		// Wait 100 ns for global reset to finish
		#100;
		rst = 1;
		#10;
		rst = 0;
		#10;
        
		data = 8'd65;
		#10;
		start_send = 1'b1;
		#10;
		start_send = 1'b0;
		#10;

	end
      
endmodule

