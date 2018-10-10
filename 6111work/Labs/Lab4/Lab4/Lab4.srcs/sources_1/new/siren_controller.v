module siren_controller (clk_in, en_in, pwm_out);
	input clk_in;
	input en_in;
	output pwm_out;
    
    // Output a warbling tone which warbles in volume every 1 second
    localparam WARBLE_MAX    = 100000000;
    localparam FREQ_1        = 51100;
    localparam FREQ_2        = 25500;
    // Registers used in pwm
	reg [27:0]  count = 1;
	reg [27:0] warble_counter = WARBLE_MAX;
    reg [27:0] freq_sel = FREQ_1;
	
	reg pwm_out = 0;
    
    // PWM
	always @(posedge clk_in)
	begin
	   if (warble_counter == 0)
	   begin
	       warble_counter <= WARBLE_MAX;
	       freq_sel <= (freq_sel == FREQ_1) ? FREQ_2 : FREQ_1;
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
			count <= freq_sel*2;
		end
		else 
		begin
			count <= count - 1;
		end
		if (count > freq_sel)
		begin
			pwm_out <= en_in;
        end
		else if (en_in)
		begin
			pwm_out <= 1'b0;
        end
	end
endmodule