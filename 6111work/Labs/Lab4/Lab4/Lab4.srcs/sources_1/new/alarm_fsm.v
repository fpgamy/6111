`default_nettype none
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
                    clk_1Hz_in,
                    ignition_in, 
                    driver_door_in, 
                    passenger_door_in, 
                    program_in, 
                    expired_in, 
                    siren_out,
                    start_time_out,
                    interval_out,
                    status_out,
                    state_out
                );
    localparam DISARMED    = 0;
    localparam ARMED       = 1;
    localparam TRIGGERED   = 2;
    localparam SOUND_ALARM = 3;
    
    
    localparam SEL_ARM_DELAY       = 2'b00;
    localparam SEL_DRIVER_DELAY    = 2'b01;
    localparam SEL_PASSENGER_DELAY = 2'b10;
    localparam SEL_ALARM_ON        = 2'b11;
    
    input wire clk_in;
    input wire clk_1Hz_in;
    input wire ignition_in;
    input wire driver_door_in;
    input wire passenger_door_in;
    input wire program_in;
    input wire expired_in;
    
    output wire siren_out;
    output status_out;
    output start_time_out;
    output [1:0] interval_out;
    output wire [1:0] state_out;
    
    reg status_out = 1'b0;   
    reg [1:0] state = ARMED;
    reg [1:0] interval_out = SEL_PASSENGER_DELAY;
    reg driver_leaving = 1'b0;
    reg half_hertz_clk = 1'b0;
    reg expired_in_prev = 1'b0;
    
    always @(posedge clk_1Hz_in)
    begin
        half_hertz_clk = ~half_hertz_clk;
    end
    
    assign state_out = state;
    
    reg start_time_out = 1'b0;
    
    always @(posedge clk_in)
    begin
        expired_in_prev <= expired_in;
    end
    
    always @(posedge clk_in)
    begin    
        if ((program_in == 1'b1) || (state == ARMED))
        begin
            if (program_in)
            begin
                status_out <= 1'b0;
            end
            else
            begin
                status_out <= half_hertz_clk;
            end
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

    assign siren_out = set_siren(program_in, state);
    
    always @(posedge clk_in)
    begin
        if (program_in | (state == ARMED))
        begin
            if (ignition_in)
            begin
                state <= DISARMED;                
                start_time_out <= 1'b0;
            end
            else if (~program_in)
            begin
                if (driver_door_in)
                begin
                    start_time_out <= 1'b1;
                    interval_out <= SEL_DRIVER_DELAY;
                    state <= TRIGGERED;
                end
                else if (passenger_door_in)
                begin
                    start_time_out <= 1'b1;
                    interval_out <= SEL_PASSENGER_DELAY;
                    state <= TRIGGERED;
                end
            end
            else 
            begin          
                start_time_out <= 1'b0;
                state <= ARMED;    
            end
        end
        else if (state == TRIGGERED)
        begin
            if (ignition_in)
            begin          
                start_time_out <= 1'b0;
                state <= DISARMED;
            end
            else if (expired_in & ~expired_in_prev)
            begin
                start_time_out <= 1'b1;
                state <= SOUND_ALARM;
                interval_out <= SEL_ALARM_ON;
            end
            else
            begin          
                start_time_out <= 1'b0;
            end
        end
        else if (state == SOUND_ALARM)
        begin
            if (ignition_in | ((expired_in & ~expired_in_prev) & (~(driver_door_in | passenger_door_in))))
            begin
                state <= DISARMED;          
                start_time_out <= 1'b0;
            end
            else if (start_time_out)
            begin          
                start_time_out <= 1'b0;
            end
        end
        else if (state == DISARMED)
        begin
            if ((~ignition_in) & driver_door_in)
            begin          
                start_time_out <= 1'b0;
                driver_leaving <= 1'b1;
            end
            else if (driver_leaving & (~(driver_door_in | passenger_door_in)))
            begin
                driver_leaving <= 1'b0;
                start_time_out <= 1'b1;
                interval_out   <= SEL_ARM_DELAY;                
            end
            else if ((expired_in == 1'b1) && (expired_in_prev == 1'b0) && (interval_out == SEL_ARM_DELAY) )
            begin          
                start_time_out <= 1'b0;
                state <= ARMED;
            end
            else
            begin          
                start_time_out <= 1'b0;
            end
        end
    end

    function set_siren;
    input       program_in;
    input [1:0] state;
    begin
        if (program_in)
        begin
            set_siren = 1'b0;
        end
        else if ( state == SOUND_ALARM )
        begin
            set_siren = 1'b1;
        end
        else
        begin
            set_siren = 1'b0;
        end 
    end
    endfunction       
endmodule
