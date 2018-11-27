`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/13/2018 09:04:55 PM
// Design Name: 
// Module Name: reset
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


module pwr_reset(
        input clk,
        input reset_input,
        output reset
    );
    
reg[23:0] sr = 24'hFFFF;

always @(posedge clk) begin
    sr <= {sr[22:0], 1'b0};
end

assign reset = reset_input || (sr[15] == 0);
endmodule
