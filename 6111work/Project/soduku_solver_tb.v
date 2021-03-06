module soduku_solver_tb;
//
// INCLUDES
//
	`include "common_lib.v"
	`include "soduku_tb_lib.v"

//
// VARIABLES
//
	reg        clk;
	reg        reset;

	// 2D array of 4 bit BCD values
	// Contains all the numbers in unsolved board
	// Number = 1 implies contains value

	reg  [4*(GRID_SIZE)*(GRID_SIZE)-1:0] test_input;
	wire [4*(GRID_SIZE)*(GRID_SIZE)-1:0] test_output;

	// 2D array of 4 bit BCD values
	// Contains all the numbers in solved board
	wire [3:0] solved [(GRID_SIZE-1):0] [(GRID_SIZE-1):0];
	wire done;
	wire invalid;

	reg  [15:0] test_counter;
	reg  [15:0] pass_counter;

	reg [127:0] clk_counter;
	reg [127:0] clk_counter_start;
	reg [127:0] clk_counter_end;

	generate
		genvar row_genvar;
		genvar col_genvar;

		for (row_genvar = 0; row_genvar < GRID_SIZE; row_genvar = row_genvar + 1)
		begin
			for (col_genvar = 0; col_genvar < GRID_SIZE; col_genvar = col_genvar + 1)
			begin
				assign solved[row_genvar][col_genvar] = test_output[(4*GRID_SIZE*(GRID_SIZE-row_genvar)-(col_genvar*4)-1):(4*GRIDSIZE*(GRID_SIZE-row_genvar)-(col_genvar*4)-4)];
			end
		end

	endgenerate

	soduku_solver ss1   (
							.clk_in     (clk)        ,
							.reset_in   (reset)      ,
							.board_in   (test_input) ,
							.board_out  (test_output),
							.done_out   (done)
						);
	initial
	begin
	    $dumpfile("test.vcd");
		$dumpvars(0,soduku_solver_tb);
		clk_counter 		= 0;
		clk_counter_start 	= 0;
		clk_counter_end 	= 0;
		test_counter        = 0;
		pass_counter        = 0;
		clk         = 0;
		reset       = 1;
		test_input  =  {4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0,
					    4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0,
					    4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0,
					    4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0,
					    4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0,
					    4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0,
					    4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0,
					    4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0};
		#10;
		reset       = 0;
		#10;

`ifdef BASIC

		test_input  =  {4'd2, 4'd5, 4'd4, 4'd8, 4'd1, 4'd3, 4'd6, 4'd9, 4'd7,
					    4'd7, 4'd1, 4'd9, 4'd6, 4'd2, 4'd5, 4'd8, 4'd3, 4'd4,
					    4'd8, 4'd6, 4'd3, 4'd4, 4'd7, 4'd9, 4'd1, 4'd2, 4'd5,
					    4'd4, 4'd3, 4'd5, 4'd9, 4'd6, 4'd1, 4'd7, 4'd8, 4'd2,
					    4'd1, 4'd2, 4'd7, 4'd5, 4'd4, 4'd8, 4'd9, 4'd6, 4'd3,
					    4'd6, 4'd9, 4'd8, 4'd7, 4'd3, 4'd2, 4'd4, 4'd5, 4'd1,
					    4'd3, 4'd8, 4'd2, 4'd1, 4'd9, 4'd4, 4'd5, 4'd7, 4'd6,
					    4'd5, 4'd7, 4'd1, 4'd2, 4'd8, 4'd6, 4'd3, 4'd4, 4'd9,
					    4'd9, 4'd4, 4'd6, 4'd3, 4'd5, 4'd7, 4'd2, 4'd1, 4'd8};
		test_solver;

		test_input  =  {4'd0, 4'd5, 4'd4, 4'd8, 4'd1, 4'd3, 4'd6, 4'd9, 4'd7,
					    4'd7, 4'd1, 4'd9, 4'd6, 4'd2, 4'd5, 4'd8, 4'd3, 4'd4,
					    4'd8, 4'd6, 4'd3, 4'd4, 4'd7, 4'd9, 4'd1, 4'd2, 4'd5,
					    4'd4, 4'd3, 4'd5, 4'd9, 4'd6, 4'd1, 4'd7, 4'd8, 4'd2,
					    4'd1, 4'd2, 4'd7, 4'd5, 4'd4, 4'd8, 4'd9, 4'd6, 4'd3,
					    4'd6, 4'd9, 4'd8, 4'd7, 4'd3, 4'd2, 4'd4, 4'd5, 4'd1,
					    4'd3, 4'd8, 4'd2, 4'd1, 4'd9, 4'd4, 4'd5, 4'd7, 4'd6,
					    4'd5, 4'd7, 4'd1, 4'd2, 4'd8, 4'd6, 4'd3, 4'd4, 4'd9,
					    4'd9, 4'd4, 4'd6, 4'd3, 4'd5, 4'd7, 4'd2, 4'd1, 4'd8};
		test_solver;

		test_input  =  {4'd0, 4'd5, 4'd4, 4'd8, 4'd1, 4'd3, 4'd6, 4'd9, 4'd7,
					    4'd7, 4'd1, 4'd9, 4'd6, 4'd2, 4'd5, 4'd8, 4'd3, 4'd4,
					    4'd8, 4'd6, 4'd3, 4'd4, 4'd7, 4'd9, 4'd1, 4'd2, 4'd5,
					    4'd4, 4'd3, 4'd5, 4'd9, 4'd6, 4'd1, 4'd7, 4'd8, 4'd2,
					    4'd1, 4'd2, 4'd7, 4'd5, 4'd4, 4'd8, 4'd9, 4'd6, 4'd3,
					    4'd6, 4'd9, 4'd8, 4'd7, 4'd3, 4'd0, 4'd4, 4'd5, 4'd1,
					    4'd3, 4'd8, 4'd2, 4'd1, 4'd9, 4'd4, 4'd5, 4'd7, 4'd6,
					    4'd5, 4'd7, 4'd1, 4'd2, 4'd8, 4'd6, 4'd3, 4'd4, 4'd9,
					    4'd9, 4'd4, 4'd6, 4'd3, 4'd5, 4'd7, 4'd2, 4'd1, 4'd8};
		test_solver;

		test_input  =  {4'd0, 4'd5, 4'd4, 4'd8, 4'd1, 4'd3, 4'd6, 4'd9, 4'd7,
					    4'd7, 4'd1, 4'd9, 4'd6, 4'd2, 4'd5, 4'd8, 4'd3, 4'd4,
					    4'd8, 4'd6, 4'd3, 4'd4, 4'd7, 4'd9, 4'd1, 4'd2, 4'd5,
					    4'd4, 4'd3, 4'd5, 4'd9, 4'd6, 4'd1, 4'd7, 4'd8, 4'd2,
					    4'd1, 4'd2, 4'd7, 4'd5, 4'd4, 4'd8, 4'd9, 4'd6, 4'd3,
					    4'd6, 4'd9, 4'd8, 4'd7, 4'd3, 4'd0, 4'd4, 4'd5, 4'd1,
					    4'd3, 4'd8, 4'd2, 4'd1, 4'd9, 4'd4, 4'd5, 4'd7, 4'd6,
					    4'd5, 4'd7, 4'd1, 4'd2, 4'd8, 4'd6, 4'd3, 4'd4, 4'd9,
					    4'd9, 4'd4, 4'd6, 4'd3, 4'd5, 4'd0, 4'd2, 4'd1, 4'd8};
		test_solver;

		test_input  =  {4'd2, 4'd5, 4'd4, 4'd8, 4'd1, 4'd3, 4'd6, 4'd9, 4'd7,
					    4'd7, 4'd1, 4'd9, 4'd6, 4'd2, 4'd5, 4'd8, 4'd3, 4'd4,
					    4'd8, 4'd6, 4'd3, 4'd4, 4'd7, 4'd9, 4'd1, 4'd2, 4'd5,
					    4'd4, 4'd3, 4'd5, 4'd9, 4'd6, 4'd1, 4'd7, 4'd8, 4'd2,
					    4'd1, 4'd2, 4'd7, 4'd5, 4'd4, 4'd8, 4'd9, 4'd6, 4'd3,
					    4'd6, 4'd9, 4'd8, 4'd7, 4'd3, 4'd2, 4'd4, 4'd5, 4'd1,
					    4'd3, 4'd8, 4'd2, 4'd1, 4'd9, 4'd4, 4'd5, 4'd7, 4'd6,
					    4'd5, 4'd7, 4'd1, 4'd2, 4'd8, 4'd6, 4'd3, 4'd4, 4'd9,
					    4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd8};
		test_solver;

		test_input  =  {4'd2, 4'd5, 4'd4, 4'd8, 4'd1, 4'd3, 4'd6, 4'd9, 4'd0,
					    4'd7, 4'd1, 4'd9, 4'd6, 4'd2, 4'd5, 4'd8, 4'd3, 4'd0,
					    4'd8, 4'd6, 4'd3, 4'd4, 4'd7, 4'd9, 4'd1, 4'd2, 4'd0,
					    4'd4, 4'd3, 4'd5, 4'd9, 4'd6, 4'd1, 4'd7, 4'd8, 4'd0,
					    4'd1, 4'd2, 4'd7, 4'd5, 4'd4, 4'd8, 4'd9, 4'd6, 4'd0,
					    4'd6, 4'd9, 4'd8, 4'd7, 4'd3, 4'd2, 4'd4, 4'd5, 4'd0,
					    4'd3, 4'd8, 4'd2, 4'd1, 4'd9, 4'd4, 4'd5, 4'd7, 4'd0,
					    4'd5, 4'd7, 4'd1, 4'd2, 4'd8, 4'd6, 4'd3, 4'd4, 4'd0,
					    4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd8};
		test_solver;

		test_input  =  {4'd2, 4'd5, 4'd4, 4'd8, 4'd1, 4'd3, 4'd6, 4'd9, 4'd7,
					    4'd7, 4'd1, 4'd9, 4'd6, 4'd2, 4'd5, 4'd8, 4'd3, 4'd4,
					    4'd8, 4'd6, 4'd0, 4'd0, 4'd7, 4'd9, 4'd0, 4'd2, 4'd5,
					    4'd4, 4'd3, 4'd0, 4'd9, 4'd6, 4'd1, 4'd0, 4'd8, 4'd2,
					    4'd1, 4'd2, 4'd7, 4'd5, 4'd4, 4'd8, 4'd9, 4'd6, 4'd3,
					    4'd6, 4'd9, 4'd8, 4'd7, 4'd3, 4'd0, 4'd4, 4'd5, 4'd1,
					    4'd3, 4'd8, 4'd0, 4'd1, 4'd9, 4'd0, 4'd0, 4'd7, 4'd6,
					    4'd5, 4'd7, 4'd1, 4'd2, 4'd8, 4'd6, 4'd3, 4'd4, 4'd9,
					    4'd9, 4'd4, 4'd6, 4'd3, 4'd5, 4'd7, 4'd2, 4'd1, 4'd8};
		test_solver;

`endif

`ifdef EASY

		test_input  =  {4'd0, 4'd5, 4'd0, 4'd0, 4'd3, 4'd9, 4'd0, 4'd8, 4'd0,
					    4'd0, 4'd0, 4'd6, 4'd7, 4'd0, 4'd0, 4'd5, 4'd0, 4'd3,
					    4'd0, 4'd0, 4'd1, 4'd8, 4'd0, 4'd0, 4'd0, 4'd0, 4'd4,
					    4'd0, 4'd0, 4'd3, 4'd1, 4'd8, 4'd0, 4'd0, 4'd7, 4'd0,
					    4'd1, 4'd0, 4'd9, 4'd5, 4'd0, 4'd3, 4'd2, 4'd0, 4'd8,
					    4'd0, 4'd8, 4'd0, 4'd0, 4'd9, 4'd4, 4'd3, 4'd0, 4'd0,
					    4'd2, 4'd0, 4'd0, 4'd0, 4'd0, 4'd6, 4'd8, 4'd0, 4'd0,
					    4'd3, 4'd0, 4'd8, 4'd0, 4'd0, 4'd7, 4'd4, 4'd0, 4'd0,
					    4'd0, 4'd9, 4'd0, 4'd3, 4'd2, 4'd0, 4'd0, 4'd5, 4'd0};
		test_solver;

		test_input  =  {4'd0, 4'd1, 4'd0, 4'd0, 4'd0, 4'd5, 4'd8, 4'd0, 4'd0,
						4'd5, 4'd4, 4'd3, 4'd0, 4'd2, 4'd0, 4'd0, 4'd0, 4'd6,
						4'd7, 4'd0, 4'd8, 4'd0, 4'd0, 4'd6, 4'd0, 4'd0, 4'd0,
						4'd0, 4'd0, 4'd1, 4'd3, 4'd0, 4'd0, 4'd7, 4'd0, 4'd8,
						4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd5,
						4'd8, 4'd7, 4'd0, 4'd4, 4'd0, 4'd0, 4'd2, 4'd1, 4'd0,
						4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd7, 4'd0,
						4'd0, 4'd0, 4'd5, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd2,
						4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0};
		test_solver;

`endif

`ifdef INTERMEDIATE

		test_input  =  {4'd0, 4'd4, 4'd0, 4'd8, 4'd0, 4'd0, 4'd5, 4'd7, 4'd0,
						4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd2, 4'd0, 4'd4,
						4'd0, 4'd8, 4'd0, 4'd0, 4'd1, 4'd4, 4'd0, 4'd0, 4'd0,
						4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd3, 4'd0, 4'd6,
						4'd0, 4'd0, 4'd3, 4'd1, 4'd0, 4'd8, 4'd7, 4'd0, 4'd0,
						4'd0, 4'd7, 4'd0, 4'd0, 4'd2, 4'd0, 4'd0, 4'd1, 4'd0,
						4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd3, 4'd0, 4'd6, 4'd2,
						4'd0, 4'd1, 4'd0, 4'd2, 4'd0, 4'd6, 4'd4, 4'd5, 4'd3,
						4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0};
		test_solver;

		test_input  =  {4'd9, 4'd0, 4'd0, 4'd0, 4'd0, 4'd3, 4'd0, 4'd0, 4'd0,
						4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0,
						4'd4, 4'd0, 4'd0, 4'd9, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0,
						4'd7, 4'd2, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd6,
						4'd0, 4'd0, 4'd3, 4'd0, 4'd0, 4'd7, 4'd2, 4'd5, 4'd0,
						4'd0, 4'd0, 4'd5, 4'd1, 4'd0, 4'd0, 4'd0, 4'd9, 4'd4,
						4'd0, 4'd6, 4'd9, 4'd0, 4'd0, 4'd5, 4'd0, 4'd4, 4'd0,
						4'd0, 4'd0, 4'd0, 4'd7, 4'd0, 4'd0, 4'd1, 4'd0, 4'd0,
						4'd0, 4'd0, 4'd0, 4'd6, 4'd0, 4'd0, 4'd5, 4'd0, 4'd0};

		test_solver;

		test_input  =  {4'd4, 4'd1, 4'd5, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0,
						4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd3, 4'd0, 4'd0, 4'd8,
						4'd0, 4'd0, 4'd6, 4'd0, 4'd0, 4'd0, 4'd0, 4'd7, 4'd0,
						4'd0, 4'd0, 4'd3, 4'd0, 4'd1, 4'd0, 4'd6, 4'd0, 4'd9,
						4'd8, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0,
						4'd0, 4'd5, 4'd2, 4'd0, 4'd6, 4'd0, 4'd3, 4'd0, 4'd0,
						4'd9, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd2, 4'd0, 4'd0,
						4'd0, 4'd0, 4'd0, 4'd3, 4'd2, 4'd0, 4'd4, 4'd0, 4'd0,
						4'd0, 4'd0, 4'd0, 4'd4, 4'd0, 4'd0, 4'd0, 4'd0, 4'd6};
		test_solver;

		test_input  =  {4'd8, 4'd0, 4'd0, 4'd0, 4'd0, 4'd5, 4'd9, 4'd1, 4'd2,
					    4'd0, 4'd0, 4'd0, 4'd8, 4'd9, 4'd1, 4'd5, 4'd6, 4'd0,
					    4'd5, 4'd1, 4'd9, 4'd0, 4'd2, 4'd6, 4'd3, 4'd8, 4'd0,
					    4'd6, 4'd4, 4'd2, 4'd5, 4'd7, 4'd3, 4'd8, 4'd9, 4'd1,
					    4'd0, 4'd5, 4'd0, 4'd0, 4'd0, 4'd0, 4'd2, 4'd3, 4'd6,
					    4'd0, 4'd3, 4'd0, 4'd2, 4'd6, 4'd0, 4'd7, 4'd4, 4'd5,
					    4'd0, 4'd0, 4'd5, 4'd0, 4'd8, 4'd0, 4'd4, 4'd7, 4'd9,
					    4'd0, 4'd8, 4'd0, 4'd9, 4'd0, 4'd0, 4'd0, 4'd0, 4'd3,
					    4'd4, 4'd9, 4'd0, 4'd6, 4'd0, 4'd0, 4'd1, 4'd0, 4'd8};
		test_solver;

		test_input  =  {4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd6, 4'd0, 4'd1,
						4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd8, 4'd3, 4'd4, 4'd7,
						4'd0, 4'd7, 4'd0, 4'd0, 4'd0, 4'd3, 4'd8, 4'd2, 4'd0,
						4'd4, 4'd0, 4'd0, 4'd0, 4'd8, 4'd7, 4'd2, 4'd0, 4'd0,
						4'd3, 4'd0, 4'd0, 4'd0, 4'd0, 4'd4, 4'd0, 4'd0, 4'd0,
						4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd8, 4'd0,
						4'd8, 4'd1, 4'd0, 4'd0, 4'd3, 4'd0, 4'd0, 4'd0, 4'd0,
						4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd5, 4'd0, 4'd0, 4'd0,
						4'd0, 4'd0, 4'd7, 4'd0, 4'd0, 4'd2, 4'd4, 4'd0, 4'd6};
		test_solver;

		test_input  =  {4'd0, 4'd0, 4'd9, 4'd5, 4'd0, 4'd0, 4'd0, 4'd3, 4'd0,
						4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd5, 4'd6, 4'd1,
						4'd0, 4'd0, 4'd4, 4'd0, 4'd0, 4'd0, 4'd0, 4'd9, 4'd0,
						4'd0, 4'd5, 4'd0, 4'd0, 4'd9, 4'd0, 4'd4, 4'd2, 4'd0,
						4'd0, 4'd0, 4'd8, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd9,
						4'd0, 4'd1, 4'd0, 4'd2, 4'd0, 4'd0, 4'd0, 4'd0, 4'd6,
						4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd4, 4'd0, 4'd0, 4'd0,
						4'd8, 4'd9, 4'd0, 4'd1, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0,
						4'd3, 4'd0, 4'd0, 4'd0, 4'd2, 4'd0, 4'd1, 4'd0, 4'd0};
		test_solver;
`endif

`ifdef HARD
		test_input  = {4'd0, 4'd2, 4'd0, 4'd0, 4'd9, 4'd0, 4'd0, 4'd0, 4'd0,
						4'd1, 4'd6, 4'd8, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0,
						4'd4, 4'd0, 4'd0, 4'd2, 4'd0, 4'd3, 4'd0, 4'd0, 4'd0,
						4'd8, 4'd0, 4'd0, 4'd0, 4'd0, 4'd9, 4'd0, 4'd0, 4'd0,
						4'd0, 4'd0, 4'd1, 4'd0, 4'd0, 4'd0, 4'd7, 4'd0, 4'd0,
						4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd4, 4'd6,
						4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd4, 4'd0, 4'd2, 4'd3,
						4'd0, 4'd7, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd9,
						4'd9, 4'd0, 4'd0, 4'd0, 4'd0, 4'd2, 4'd0, 4'd0, 4'd8};
		test_solver;

		test_input  =  {4'd5, 4'd0, 4'd0, 4'd0, 4'd8, 4'd0, 4'd0, 4'd0, 4'd3,
						4'd0, 4'd9, 4'd0, 4'd2, 4'd1, 4'd0, 4'd7, 4'd0, 4'd0,
						4'd0, 4'd1, 4'd0, 4'd0, 4'd3, 4'd0, 4'd2, 4'd0, 4'd6,
						4'd0, 4'd6, 4'd1, 4'd0, 4'd0, 4'd0, 4'd9, 4'd0, 4'd0,
						4'd0, 4'd0, 4'd9, 4'd7, 4'd0, 4'd0, 4'd6, 4'd0, 4'd0,
						4'd3, 4'd8, 4'd0, 4'd0, 4'd9, 4'd0, 4'd0, 4'd0, 4'd2,
						4'd0, 4'd0, 4'd5, 4'd8, 4'd0, 4'd0, 4'd0, 4'd0, 4'd9,
						4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd1, 4'd0, 4'd0,
						4'd0, 4'd0, 4'd0, 4'd0, 4'd2, 4'd0, 4'd0, 4'd0, 4'd0};
		test_solver;

		test_input  =  {4'd4, 4'd5, 4'd7, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0,
						4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd5,
						4'd0, 4'd0, 4'd0, 4'd0, 4'd1, 4'd0, 4'd0, 4'd0, 4'd0,
						4'd2, 4'd9, 4'd0, 4'd0, 4'd0, 4'd7, 4'd0, 4'd0, 4'd0,
						4'd0, 4'd7, 4'd0, 4'd0, 4'd5, 4'd0, 4'd0, 4'd0, 4'd1,
						4'd0, 4'd3, 4'd0, 4'd0, 4'd0, 4'd2, 4'd6, 4'd0, 4'd4,
						4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd3, 4'd0, 4'd0,
						4'd0, 4'd0, 4'd1, 4'd0, 4'd0, 4'd5, 4'd0, 4'd9, 4'd7,
						4'd0, 4'd0, 4'd6, 4'd2, 4'd0, 4'd0, 4'd1, 4'd0, 4'd0};
		test_solver;

		test_input  =  {4'd0, 4'd0, 4'd0, 4'd7, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0,
						4'd2, 4'd0, 4'd0, 4'd0, 4'd6, 4'd0, 4'd0, 4'd0, 4'd1,
						4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd8, 4'd0, 4'd0, 4'd0,
						4'd9, 4'd0, 4'd0, 4'd8, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0,
						4'd0, 4'd0, 4'd1, 4'd0, 4'd7, 4'd5, 4'd0, 4'd9, 4'd0,
						4'd7, 4'd0, 4'd5, 4'd4, 4'd0, 4'd1, 4'd0, 4'd2, 4'd8,
						4'd1, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd9, 4'd0, 4'd0,
						4'd0, 4'd8, 4'd0, 4'd0, 4'd0, 4'd4, 4'd0, 4'd1, 4'd5,
						4'd4, 4'd5, 4'd0, 4'd0, 4'd0, 4'd2, 4'd0, 4'd7, 4'd0};
		test_solver;

		test_input  =  {4'd0, 4'd7, 4'd0, 4'd0, 4'd0, 4'd0, 4'd1, 4'd0, 4'd3,
						4'd2, 4'd0, 4'd3, 4'd0, 4'd0, 4'd0, 4'd7, 4'd0, 4'd0,
						4'd1, 4'd0, 4'd5, 4'd0, 4'd7, 4'd0, 4'd0, 4'd0, 4'd0,
						4'd0, 4'd0, 4'd2, 4'd6, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0,
						4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd5, 4'd6, 4'd9, 4'd1,
						4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd3, 4'd0,
						4'd0, 4'd4, 4'd0, 4'd3, 4'd1, 4'd0, 4'd9, 4'd0, 4'd2,
						4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0,
						4'd7, 4'd5, 4'd0, 4'd0, 4'd0, 4'd6, 4'd0, 4'd0, 4'd0};
		test_solver;


		test_input  =  {4'd8, 4'd0, 4'd0, 4'd4, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0,
						4'd0, 4'd0, 4'd7, 4'd0, 4'd2, 4'd0, 4'd9, 4'd0, 4'd0,
						4'd0, 4'd0, 4'd0, 4'd0, 4'd1, 4'd5, 4'd7, 4'd0, 4'd8,
						4'd0, 4'd0, 4'd4, 4'd0, 4'd5, 4'd0, 4'd0, 4'd8, 4'd0,
						4'd5, 4'd0, 4'd1, 4'd2, 4'd0, 4'd4, 4'd6, 4'd0, 4'd7,
						4'd0, 4'd6, 4'd0, 4'd0, 4'd7, 4'd0, 4'd4, 4'd0, 4'd0,
						4'd3, 4'd0, 4'd9, 4'd1, 4'd8, 4'd0, 4'd0, 4'd0, 4'd0,
						4'd0, 4'd0, 4'd2, 4'd0, 4'd4, 4'd0, 4'd8, 4'd0, 4'd0,
						4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd3, 4'd0, 4'd0, 4'd2};
		test_solver;

`endif

`ifdef WHS
		// "Worlds hardest soduku"
		test_input  =  {4'd0, 4'd0, 4'd4, 4'd0, 4'd0, 4'd0, 4'd0, 4'd9, 4'd0,
					    4'd0, 4'd1, 4'd0, 4'd0, 4'd0, 4'd5, 4'd8, 4'd0, 4'd0,
					    4'd8, 4'd6, 4'd0, 4'd0, 4'd0, 4'd0, 4'd1, 4'd0, 4'd0,
					    4'd0, 4'd3, 4'd0, 4'd0, 4'd0, 4'd1, 4'd0, 4'd0, 4'd0,
					    4'd0, 4'd0, 4'd7, 4'd5, 4'd4, 4'd0, 4'd0, 4'd0, 4'd0,
					    4'd0, 4'd0, 4'd0, 4'd7, 4'd0, 4'd0, 4'd0, 4'd5, 4'd0,
					    4'd0, 4'd0, 4'd2, 4'd0, 4'd9, 4'd0, 4'd0, 4'd7, 4'd0,
					    4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd6, 4'd3, 4'd0, 4'd0,
					    4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd8};
		test_solver;
`endif

		#50;
		$display("***************************************");
		$display("PASSED: %d/%d", pass_counter, test_counter);
		$write("***************************************");
		$display("");
		$finish;
	end

`ifdef VERBOSE
	`define NAKED_TEST
	`define HIDDEN_TEST
`endif

`ifdef NAKED_TEST
	always @(posedge ss1.naked_group_detected)
	begin
		$display("NAKED GROUP DETECTED");
		$display("ROW COUNTER:    %d", ss1.row_counter);
		$display("COLUMN COUNTER: %d", ss1.col_counter);
		$display("pvr: %b", ss1.pvr[ss1.row_counter][ss1.col_counter]);
		printstatus;
	end
`endif

`ifdef HIDDEN_TEST
	// wire test_h;
	// assign test_h = ((ss1.col_counter == 5) && (ss1.row_counter == 2));
	always @(posedge ss1.hidden_group_detected)// or posedge test_h)
	begin
		$display("HIDDEN GROUP DETECTED");
		$display("ROW COUNTER:    %d", ss1.row_counter);
		$display("COLUMN COUNTER: %d", ss1.col_counter);
		$display("pvr: %b", ss1.pvr[ss1.row_counter][ss1.col_counter]);
		printstatus;
	end
`endif

	always #5
	begin
		clk = ~clk;
		if (clk)
		begin
`ifdef VERBOSE
			printstatus;
`endif
`ifdef GUESS
			if (|ss1.error_detected)
			begin
				$display("ROW COUNTER:    %d", ss1.row_counter);
				$display("COLUMN COUNTER: %d", ss1.col_counter);
				$display("Error Detected");
				$display("%b", (|ss1.error_detected));
				$display("%b", ss1.error_detected);

				$display("Possibilities Grid: ");
				`PRINTGRIDONEHOT(ss1.pvr);
				$display("Rows Guessed: ");
				`PRINTVEC16(ss1.guess_row);
				$display("Cols Guessed: ");
				`PRINTVEC16(ss1.guess_col);
				$display("Guess Values: ");
				`PRINTVECBIN16(ss1.guesses);
				$display("Guess number");
				$display("%d", ss1.guess_number);
				$display("Output: ");
				`PRINTGRID(solved);
			end
			if (ss1.timeout)
			begin
				$display("Possibilities Grid: ");
				`PRINTGRIDONEHOT(ss1.pvr);
				$display("Rows Guessed: ");
				`PRINTVEC16(ss1.guess_row);
				$display("Cols Guessed: ");
				`PRINTVEC16(ss1.guess_col);
				$display("Guess Values: ");
				`PRINTVECBIN16(ss1.guesses);
				$display("Guess number");
				$display("%d", ss1.guess_number);

				$display("Previous grid possibilities");
				`PRINTPREVGRIDONEHOT(ss1.pvr_prevs,ss1.guess_number-1);
				$display("");
				`PRINTPREVGRIDONEHOT(ss1.pvr_prevs,ss1.guess_number);
				$display("Output: ");
				`PRINTGRID(solved);
			end
`endif
			`assert_leq(ss1.guess_number, MAX_GUESSES-1)
			`assert_neq((|ss1.error_detected & ~|ss1.guess_number), 1)
			// $display("DONE: %d", done);
			clk_counter = clk_counter + 1;
		end
	end

	task test_solver;
	begin
		test_counter = test_counter + 1;
		reset        = 1;
		#20;
		reset        = 0;
		#10;

		clk_counter_start = clk_counter;

		@(posedge (done & clk))
		begin
			pass_counter    = pass_counter + 1;
			clk_counter_end = clk_counter;
			printstatus;
		end

		#10;
	end
	endtask

	task printstatus;
	begin
		$display("");

		$display("Input: ");
		`PRINTGRID(ss1.unsolved);

		$display("One Hot: ");
		`PRINTGRIDONEHOT(ss1.one_hot_board_reg);

		$display("Possibilities Grid: ");
		`PRINTGRIDONEHOT(ss1.pvr);

`ifdef HIDDEN_TEST
		$display("Hidden Group Grid: ");
		`PRINTGRIDONEHOT(ss1.gmr);
		$display("Timeout countdown: ");
		`PRINTGRID(ss1.done_countdown);
		$display("Hidden Group in Row");
		$display("%b", ss1.hidden_group_detected_row);
		$display("Hidden Group in Col");
		$display("%b", ss1.hidden_group_detected_col);
		$display("Hidden Group in Square");
		$display("%b", ss1.hidden_group_detected_sq);
		$display("number_of_ones_in_mask");
		$display("%d", ss1.number_of_ones_in_mask);
		$display("number_of_zero_masks_rows");
		$display("%d", ss1.number_of_zero_masks_rows);
		$display("number_of_zero_masks_cols");
		$display("%d", ss1.number_of_zero_masks_cols);
		$display("number_of_zero_masks_sqs");
		$display("%d", ss1.number_of_zero_masks_sqs);
		$display("Hidden Rows Mask");
		$display("%b", ss1.hidden_rows_mask);
		$display("Hidden Cols Mask");
		$display("%b", ss1.hidden_cols_mask);
		$display("Hidden Sqs Mask");
		$display("%b", ss1.hidden_sqs_mask);
`endif

`ifdef NAKED_TEST
		$display("Naked Group in Row");
		$display("%b", ss1.naked_group_detected_row);
		$display("Naked Group in Col");
		$display("%b", ss1.naked_group_detected_col);
		$display("Naked Group in Square");
		$display("%b", ss1.naked_group_detected_sq);
		$display("number_of_ones_in_mask");
		$display("%d", ss1.number_of_ones_in_mask);
		$display("Naked Rows Mask");
		$display("%b", ss1.naked_rows_mask);
		$display("Naked Cols Mask");
		$display("%b", ss1.naked_cols_mask);
		$display("Naked Sqs Mask");
		$display("%b", ss1.naked_sqs_mask);
`endif

		// $display("Candidate Rows: ");
		// `PRINTCANDIDATELINE(ss1.candidate_line_rows_reg);

		// $display("Candidate Columns: ");
		// `PRINTCANDIDATELINE(ss1.candidate_line_cols_reg);

		$display("Rows Solved: ");
		$display("%b %b %b %b %b %b %b %b %b", ss1.rows_solved[0],
											   ss1.rows_solved[1],
											   ss1.rows_solved[2],
											   ss1.rows_solved[3],
											   ss1.rows_solved[4],
											   ss1.rows_solved[5],
											   ss1.rows_solved[6],
											   ss1.rows_solved[7],
											   ss1.rows_solved[8] );

		$display("Columns Solved: ");
		$display("%b %b %b %b %b %b %b %b %b", ss1.cols_solved[0],
											   ss1.cols_solved[1],
											   ss1.cols_solved[2],
											   ss1.cols_solved[3],
											   ss1.cols_solved[4],
											   ss1.cols_solved[5],
											   ss1.cols_solved[6],
											   ss1.cols_solved[7],
											   ss1.cols_solved[8] );

		$display("Squares Solved: ");
		$write("%c[1;34m",27);
		$write("%b ", ss1.squares_solved[0]);
		$write("%c[0m",27);
		$write("%c[1;31m",27);
		$write("%b ", ss1.squares_solved[1]);
		$write("%c[0m",27);
		$write("%c[1;34m",27);
		$write("%b ", ss1.squares_solved[2]);
		$write("%c[0m",27);
		$write("%c[1;31m",27);
		$write("%b ", ss1.squares_solved[3]);
		$write("%c[0m",27);
		$write("%c[1;34m",27);
		$write("%b ", ss1.squares_solved[4]);
		$write("%c[0m",27);
		$write("%c[1;31m",27);
		$write("%b ", ss1.squares_solved[5]);
		$write("%c[0m",27);
		$write("%c[1;34m",27);
		$write("%b ", ss1.squares_solved[6]);
		$write("%c[0m",27);
		$write("%c[1;31m",27);
		$write("%b ", ss1.squares_solved[7]);
		$write("%c[0m",27);
		$write("%c[1;34m",27);
		$write("%b ", ss1.squares_solved[8]);
		$write("%c[0m",27);

		$display("");

		$display("Rows contains: ");
		`PRINTVECBIN(ss1.rows_contains);

		$display("Columns contains: ");
		`PRINTVECBIN(ss1.cols_contains);

		$display("Squares contains: ");
		`PRINTVECBIN(ss1.squares_contains);

		$display("ROW COUNTER:    %d", ss1.row_counter);
		$display("COLUMN COUNTER: %d", ss1.col_counter);

		$display("Rows Guessed: ");
		`PRINTVEC16(ss1.guess_row);
		$display("Cols Guessed: ");
		`PRINTVEC16(ss1.guess_col);
		$display("Guess Values: ");
		`PRINTVECBIN16(ss1.guesses);
		$display("Guess number");
		$display("%d", ss1.guess_number);
		$display("Timed_out?: ");
		$display("%b", ss1.timeout);
		$display("Error Detected");
		$display("%b", (|ss1.error_detected));
		$display("%b", ss1.error_detected);
		$display("Previous grid possibilities");
		`PRINTPREVGRIDONEHOT(ss1.pvr_prevs,ss1.guess_number-1);
		$display("");
		`PRINTPREVGRIDONEHOT(ss1.pvr_prevs,ss1.guess_number);


		$display("Output: ");
		`PRINTGRID(solved);

		$display("");
		$display("Clock Cycles: ");
		$display("%d", (clk_counter_end - clk_counter_start));
		$display("DONE: %d", done);

`ifndef VERBOSE
		if ((&ss1.rows_solved) & (&ss1.cols_solved) & (&ss1.squares_solved))
		begin
			$display("%c[5;38m",27);
			$display("***************************************");
			$display("*********** TEST CASE PASS ************");
			$write("***************************************");
			$write("%c[0m",27);
			$display("");
		end
		else
		begin
			$display("%c[5;33m",27);
			$display("***************************************");
			$display("*********** TEST CASE FAIL ************");
			$write("***************************************");
			$display("%c[0m",27);
			$display("");
		end
`endif

	end
	endtask
endmodule
