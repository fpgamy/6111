module problem2 #(parameter NONE_OF_THEM_ARE_ONE = 0) (
	input      [7:0] problem_a,
	output     [3:0] solution_a,

	input     [15:0] problem_b_1,
	input     [15:0] problem_b_2,
	output    [16:0] solution_b,

	input      [1:0] problem_c_0,
	input      [1:0] problem_c_1,
	input      [1:0] problem_c_2,
	input      [1:0] problem_c_3,
	output     [1:0] solution_c,

	input      [1:0] problem_d_0,
	input      [1:0] problem_d_1,
	input      [1:0] problem_d_2,
	input      [1:0] problem_d_3,
	output reg [1:0] solution_d
	);
	
	assign solution_a = (problem_a / 16);

	assign solution_b = problem_b_1 + problem_b_2;

	assign solution_c = (problem_c_3 == 1) ? (2'd3) : ( (problem_c_2 == 1) ? (2'd2) : ( (problem_c_1 == 1) ? (2'd1) : ( (problem_c_0 == 1) ? (2'd0) : (NONE_OF_THEM_ARE_ONE) ) ) );

	wire [3:0] is_one;
	assign is_one = {(problem_d_3 == 1), ((problem_d_2 == 1) & ~(problem_d_3 == 1)), ((problem_d_1 == 1) & ~(problem_d_3 == 1) & ~(problem_d_2 == 1)), ((problem_d_0 == 1) & ~(problem_d_3 == 1) & ~(problem_d_2 == 1) & ~(problem_d_1 == 1))};


	localparam I3_IS_ONE = 4'b1000;
	localparam I2_IS_ONE = 4'b0100;
	localparam I1_IS_ONE = 4'b0010;
	localparam I0_IS_ONE = 4'b0001;

	always @(*) 
	begin
		case (is_one)
			I3_IS_ONE: solution_d = 2'd3;
			I2_IS_ONE: solution_d = 2'd2;
			I1_IS_ONE: solution_d = 2'd1;
			I0_IS_ONE: solution_d = 2'd0;
			default: solution_d = NONE_OF_THEM_ARE_ONE;
		endcase
	end

endmodule
