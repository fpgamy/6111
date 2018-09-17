module problem3 #(parameter WIDTH = 16) (
	input [WIDTH-1:0] data_in,
	output even_parity_out
	);
	
	assign even_parity_out = ~^(data_in); 
endmodule