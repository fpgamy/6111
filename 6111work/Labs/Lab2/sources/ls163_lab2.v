`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:25:37 09/16/2018 
// Design Name: 
// Module Name:    ls163_lab2 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module ls163_lab2(
    input clk,
    input ent,
    input enp,
    input load,
    input clear,
    input a,
    input b,
    input c,
    input d,
    output reg qa,
    output reg qb,
    output reg qc,
    output reg qd,
    output rco
    );
	 wire [3:0] in_count  = {d, c, b, a};

    assign rco = &({qd, qc, qb, qa, ent});

    always @(posedge clk)
    begin
	     if (~clear)
        begin
            {qd, qc, qb, qa} <= 4'b0;
        end
        else if (~load)
        begin
            {qd, qc, qb, qa} <= in_count;
        end
        else if (ent & enp)
        begin
            {qd, qc, qb, qa} <= {qd, qc, qb, qa} + 1;
        end
    end

endmodule
