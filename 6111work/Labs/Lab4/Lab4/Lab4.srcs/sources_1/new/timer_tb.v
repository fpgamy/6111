module timer_tb;
	reg clk   = 1'b0;
	reg start    = 1'b0;
	reg [3:0] value = 4'b0;
	wire expired;

	timer t1(.clk_1hz_in(clk), .start_in(start), .value_in(value), .expire_out(expired));

	initial
	begin
		$dumpfile("timer_test.vcd");
		$dumpvars(0, timer_tb);
		value = 4'b0;
		start    = 1'b0;
		#10;
		value = 4'd10;
		#10;
		start    = 1'b1;
		#500;
		start    = 1'b0;
		#500;
		value = 4'd2;
		start    = 1'b1;
		#1000;
		$finish;
	end

	always #5 clk = ~clk;
endmodule