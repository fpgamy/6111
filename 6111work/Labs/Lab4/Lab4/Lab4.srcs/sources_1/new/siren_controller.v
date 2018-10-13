`default_nettype none
module siren_controller (clk_in, en_in, pwm_out);
	input wire clk_in;
	input wire en_in;
	output pwm_out;
    
    // Output a warbling tone which warbles in freq with period = every 10 second
    localparam WARBLE_MAX    = 10000000;
    // Registers used in pwm
	reg [27:0]  count = 1;
	reg [27:0] warble_counter = WARBLE_MAX;
    reg [27:0] freq_sel = 5500;
	
	reg pwm_out = 0;
    
    // PWM
	always @(posedge clk_in)
	begin
	   if (warble_counter == 0)
	   begin
	   		// gradually decrease the frequency
	       warble_counter <= WARBLE_MAX;
	       freq_sel <= (freq_sel < 51100) ? (100 + freq_sel) : 100; //(freq_sel == FREQ_1) ? FREQ_2 : FREQ_1;
	   end
	   else
	   begin
	       warble_counter <= warble_counter - 1;
	   end
	end

	always @(posedge clk_in)
	begin
		if (count == 0)
		begin
			// reset the count to the value of the freq_sel register
			// ensure 50/50 mark space
			count <= freq_sel*2;
		end
		else 
		begin
			// decrement the counter
			count <= count - 1;
		end
		if (count > freq_sel)
		begin
			// switch if greater
			pwm_out <= en_in;
        end
		else if (en_in)
		begin // if smaller, pwm = 0
			pwm_out <= 1'b0;
        end
	end
endmodule