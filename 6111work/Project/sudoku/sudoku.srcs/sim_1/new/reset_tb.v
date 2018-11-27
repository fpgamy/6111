`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2018 10:25:12 PM
// Design Name: 
// Module Name: reset_tb
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


module reset_tb();
   
reg clk = 0;
reg reset_input = 0;
wire reset;
    
pwr_reset uut (.clk(clk), .reset_input(reset_input), .reset(reset));
    
initial begin
#200;

reset_input = 1;
#10 reset_input = 0;
end
    
always #5 clk = ~clk;
endmodule
