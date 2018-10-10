module time_controller_tb;
	reg  clk             = 1'b0;
	reg  res             = 1'b1;
	reg  set             = 1'b0;
	reg  [1:0] sel       = 2'b00;
	reg  [3:0] value     = 4'b0;

	wire [3:0] value_timer;

	time_controller tc1(	
							.clk_in(clk), 
							.reset_in(res),
							.set_in(set),
							.sel_in(sel),
							.value_in(value),
							.value_out(value_timer)
					    );

	initial
	begin
		$dumpfile("timer_test.vcd");
		$dumpvars(0, time_controller_tb);
		value    = 4'b0;
		res      = 1'b1;
		set      = 1'b0;
		sel      = 2'b0;
		#10;
		res      = 1'b0;
		#10;
		sel      = 2'b01;
		value    = 4'b1010;
		#10;
		sel      = 2'b10;
		value    = 4'b1110;
		#10;
		sel      = 2'b11;
		value    = 4'b1111;
		#10;
		set      = 1'b1;
		sel      = 2'b00;
		value    = 4'b1010;
		#10
		set      = 1'b0;
		sel      = 2'b00;
		value    = 4'b1010;
		#10;
		set      = 1'b1;
		sel      = 2'b01;
		value    = 4'b1110;
		#10;
		set      = 1'b0;
		sel      = 2'b01;
		#10;
		set      = 1'b1;
		sel      = 2'b10;
		value    = 4'b0010;
		#10;
		set      = 1'b0;
		sel      = 2'b10;
		#10;
		set      = 1'b1;
		sel      = 2'b11;
		value    = 4'b1111;
		#10;
		set      = 1'b0;
		sel      = 2'b11;
		#500;
		$finish;
	end

	always #5 clk = ~clk;
endmodule