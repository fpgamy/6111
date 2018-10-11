`default_nettype none
module time_controller( clk_in, reset_in, set_in, sel_in, out_sel_in, value_in, value_out );
    input       wire clk_in;
    input       wire reset_in;
    input       wire set_in;
    input  wire [1:0] sel_in;
    input  wire [1:0] out_sel_in;
    input  wire [3:0] value_in;
    output wire [3:0] value_out;
    
    
    localparam SEL_ARM_DELAY       = 2'b00;
    localparam SEL_DRIVER_DELAY    = 2'b01;
    localparam SEL_PASSENGER_DELAY = 2'b10;
    localparam SEL_ALARM_ON        = 2'b11;
     
    reg [3:0] t_arm_delay       = 4'd6;
    reg [3:0] t_driver_delay    = 4'd8;
    reg [3:0] t_passenger_delay = 4'd15;
    reg [3:0] t_alarm_on        = 4'd10;

    assign value_out = mux4(out_sel_in, t_arm_delay, t_driver_delay, t_passenger_delay, t_alarm_on);

    always @(posedge clk_in or posedge reset_in)
    begin
        if (reset_in)
        begin
            t_arm_delay       <= 4'd6;
            t_driver_delay    <= 4'd8;
            t_passenger_delay <= 4'd15;
            t_alarm_on        <= 4'd10;            
        end
        else if (set_in)
        begin
            case (sel_in)
                SEL_ARM_DELAY        :    t_arm_delay       <= value_in;
                SEL_DRIVER_DELAY     :    t_driver_delay    <= value_in;
                SEL_PASSENGER_DELAY  :    t_passenger_delay <= value_in;
                SEL_ALARM_ON         :    t_alarm_on        <= value_in;
            endcase
        end
    end
    
    function [3:0] mux4;
    input [1:0] sel;
    input [3:0] s1, s2, s3, s4;
    begin
        case (sel)
            SEL_ARM_DELAY        :    mux4 = s1;
            SEL_DRIVER_DELAY     :    mux4 = s2;
            SEL_PASSENGER_DELAY  :    mux4 = s3;
            SEL_ALARM_ON         :    mux4 = s4;
        endcase
    end
    endfunction
endmodule