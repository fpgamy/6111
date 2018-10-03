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
                    start_time_out,
                    interval_out,
                    status_out 
                );
    localparam DISARMED    = 0;
    localparam ARMED       = 1;
    localparam TRIGGERED   = 2;
    localparam SOUND_ALARM = 3;
    
    
    localparam SEL_ARM_DELAY       = 2'b00;
    localparam SEL_DRIVER_DELAY    = 2'b01;
    localparam SEL_PASSENGER_DELAY = 2'b10;
    localparam SEL_ALARM_ON        = 2'b11;
    
    input clk_in;
    input ignition_in;
    input driver_door_in;
    input passenger_door_in;
    input program_in;
    input expired_in;
    
    output siren_out;
    output status_out;
    output start_time_out;
    output [1:0] interval_out;
    
    reg status_out = 1'b0;   
    reg [1:0] state = DISARMED;
    reg [1:0] interval_out = SEL_PASSENGER_DELAY;
    reg siren_out = 1'b0;
    reg start_time_out;
    reg driver_leaving = 1'b0;
    
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
        if ( state == SOUND_ALARM )
        begin
            siren_out <= 1'b1;
        end
        else
        begin
            siren_out <= 1'b0;
        end 
    end
    
    always @(posedge clk_in)
    begin
        if (state == ARMED)
        begin
            if (ignition_in)
            begin
                state <= DISARMED;
            end
            else
            begin
                if (driver_door_in)
                begin
                    start_time_out <= 1'b1;
                    interval_out <= SEL_DRIVER_DELAY;
                end
                else if (passenger_door_in)
                begin
                    start_time_out <= 1'b1; 
                    interval_out <= SEL_PASSENGER_DELAY;
                end
                state <= TRIGGERED;
            end
        end
        else if (state == TRIGGERED)
        begin
            if (ignition_in)
            begin
                state <= DISARMED;
            end
            else if (expired_in)
            begin
                state <= SOUND_ALARM;
                interval_out <= SEL_ALARM_ON;
            end
        end
        else if (state == SOUND_ALARM)
        begin
            if (ignition_in | (expired_in & (~(driver_door_in | passenger_door_in))))
            begin
               state <= DISARMED;
            end            
        end
        else if (state == DISARMED)
        begin
            if ((~ignition_in) & driver_door_in)
            begin
                driver_leaving <= 1'b1;
            end
            else if (driver_leaving & (~driver_door_in))
            begin
                driver_leaving <= 1'b0;
                start_time_out <= 1'b1;
                interval_out   <= SEL_ARM_DELAY;                
            end
            else if (expired_in)
            begin
                state <= ARMED;
            end
        end
    end
                  
endmodule
