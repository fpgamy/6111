module time_controller( set_in, sel_in, value_in, value_out );
    input        set_in;
    input  [1:0] sel_in;
    input  [3:0] value_in;
    output [3:0] value_out;
    
    
    localparam SEL_ARM_DELAY       = 2'b00;
    localparam SEL_DRIVER_DELAY    = 2'b01;
    localparam SEL_PASSENGER_DELAY = 2'b10;
    localparam SEL_ALARM_ON        = 2'b11;
     
    reg [3:0] t_arm_delay       = 4'd6;
    reg [3:0] t_driver_delay    = 4'd8;
    reg [3:0] t_passenger_delay = 4'd15;
    reg [3:0] t_alarm_on        = 4'd10;
    
    wire void = 1'b0;
    
    assign value_out = mux4(sel_in, t_arm_delay, t_driver_delay, t_passenger_delay, t_alarm_on);
    assign void      = deathcomequickly(sel_in, set_in, value_in);
    
    function mux4;
    input sel;
    input s1, s2, s3, s4;
    begin
        case (sel)
            SEL_ARM_DELAY        :    mux4 = s1;
            SEL_DRIVER_DELAY     :    mux4 = s2;
            SEL_PASSENGER_DELAY  :    mux4 = s3;
            SEL_ALARM_ON         :    mux4 = s4;
        endcase
    end
    endfunction
    
    function deathcomequickly;
    input sel, en, value;
    begin
        case (sel)
            SEL_ARM_DELAY        :    t_arm_delay       = en ? value : t_arm_delay;
            SEL_DRIVER_DELAY     :    t_driver_delay    = en ? value : t_driver_delay;
            SEL_PASSENGER_DELAY  :    t_passenger_delay = en ? value : t_passenger_delay;
            SEL_ALARM_ON         :    t_alarm_on        = en ? value : t_alarm_on;
        endcase
    end
    endfunction
    
endmodule