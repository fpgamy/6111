`default_nettype none
module fuel_pump_controller( clk_in,
                             reset_in, // Probably attach this to the reprogram
                             brake_in, 
                             hidden_switch_in, 
                             ignition_in, 
                             fuel_power_out);
         input  wire clk_in;
         input  wire reset_in;
         input  wire brake_in;
         input  wire hidden_switch_in;
         input  wire ignition_in;
         output fuel_power_out;
         
         reg ignition_on    = 1'b0;
         reg fuel_power_out = 1'b0;
         
         always @(posedge clk_in or posedge reset_in)
         begin
            if (reset_in)
            begin
                ignition_on <= 1'b0;
                fuel_power_out <= 1'b0;
            end
            else
            begin
                // turn off the ignition as soon as 
                // key is removed
                if (fuel_power_out & (~ignition_in))
                begin
                    ignition_on <= 1'b0;
                    fuel_power_out <= 1'b0;
                end
                else 
                begin
                    if (brake_in & hidden_switch_in)
                    begin // both are pressed
                        if (ignition_on)
                        begin // and the key is in
                            fuel_power_out <= 1'b1;
                        end
                    end
                    else if (ignition_in & (~ignition_on))
                    begin // remember if the ignition was in
                        ignition_on <= 1'b1;
                    end
                end
            end
         
         end 
                  
endmodule
                  
