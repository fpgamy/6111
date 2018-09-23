`define assert(signal, value) \
        if (signal !== value) \
        begin \
            $display("ASSERTION FAILED in %m at time %0t: signal != value", $time); \
        end

module mem_controller_tb;
	reg        clk;
	reg        req;
	wire       ras;
	wire       mux;
	wire       cas;
	reg [2:0]  clk_counter;

	initial
	begin
	    $dumpfile("test.vcd");
		$dumpvars(0,mem_controller_tb);
		clk         = 0;
		clk_counter = 0;
		req         = 0;
		
		#2;
		req = 1;
		
		#11;
		req = 0;
		#50;
		$finish;
	end


	mem_controller m1(
						.clk_in    (clk),
						.req_in    (req),
						.ras_out   (ras),
						.mux_out   (mux),
						.cas_out   (cas)
						);

	always @(posedge clk)
	begin
		if ((clk_counter > 0) | ((req == 1) & (clk_counter == 0)))
		begin
			clk_counter = clk_counter + 1;

			if (clk_counter == 1)
			begin
				`assert(ras, 0);
				`assert(mux, 0);
				`assert(cas, 1);				
			end
			else if (clk_counter == 2)
			begin
				`assert(ras, 0);
				`assert(mux, 1);
				`assert(cas, 1);				
			end
			else if (clk_counter == 3)
			begin
				`assert(ras, 0);
				`assert(mux, 1);
				`assert(cas, 0);
			end
			else
			begin
				`assert(ras, 0);
				`assert(mux, 1);
				`assert(cas, 0);
				clk_counter = 0;
			end
		end
	end

	always #5 clk = ~clk;

endmodule