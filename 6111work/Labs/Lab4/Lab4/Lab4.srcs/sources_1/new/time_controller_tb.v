module time_controller_tb;
	reg clk   = 1'b0;
	reg res   = 1'b0;
	reg [3:0] value_in = 4'b0;
	wire expired;

	time_controller tc1(	
							.clk_in(clk), 
							.reset_in(res),
							.set_in(),
							.sel_in(),
							.value_in(),
							.value_out()
					    )

	initial
	begin
		$dumpfile("test.vcd");
		$dumpvars(0, time_controller_tb);
		value_in = 4'b0;
		start    = 1'b0;
		#10;
		value_in = 4'd10;
		#10;
		start    = 1'b1;
		#500;
		$finish;
	end

	always #5 clk = ~clk;
endmodule