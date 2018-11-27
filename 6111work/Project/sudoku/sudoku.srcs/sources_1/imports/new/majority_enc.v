`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2018 08:43:28 PM
// Design Name: 
// Module Name: majority_enc
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


module majority_enc(
        data,
        majority
    );
    
parameter INPUT_WIDTH = 9;
parameter MAJORITY = INPUT_WIDTH/2 + 1;

input[INPUT_WIDTH-1:0] data;
output majority;

// 6 bits should be enough for everybody -- Bill Gates
reg[5:0] accl = 0;

integer index;

always @* begin
    accl = 0;
    
    for(index = 0; index < INPUT_WIDTH; index = index + 1) begin
        accl = accl + data[index];     
    end
end

assign majority = (accl >= MAJORITY);

endmodule
