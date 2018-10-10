module fuel_pump_controller_tb;
	reg  clk             = 1'b0;
	reg  reset           = 1'b1;
	reg  brake           = 1'b0;
	reg  hidden_switch   = 1'b0;
	reg  ignition        = 1'b0;
	
	wire fuel_power;
	
	fuel_pump_controller fpc1(
							.clk_in(clk),
							.reset_in(reset),
							.brake_in(brake),
							.hidden_switch_in(hidden_switch),
							.ignition_in(ignition),
							.fuel_power_out(fuel_power)
					    );

	initial
	begin
		$dumpfile("fuel_test.vcd");
		$dumpvars(0, fuel_pump_controller_tb);
		reset           = 1'b1;
		brake           = 1'b0;
		hidden_switch   = 1'b0;
		ignition        = 1'b0;
		#10;
		reset           = 1'b0;
		brake           = 1'b1;
		hidden_switch   = 1'b1;
		ignition        = 1'b1;
		#100; // Fuel power should stay 0
		ignition        = 1'b0;
		#10;
		brake           = 1'b0;
		hidden_switch   = 1'b0;
		#10;
		ignition        = 1'b0;
		#10;
		ignition        = 1'b1;
		#10;
		hidden_switch   = 1'b1;
		#5;
		ignition        = 1'b0;
		#10;
		brake           = 1'b1;
		#10;
		ignition        = 1'b1;
		#10;
		brake           = 1'b1;
		hidden_switch   = 1'b1;
		#10;
		ignition        = 1'b0;
		#500;
		$finish;
	end

	always #5 clk = ~clk;
endmodule