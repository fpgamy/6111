module siren_controller_tb;
	reg  clk             = 1'b0;
	reg  en              = 1'b1;
	
	wire pwm;

	siren_controller sc1(	
							.clk_in(clk), 
							.en_in(en),
							.pwm_out(pwm)
					    );

	initial
	begin
		$dumpfile("test.vcd");
		$dumpvars(0, siren_controller_tb);
		en       = 1'b0;
		#10;
		en       = 1'b1;
		#100;
		en       = 1'b0;
		#100;
		en       = 1'b1;
		#500;
		$finish;
	end

	always #5 clk = ~clk;
endmodule