module problem2_tb;

	wire [7:0] problem_a;
	wire [3:0] solution_a;
	wire [3:0] solution_a2;
	wire [15:0] problem_b_1;
	wire [15:0] problem_b_2;
	wire [16:0] solution_b;
	wire [16:0] solution_b2;
	wire [1:0] problem_c_0;
	wire [1:0] problem_c_1;
	wire [1:0] problem_c_2;
	wire [1:0] problem_c_3;
	wire [1:0] solution_c;
	wire [1:0] solution_c2;
	wire [1:0] problem_d_0;
	wire [1:0] problem_d_1;
	wire [1:0] problem_d_2;
	wire [1:0] problem_d_3;
	wire [1:0] solution_d;
	wire [1:0] solution_d2;

	reg [7:0]  op1;
	reg [15:0] op2a;
	reg [15:0] op2b;

	reg [1:0] i0;
	reg [1:0] i1;
	reg [1:0] i2;
	reg [1:0] i3;

	assign problem_a = op1;
	assign problem_b_1 = op2a;
	assign problem_b_2 = op2b;
	assign problem_c_0 = i0;
	assign problem_c_1 = i1;
	assign problem_c_2 = i2;
	assign problem_c_3 = i3;
	assign problem_d_0 = i0;
	assign problem_d_1 = i1;
	assign problem_d_2 = i2;
	assign problem_d_3 = i3;

	problem2 #(.SIGNED_INPUT(0)) p2a(
										.problem_a(problem_a),
										.solution_a(solution_a),
										.problem_b_1(problem_b_1),
										.problem_b_2(problem_b_2),
										.solution_b(solution_b),
										.problem_c_0(problem_c_0),
										.problem_c_1(problem_c_1),
										.problem_c_2(problem_c_2),
										.problem_c_3(problem_c_3),
										.solution_c(solution_c),
										.problem_d_0(problem_d_0),
										.problem_d_1(problem_d_1),
										.problem_d_2(problem_d_2),
										.problem_d_3(problem_d_3),
										.solution_d(solution_d)
									);

	problem2 #(.SIGNED_INPUT(1), .NONE_OF_THEM_ARE_ONE(3)) p2b(
										.problem_a(problem_a),
										.solution_a(solution_a2),
										.problem_b_1(problem_b_1),
										.problem_b_2(problem_b_2),
										.solution_b(solution_b2),
										.problem_c_0(problem_c_0),
										.problem_c_1(problem_c_1),
										.problem_c_2(problem_c_2),
										.problem_c_3(problem_c_3),
										.solution_c(solution_c2),
										.problem_d_0(problem_d_0),
										.problem_d_1(problem_d_1),
										.problem_d_2(problem_d_2),
										.problem_d_3(problem_d_3),
										.solution_d(solution_d2)
									);

	initial
	begin
	    $dumpfile("test.vcd");
		$dumpvars(0,problem2_tb);
		#10;

		op1 = 8'd16;
		op2a = 16'd5;
		op2b = 16'd127;
		i0 = 1;
		i1 = 1;
		i2 = 1;
		i3 = 1;
		#10;

		op1  = 8'b10100111;
		op2a = 16'd456;
		op2b = 16'd123;
		i0 = 1;
		i1 = 3;
		i2 = 3;
		i3 = 3;

		#10;
		i0 = 1;
		i1 = 1;
		i2 = 3;
		i3 = 3;

		#10;
		i0 = 1;
		i1 = 0;
		i2 = 1;
		i3 = 0;

		#10;
	end

endmodule
