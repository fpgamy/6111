module alarm_fsm_tb;
	reg     clk             = 1'b0;
	reg     ignition        = 1'b0;
	reg     driver_door     = 1'b0;
	reg     passenger_door  = 1'b0;
	reg     program         = 1'b1;
	reg     expired         = 1'b0;


	wire       siren;
	wire       start_time;
	wire [1:0] interval;
	wire       status;

	alarm_fsm af1(
					.clk_in(clk),
					.clk_1Hz_in(clk),
					.ignition_in(ignition),
					.driver_door_in(driver_door),
					.passenger_door_in(passenger_door),
					.program_in(program),
					.expired_in(expired),
					.siren_out(siren),
					.start_time_out(start_time),
					.interval_out(interval),
					.status_out(status)
					);
	initial
	begin
		$dumpfile("alarm_test.vcd");
		$dumpvars(0, alarm_fsm_tb);
		reset_fsm;
		#50;
		ignition = 1'b1;

		reset_fsm;

		#10; // expect instant transition
		ignition = 1'b0;
		
		reset_fsm;

		passenger_door = 1'b1;
		
		#10;

		passenger_door = 1'b0;

		reset_fsm;

		driver_door = 1'b1;

		#10;

		driver_door = 1'b0;

		reset_fsm;

		#10;

		ignition = 1'b1;

		#10;
		ignition = 1'b0;
		driver_door = 1'b1;
		#10;
		// should do nothing
		passenger_door = 1'b1;
		#10;
		passenger_door = 1'b0;
		driver_door = 1'b0;
		#10;
		expired = 1'b1;
		#100;
		expired = 1'b0;
		driver_door = 1'b1;
		#20;
		ignition = 1'b1;
		#10;
		ignition = 1'b0;

		// expect instant transition
		reset_fsm;

		#20;
		// does nothing
		passenger_door = 1'b1;

		#10;
		expired = 1'b1;
		#20;
		passenger_door = 1'b0;
		driver_door    = 1'b0;
		expired     = 1'b0;

		reset_fsm;

		passenger_door = 1'b1;

		// does nothing
		driver_door = 1'b1;
		#10;
		expired = 1'b1;
		#5;
		expired = 1'b0;
		#10;
		expired = 1'b1;
		#20;
		driver_door = 1'b0;
		#10;
		passenger_door = 1'b0;
		#10;
		reset_fsm;

		passenger_door = 1'b1;
		#10;
		// does nothing
		driver_door = 1'b1;
		#10;
		expired = 1'b1;
		#5;
		expired = 1'b0;
		#10;
		ignition = 1'b1;
		#20;
		$finish;


	end

	always #5 clk = ~clk;

	task reset_fsm;
	begin
		#10;
		program = 1'b1;
		expired = 1'b0;
		#10;
		program = 1'b0;
		#10;
	end
	endtask
endmodule