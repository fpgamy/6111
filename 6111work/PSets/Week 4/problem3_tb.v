module problem3_tb;
	
	reg [15:0] data;
	wire even_parity;

	problem3 p3(
					.data_in(data),
					.even_parity_out(even_parity)
				);

	initial
	begin
	    $dumpfile("test.vcd");
		$dumpvars(0,problem3_tb);
		#10;

		data = 16'b11111;

		#10;

		data = 16'b1111;

		#10;
	end 
endmodule