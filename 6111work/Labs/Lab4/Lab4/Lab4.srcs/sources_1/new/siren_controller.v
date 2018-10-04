module siren_controller (clk_in, en_in, pwm_out);
	input clk_in;
	input en_in;
	output pwm_out;
    
    // Output a warbling tone which warbles in volume every 1 second
    localparam WARBLE_MAX    = 100000000;
    localparam VOLUME_TOGGLE = 10'b0000011111;
    // Registers used in pwm
	reg [9:0]  d;
	reg [9:0]  count = VOLUME_TOGGLE;
	reg [19:0] warble_counter = WARBLE_MAX;
	
	reg pwm_out;
    
    // PWM
	always @(posedge clk_in)
	begin
	   if (warble_counter == 0)
	   begin
	       warble_counter <= WARBLE_MAX;
	       count          <= ~count;
	   end
	   else
	   begin
	       warble_counter <= warble_counter - 1;
	   end
	end

	always @(posedge clk_in)
	begin
		count <= count + 1'b1;
		if (count > d)
		begin
			pwm_out <= 1'b0;
        end
		else if (en_in)
		begin
			pwm_out <= 1'b1;
        end
	end
endmodule