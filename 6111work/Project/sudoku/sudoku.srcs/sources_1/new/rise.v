`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/06/2018 04:31:30 PM
// Design Name: 
// Module Name: rise
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


module rise(
        input clk,
        input in,
        output out
    );
    
reg last = 0;

always @(posedge clk) begin
    last <= in;
end

assign out = (in && ~last);

endmodule
