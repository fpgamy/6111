module fec_pipelined_tb;
	reg clk = 1'b0;
	reg  [31:0] data = 32'h03010203;
	wire [95:0] correct_fec = 96'h000E8C037C0DF00E828C0E5E;
	wire correct;

	assign correct = (correct_fec == fec);
	
	reg   start;
	reg   serial;
	wire  done;
	wire  [95:0] fec;
	wire  [179:0] fsm_state;
	wire  [5:0] cycle_count;
    reg         data_clk;

	fec_pipelined fp1(
						.clk_in(clk),
						.start_in(start),
						.data_in(serial),
						.done_out(done),
						.fec_out(fec),
						.fsm_state_out(fsm_state),
						.cycle_count_out(cycle_count)
					);

   initial 
   begin   // system clock
      forever #5 clk = !clk;
   end
      
   initial 
   begin   // data_clk, ensures setup time met               
      #2
      forever #5 data_clk = !data_clk;
   end
	
	integer i;

	initial
	begin		
		$dumpfile("fec_test.vcd");
		$dumpvars(0, fec_pipelined_tb);
		clk = 0;
		data_clk = 0;
		start = 0;
		serial = 0;
		// Wait 100 ns for global reset to finish
		#100;

		// Add stimulus here
		start=1;
		#10 start = 0;
		start=1;
      	#10 
      	start = 0;
		#5;	// change if necessary for your design

		for (i=0; i<32; i=i+1)
		begin
			serial = data[31];
			@(posedge data_clk) data = {data[30:0],1'b0};     
		end

		#100;
		$finish;
	end

endmodule