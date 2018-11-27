`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/20/2018 10:57:07 PM
// Design Name: 
// Module Name: clk_prescale
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


module clk_prescale(
        input clk,
        output clk_ps
    );
    
reg[16:0] counter = 0;

always @(posedge clk) begin
    if(counter == 120000) begin
        counter <= 0;
    end else begin
        counter <= counter + 1;
    end
end

assign clk_ps = (counter == 120000);
endmodule
