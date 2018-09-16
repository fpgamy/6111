`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:32:45 09/16/2018
// Design Name:   ls163_lab2
// Module Name:   /afs/athena.mit.edu/user/m/a/magson/Documents/6111work/Labs/Lab2/lab2/ls163_tb.v
// Project Name:  lab2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ls163_lab2
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ls163_tb;

	// Inputs
	reg clk;
	reg ent;
	reg enp;
	reg load;
	reg clear;
	reg a;
	reg b;
	reg c;
	reg d;

	// Outputs
	wire qa;
	wire qb;
	wire qc;
	wire qd;
	wire rco;

	// Instantiate the Unit Under Test (UUT)
	ls163_lab2 uut (
		.clk(clk), 
		.ent(ent), 
		.enp(enp), 
		.load(load), 
		.clear(clear), 
		.a(a), 
		.b(b), 
		.c(c), 
		.d(d), 
		.qa(qa), 
		.qb(qb), 
		.qc(qc), 
		.qd(qd), 
		.rco(rco)
	);
	  
	// set clk to a frequency of 100MHz
	always #5 clk = ~clk;
				
	initial begin
		// Initialize Inputs
		clk           = 0;
		ent           = 0;
		enp           = 0;
		load          = 0;
		clear         = 0;
		{d, c, b, a} = 4'd0;

		// Wait 100 ns for global reset to finish
		#100;
		
		// Initialise count to 9 and begin counting
		clear          = 1'b1;
		load           = 1'b0;
		{d, c, b, a} = 4'd9;
		ent           = 1'b1;
		enp           = 1'b1;
		
		#20;
		
		load          = 1'b1;
 	end
      
endmodule

