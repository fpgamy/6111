`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  ilovesystemverilog
// Engineer: magson gao
// 
// Create Date: 10/02/2018 04:27:46 PM
// Design Name: whylifewhy
// Module Name: alarm_fsm
// Project Name: lab4wouldbenefitfromsomesystemverilogmagic
// Target Devices: nexys somethingorother
// Tool Versions: bad
// Description: imisssystemverilog
// 
// Dependencies: brain and soul
// 
// Revision: still broken
// Revision 0.01 - File Created
// Additional Comments: well done
// 
//////////////////////////////////////////////////////////////////////////////////


module alarm_fsm( 
                    clk_in, 
                    ignition_in, 
                    driver_door_in, 
                    passenger_door_in, 
                    program_in, 
                    expired_in, 
                    siren_out, 
                    status_out 
                );
    localparam DISARMED    = 0;
    localparam ARMED       = 1;
    localparam TRIGGERED   = 2;
    localparam SOUND_ALARM = 3;
    
    input clk_in;
    input ignition_in;
    input driver_door_in;
    input passenger_door_in;
    input program_in;
    input expired_in;
    
    output siren_out;
    output status_out;
    
    reg status_out = 1'b0;   
    reg [1:0] state = DISARMED;
    
    always @(posedge clk_in)
    begin
        if (state == ARMED)
        begin
            status_out <= ~status_out;
        end
        else if ((state == TRIGGERED) | (state == SOUND_ALARM))
        begin
            status_out <= 1'b1;
        end
        else // if (status == DISARMED)
        begin
            status_out <= 1'b0;
        end
    end
    
    always @(posedge clk_in)
    begin
        if (state == 
    end    
                  
endmodule
