module soduku_solver_tb;
//
// INCLUDES
//
	`include "soduku_tb_lib.v"


//
// VARIABLES
//
	localparam   GRID_SIZE = 9;
	reg        clk;
	reg        reset;

	// 2D array of 4 bit BCD values
	// Contains all the numbers in unsolved board
	// Number = 0 implies missing value

	reg  [4*(GRID_SIZE)*(GRID_SIZE)-1:0] test_input;
	wire [4*(GRID_SIZE)*(GRID_SIZE)-1:0] test_output;

	// 2D array of 4 bit BCD values
	// Contains all the numbers in solved board
	wire [3:0] solved [(GRID_SIZE-1):0] [(GRID_SIZE-1):0];


	generate
		genvar row_genvar;
		genvar col_genvar;

		for (row_genvar = 0; row_genvar < GRID_SIZE; row_genvar = row_genvar + 1)
		begin
			for (col_genvar = 0; col_genvar < GRID_SIZE; col_genvar = col_genvar + 1)
			begin
				assign solved[row_genvar][col_genvar] = test_output[(36*(9-row_genvar)-(col_genvar*4)-1):(36*(9-row_genvar)-(col_genvar*4)-4)];
			end
		end
		
	endgenerate

	// solution =  {4'd8, 4'd1, 4'd2, 4'd7, 4'd5, 4'd3, 4'd6, 4'd4, 4'd9,
	// 		        4'd9, 4'd4, 4'd3, 4'd6, 4'd8, 4'd2, 4'd1, 4'd7, 4'd5,
	// 		        4'd6, 4'd7, 4'd5, 4'd4, 4'd9, 4'd1, 4'd2, 4'd8, 4'd3,
	// 		        4'd1, 4'd5, 4'd4, 4'd2, 4'd3, 4'd7, 4'd8, 4'd9, 4'd6,
	// 		        4'd3, 4'd6, 4'd9, 4'd8, 4'd4, 4'd5, 4'd7, 4'd2, 4'd1,
	// 		        4'd2, 4'd8, 4'd7, 4'd1, 4'd6, 4'd9, 4'd5, 4'd3, 4'd4,
	// 		        4'd5, 4'd2, 4'd1, 4'd9, 4'd7, 4'd4, 4'd3, 4'd6, 4'd8,
	// 		        4'd4, 4'd3, 4'd8, 4'd5, 4'd2, 4'd6, 4'd9, 4'd1, 4'd7,
	// 		        4'd7, 4'd9, 4'd6, 4'd3, 4'd1, 4'd8, 4'd4, 4'd5, 4'd2};
	
	soduku_solver ss1   (
							.clk_in    (clk)       ,
							.reset_in  (reset)     ,
							.board_in  (test_input),
							.board_out (test_output)
						);
	initial
	begin
	    $dumpfile("test.vcd");
		$dumpvars(0,soduku_solver_tb);
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
`endif

`ifdef HARD

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
		$finish;
	end

	always #5 clk = ~clk;

	task test_solver;
	begin
		reset       = 1;
		#20;
		// printstatus;
		// #20;
		reset       = 0;
		#10;

`ifdef EASY
		#1000;
`endif

`ifdef INTERMEDIATE
		#10000;
`endif

`ifdef HARD
		#100000;
`endif

		printstatus;
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

		$display("Rows Missing: ");
		`PRINTVECBIN(ss1.rows_missing);

		$display("Columns Missing: ");
		`PRINTVECBIN(ss1.cols_missing);

		$display("Squares Missing: ");
		`PRINTVECBIN(ss1.squares_missing);

		$display("Output: ");
		`PRINTGRID(solved);

		$display("");
	end
	endtask
endmodule