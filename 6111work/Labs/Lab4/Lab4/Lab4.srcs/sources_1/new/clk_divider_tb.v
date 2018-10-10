module clk_divider_tb;
	reg clk   = 1'b0;
	reg reset = 1'b1;
	reg en    = 1'b0;
	wire clk_divided;

	clk_divider clkdiv1(.clk_in(clk), .reset_in(reset), .en_in(en), .clk_out(clk_divided));

	initial
	begin
		$dumpfile("test.vcd");
		$dumpvars(0, clk_divider_tb);
		reset = 1'b1;
		en    = 1'b0;
		#10;
		reset = 1'b0;
		#10;
		en    = 1'b1;
		#500;
		$finish;
	end

	always #5 clk = ~clk;
endmodule