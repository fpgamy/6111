module fuel_pump_controller( clk_in,
                             reset_in, // Probably attach this to the reprogram
                             brake_in, 
                             hidden_switch_in, 
                             ignition_in, 
                             fuel_power_out);
         input clk_in;
         input reset_in;
         input brake_in;
         input hidden_switch_in;
         input ignition_in;
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
                if (ignition_in & (~ignition_on))
                begin
                    ignition_on <= 1'b1;
                end
                else if (brake_in & hidden_switch_in)
                begin
                    fuel_power_out <= 1'b1;
                end
            end
         
         end 
                  
endmodule
                  
