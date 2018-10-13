`default_nettype none
`timescale 1ns / 1ps

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
    // The 4 main modes of the alarm FSM
    localparam DISARMED    = 0;
    localparam ARMED       = 1;
    localparam TRIGGERED   = 2;
    localparam SOUND_ALARM = 3;
    
    // The 4 different delay values for the timer
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
    // Generate a half hertz clk which we use to drive
    // the status lights
    always @(posedge clk_1Hz_in)
    begin
        half_hertz_clk = ~half_hertz_clk;
    end
    // Debugging state_out onto the LEDs
    assign state_out = state;
    // the signal used to start the timer
    reg start_time_out = 1'b0;
    // As expired_in is held high between start signals of the timer,
    // we detect expired timer by a rising edge
    // thus we need to know the previous values
    always @(posedge clk_in)
    begin
        expired_in_prev <= expired_in;
    end

    // status fsm    
    // This code was separated from the main fsm
    // to ensure that even if the main fsm had issues
    // for debugging purposes, the status LED coud be used
    // to infer the correct state.
    // This made debugging much easier as I could always pinpoint
    // the states which were broken.
    always @(posedge clk_in)
    begin
        // if we are reset or we are in state armed
        if ((program_in == 1'b1) || (state == ARMED))
        begin
            // drive the status led with the half Hz clock
            status_out <= half_hertz_clk;
        end
        else if ((state == TRIGGERED) | (state == SOUND_ALARM))
        begin
            // if we are in the triggered or sound alarm state
            // set the status led to on
            status_out <= 1'b1;
        end
        else // if (status == DISARMED)
        begin
            status_out <= 1'b0;
        end
    end
    
    // assign the siren enable value based on state
    assign siren_out = set_siren(program_in, state);
    
    // main fsm
    always @(posedge clk_in)
    begin
        if (program_in | (state == ARMED))
        begin
            if (ignition_in)
            begin // we are in armed mode and we get the ignition
                // make sure start time out is low
                // this allows the timer to start
                start_time_out <= 1'b0;
                state <= DISARMED;                
            end
            else if (~program_in)
            begin // check if any of the doors were opened.
                  // if so, move to the new state and select the 
                  // relevant timer
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
            begin // if we got the program in signal but no igntion
                // make sure start time out is low
                // this allows the timer to start
                start_time_out <= 1'b0;
                state <= ARMED;    
            end
        end
        else if (state == TRIGGERED)
        begin
            if (ignition_in)
            begin // we are in triggered mode and we get the ignition
                // make sure start time out is low
                // this allows the timer to start
                start_time_out <= 1'b0;
                state <= DISARMED;
            end
            else if (expired_in & ~expired_in_prev)
            begin // The time has expired, we are still not disabled
                start_time_out <= 1'b1;
                state <= SOUND_ALARM;
                interval_out <= SEL_ALARM_ON;
            end
            else
            begin
                // make sure start time out is low
                // this allows the timer to start
                start_time_out <= 1'b0;
            end
        end
        else if (state == SOUND_ALARM)
        begin
            if (ignition_in | ((expired_in & ~expired_in_prev) & (~(driver_door_in | passenger_door_in))))
            begin // we are in soud alarm mode and we get the ignition or the alarm timer has expired and 
                  // all doors are now closed
                state <= DISARMED;
                // make sure start time out is low
                // this allows the timer to start 
                start_time_out <= 1'b0;
            end
            else if (start_time_out)
            begin 
                // make sure start time out is low
                // this allows the timer to start
                start_time_out <= 1'b0;
            end
        end
        else if (state == DISARMED)
        begin
            if ((~ignition_in) & driver_door_in)
            begin  // driver door was opened for the first time
                // make sure start time out is low
                // this allows the timer to start
                start_time_out <= 1'b0;
                driver_leaving <= 1'b1; // remember this
            end
            else if (driver_leaving & (~(driver_door_in | passenger_door_in)))
            begin // driver door is now closed
                driver_leaving <= 1'b0;
                start_time_out <= 1'b1;
                // go to armed mode
                interval_out   <= SEL_ARM_DELAY;                
            end
            else if ((expired_in == 1'b1) && (expired_in_prev == 1'b0) && (interval_out == SEL_ARM_DELAY) )
            begin
                // make sure start time out is low
                // this allows the timer to start     
                start_time_out <= 1'b0;
                state <= ARMED;
            end
            else
            begin
                // make sure start time out is low
                // this allows the timer to start       
                start_time_out <= 1'b0;
            end
        end
    end

    function set_siren;
    input       program_in;
    input [1:0] state;
    begin
        // set the siren if we are in the sound alarm state
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
