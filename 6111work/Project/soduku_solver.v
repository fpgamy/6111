module soduku_solver(
						clk_in         ,
						reset_in       ,
						board_in       ,
						board_out      ,
						done_out
					);
//
// PARAMETERS
//
	localparam   GRID_SIZE = 9;
//
// PORT DECLARATIONS
//	
	// Input clock and reset signal
	input        clk_in, reset_in;
	input  [4*(GRID_SIZE)*(GRID_SIZE)-1:0] board_in;
	output [4*(GRID_SIZE)*(GRID_SIZE)-1:0] board_out;
	output       done_out;
	// 2D array of 4 bit BCD values
	// Contains all the numbers in unsolved board
	// Number = 0 implies contains value
	wire  [3:0] unsolved [0:(GRID_SIZE-1)] [0:(GRID_SIZE-1)];

	// 2D array of 4 bit BCD values
	// Contains all the numbers in solved board
	wire  [3:0] solved [0:(GRID_SIZE-1)] [0:(GRID_SIZE-1)];

	// This monstrosity is because of the use of Verilog instead of SystemVerilog
	assign board_out = {solved[0][0], solved[0][1], solved[0][2], solved[0][3], solved[0][4], solved[0][5], solved[0][6], solved[0][7], solved[0][8],
					    solved[1][0], solved[1][1], solved[1][2], solved[1][3], solved[1][4], solved[1][5], solved[1][6], solved[1][7], solved[1][8],
					    solved[2][0], solved[2][1], solved[2][2], solved[2][3], solved[2][4], solved[2][5], solved[2][6], solved[2][7], solved[2][8],
					    solved[3][0], solved[3][1], solved[3][2], solved[3][3], solved[3][4], solved[3][5], solved[3][6], solved[3][7], solved[3][8],
					    solved[4][0], solved[4][1], solved[4][2], solved[4][3], solved[4][4], solved[4][5], solved[4][6], solved[4][7], solved[4][8],
					    solved[5][0], solved[5][1], solved[5][2], solved[5][3], solved[5][4], solved[5][5], solved[5][6], solved[5][7], solved[5][8],
					    solved[6][0], solved[6][1], solved[6][2], solved[6][3], solved[6][4], solved[6][5], solved[6][6], solved[6][7], solved[6][8],
					    solved[7][0], solved[7][1], solved[7][2], solved[7][3], solved[7][4], solved[7][5], solved[7][6], solved[7][7], solved[7][8],
					    solved[8][0], solved[8][1], solved[8][2], solved[8][3], solved[8][4], solved[8][5], solved[8][6], solved[8][7], solved[8][8]};

// REG/WIRE DEFINITIONS
//
	// Contains the current progress of the board 
	// Uses one hot encoding
	reg    [(GRID_SIZE-1):0] one_hot_board_reg   [0:(GRID_SIZE-1)] [0:(GRID_SIZE-1)];

	// Contains 1s where the possible values are
	reg    [(GRID_SIZE-1):0] pvr [0:(GRID_SIZE-1)] [0:(GRID_SIZE-1)];

	// We define the squares, rows, columns as follows:
	// 0 ..................... 8
	// _________________________ 
	// |       |       |       | 0
	// |   0   |   1   |   2   | .
	// |       |       |       | .
	// |-------|-------|-------|
	// |       |       |       | .
	// |   3   |   4   |   5   | .
	// |       |       |       | .
	// |-------|-------|-------|
	// |       |       |       | .
	// |   6   |   7   |   8   | .
	// |_______|_______|_______| 8
	// Contains ones where the rows are solved
	wire    [(GRID_SIZE-1):0] rows_solved;
	// Determines if we need to start backtracking
	reg     [(GRID_SIZE-1):0] rows_solved_prev;
	// Contains ones where the columns are solved
	wire    [(GRID_SIZE-1):0] cols_solved;
	// Determines if we need to start backtracking
	reg     [(GRID_SIZE-1):0] cols_solved_prev;
	// Contains ones where the squares are solved
	wire    [(GRID_SIZE-1):0] squares_solved;
	// Determines if we need to start backtracking
	reg     [(GRID_SIZE-1):0] squares_solved_prev;

	// Contains zeros where the numbers are contains
	wire    [(GRID_SIZE-1):0] rows_contains         [0:(GRID_SIZE-1)];
	// Determines if we need made a mistake (check for equality)
	reg     [(GRID_SIZE-1):0] rows_contains_prev    [0:(GRID_SIZE-1)];
	
	wire    [(GRID_SIZE-1):0] cols_contains         [0:(GRID_SIZE-1)];
	// Determines if we need made a mistake (check for equality)
	reg     [(GRID_SIZE-1):0] cols_contains_prev    [0:(GRID_SIZE-1)];

	wire    [(GRID_SIZE-1):0] squares_contains      [0:(GRID_SIZE-1)];
	// Determines if we need made a mistake (check for equality)
	reg     [(GRID_SIZE-1):0] squares_contains_prev [0:(GRID_SIZE-1)];

	// candidate line [i][j] is the mask of values which exist on the ith square on the jth line in the square. 
	// candidate lines rows 
	reg     [(GRID_SIZE-1):0] candidate_line_rows_reg   [(GRID_SIZE-1):0] [2:0];
	// candidate lines columns
	reg     [(GRID_SIZE-1):0] candidate_line_cols_reg   [(GRID_SIZE-1):0] [2:0];

	assign done_out = &{rows_solved, cols_solved, squares_solved};
//
// INCLUDES
//
	`include "soduku_lib.v"


//
// GENERATORS
//

	// !!DISGUSTING-CODE WARNING!!
	// GET YOUR SICK BAG READY.
	generate
		genvar row_genvar;
		genvar col_genvar;

		for (row_genvar = 0; row_genvar < (GRID_SIZE); row_genvar = row_genvar + 1)
		begin: row_generator
			for (col_genvar = 0; col_genvar < (GRID_SIZE); col_genvar = col_genvar + 1)
			begin: col_generator
				wire    [(GRID_SIZE-1):0] squares_contains_single;
				wire    [(GRID_SIZE-1):0] single_candidate_mask;
				wire    [(GRID_SIZE-1):0] single_position_mask_temp;
				wire    [(GRID_SIZE-1):0] single_position_mask;
				wire    [(GRID_SIZE-1):0] single_pos_row;
				wire    [(GRID_SIZE-1):0] single_pos_col;
				wire    [(GRID_SIZE-1):0] single_pos_sq;

				wire    [(GRID_SIZE-1):0] possibilities_mask;
				wire    [(GRID_SIZE-1):0] candidate_line_r;
				wire    [(GRID_SIZE-1):0] candidate_line_c;

				assign single_pos_row = {
					valid_one_hot({pvr[row_genvar][8][8], pvr[row_genvar][7][8], pvr[row_genvar][6][8], pvr[row_genvar][5][8], pvr[row_genvar][4][8], pvr[row_genvar][3][8], pvr[row_genvar][2][8], pvr[row_genvar][1][8], pvr[row_genvar][0][8]}),
					valid_one_hot({pvr[row_genvar][8][7], pvr[row_genvar][7][7], pvr[row_genvar][6][7], pvr[row_genvar][5][7], pvr[row_genvar][4][7], pvr[row_genvar][3][7], pvr[row_genvar][2][7], pvr[row_genvar][1][7], pvr[row_genvar][0][7]}),
					valid_one_hot({pvr[row_genvar][8][6], pvr[row_genvar][7][6], pvr[row_genvar][6][6], pvr[row_genvar][5][6], pvr[row_genvar][4][6], pvr[row_genvar][3][6], pvr[row_genvar][2][6], pvr[row_genvar][1][6], pvr[row_genvar][0][6]}),
					valid_one_hot({pvr[row_genvar][8][5], pvr[row_genvar][7][5], pvr[row_genvar][6][5], pvr[row_genvar][5][5], pvr[row_genvar][4][5], pvr[row_genvar][3][5], pvr[row_genvar][2][5], pvr[row_genvar][1][5], pvr[row_genvar][0][5]}),
					valid_one_hot({pvr[row_genvar][8][4], pvr[row_genvar][7][4], pvr[row_genvar][6][4], pvr[row_genvar][5][4], pvr[row_genvar][4][4], pvr[row_genvar][3][4], pvr[row_genvar][2][4], pvr[row_genvar][1][4], pvr[row_genvar][0][4]}),
					valid_one_hot({pvr[row_genvar][8][3], pvr[row_genvar][7][3], pvr[row_genvar][6][3], pvr[row_genvar][5][3], pvr[row_genvar][4][3], pvr[row_genvar][3][3], pvr[row_genvar][2][3], pvr[row_genvar][1][3], pvr[row_genvar][0][3]}),
					valid_one_hot({pvr[row_genvar][8][2], pvr[row_genvar][7][2], pvr[row_genvar][6][2], pvr[row_genvar][5][2], pvr[row_genvar][4][2], pvr[row_genvar][3][2], pvr[row_genvar][2][2], pvr[row_genvar][1][2], pvr[row_genvar][0][2]}),
					valid_one_hot({pvr[row_genvar][8][1], pvr[row_genvar][7][1], pvr[row_genvar][6][1], pvr[row_genvar][5][1], pvr[row_genvar][4][1], pvr[row_genvar][3][1], pvr[row_genvar][2][1], pvr[row_genvar][1][1], pvr[row_genvar][0][1]}),
					valid_one_hot({pvr[row_genvar][8][0], pvr[row_genvar][7][0], pvr[row_genvar][6][0], pvr[row_genvar][5][0], pvr[row_genvar][4][0], pvr[row_genvar][3][0], pvr[row_genvar][2][0], pvr[row_genvar][1][0], pvr[row_genvar][0][0]})
				};

				assign single_pos_col = {
					valid_one_hot({pvr[8][col_genvar][8], pvr[7][col_genvar][8], pvr[6][col_genvar][8], pvr[5][col_genvar][8], pvr[4][col_genvar][8], pvr[3][col_genvar][8], pvr[2][col_genvar][8], pvr[1][col_genvar][8], pvr[0][col_genvar][8]}),
					valid_one_hot({pvr[8][col_genvar][7], pvr[7][col_genvar][7], pvr[6][col_genvar][7], pvr[5][col_genvar][7], pvr[4][col_genvar][7], pvr[3][col_genvar][7], pvr[2][col_genvar][7], pvr[1][col_genvar][7], pvr[0][col_genvar][7]}),
					valid_one_hot({pvr[8][col_genvar][6], pvr[7][col_genvar][6], pvr[6][col_genvar][6], pvr[5][col_genvar][6], pvr[4][col_genvar][6], pvr[3][col_genvar][6], pvr[2][col_genvar][6], pvr[1][col_genvar][6], pvr[0][col_genvar][6]}),
					valid_one_hot({pvr[8][col_genvar][5], pvr[7][col_genvar][5], pvr[6][col_genvar][5], pvr[5][col_genvar][5], pvr[4][col_genvar][5], pvr[3][col_genvar][5], pvr[2][col_genvar][5], pvr[1][col_genvar][5], pvr[0][col_genvar][5]}),
					valid_one_hot({pvr[8][col_genvar][4], pvr[7][col_genvar][4], pvr[6][col_genvar][4], pvr[5][col_genvar][4], pvr[4][col_genvar][4], pvr[3][col_genvar][4], pvr[2][col_genvar][4], pvr[1][col_genvar][4], pvr[0][col_genvar][4]}),
					valid_one_hot({pvr[8][col_genvar][3], pvr[7][col_genvar][3], pvr[6][col_genvar][3], pvr[5][col_genvar][3], pvr[4][col_genvar][3], pvr[3][col_genvar][3], pvr[2][col_genvar][3], pvr[1][col_genvar][3], pvr[0][col_genvar][3]}),
					valid_one_hot({pvr[8][col_genvar][2], pvr[7][col_genvar][2], pvr[6][col_genvar][2], pvr[5][col_genvar][2], pvr[4][col_genvar][2], pvr[3][col_genvar][2], pvr[2][col_genvar][2], pvr[1][col_genvar][2], pvr[0][col_genvar][2]}),
					valid_one_hot({pvr[8][col_genvar][1], pvr[7][col_genvar][1], pvr[6][col_genvar][1], pvr[5][col_genvar][1], pvr[4][col_genvar][1], pvr[3][col_genvar][1], pvr[2][col_genvar][1], pvr[1][col_genvar][1], pvr[0][col_genvar][1]}),
					valid_one_hot({pvr[8][col_genvar][0], pvr[7][col_genvar][0], pvr[6][col_genvar][0], pvr[5][col_genvar][0], pvr[4][col_genvar][0], pvr[3][col_genvar][0], pvr[2][col_genvar][0], pvr[1][col_genvar][0], pvr[0][col_genvar][0]})
				};

				if (row_genvar >= 6)
				begin
					if (col_genvar >= 6)
					begin
						assign squares_contains_single = squares_contains[8];
						assign candidate_line_c =  candidate_line_cols_reg[2][col_genvar-6] & candidate_line_cols_reg[5][col_genvar-6];
						assign candidate_line_r = candidate_line_rows_reg[6][row_genvar-6] & candidate_line_rows_reg[7][row_genvar-6];
						assign single_pos_sq = {
							valid_one_hot({pvr[6][6][8], pvr[6][7][8], pvr[6][8][8], pvr[7][6][8], pvr[7][7][8], pvr[7][8][8], pvr[8][6][8], pvr[8][7][8], pvr[8][8][8]}),
							valid_one_hot({pvr[6][6][7], pvr[6][7][7], pvr[6][8][7], pvr[7][6][7], pvr[7][7][7], pvr[7][8][7], pvr[8][6][7], pvr[8][7][7], pvr[8][8][7]}),
							valid_one_hot({pvr[6][6][6], pvr[6][7][6], pvr[6][8][6], pvr[7][6][6], pvr[7][7][6], pvr[7][8][6], pvr[8][6][6], pvr[8][7][6], pvr[8][8][6]}),
							valid_one_hot({pvr[6][6][5], pvr[6][7][5], pvr[6][8][5], pvr[7][6][5], pvr[7][7][5], pvr[7][8][5], pvr[8][6][5], pvr[8][7][5], pvr[8][8][5]}),
							valid_one_hot({pvr[6][6][4], pvr[6][7][4], pvr[6][8][4], pvr[7][6][4], pvr[7][7][4], pvr[7][8][4], pvr[8][6][4], pvr[8][7][4], pvr[8][8][4]}),
							valid_one_hot({pvr[6][6][3], pvr[6][7][3], pvr[6][8][3], pvr[7][6][3], pvr[7][7][3], pvr[7][8][3], pvr[8][6][3], pvr[8][7][3], pvr[8][8][3]}),
							valid_one_hot({pvr[6][6][2], pvr[6][7][2], pvr[6][8][2], pvr[7][6][2], pvr[7][7][2], pvr[7][8][2], pvr[8][6][2], pvr[8][7][2], pvr[8][8][2]}),
							valid_one_hot({pvr[6][6][1], pvr[6][7][1], pvr[6][8][1], pvr[7][6][1], pvr[7][7][1], pvr[7][8][1], pvr[8][6][1], pvr[8][7][1], pvr[8][8][1]}),
							valid_one_hot({pvr[6][6][0], pvr[6][7][0], pvr[6][8][0], pvr[7][6][0], pvr[7][7][0], pvr[7][8][0], pvr[8][6][0], pvr[8][7][0], pvr[8][8][0]})
						};
					end
					else if (col_genvar >= 3)
					begin
						assign squares_contains_single = squares_contains[7];
						assign candidate_line_c =  candidate_line_cols_reg[1][col_genvar-3] & candidate_line_cols_reg[4][col_genvar-3];
						assign candidate_line_r = candidate_line_rows_reg[6][row_genvar-6] & candidate_line_rows_reg[8][row_genvar-6];
						assign single_pos_sq = {
							valid_one_hot({pvr[6][3][8], pvr[6][4][8], pvr[6][5][8], pvr[7][3][8], pvr[7][4][8], pvr[7][5][8], pvr[8][3][8], pvr[8][4][8], pvr[8][5][8]}),
							valid_one_hot({pvr[6][3][7], pvr[6][4][7], pvr[6][5][7], pvr[7][3][7], pvr[7][4][7], pvr[7][5][7], pvr[8][3][7], pvr[8][4][7], pvr[8][5][7]}),
							valid_one_hot({pvr[6][3][6], pvr[6][4][6], pvr[6][5][6], pvr[7][3][6], pvr[7][4][6], pvr[7][5][6], pvr[8][3][6], pvr[8][4][6], pvr[8][5][6]}),
							valid_one_hot({pvr[6][3][5], pvr[6][4][5], pvr[6][5][5], pvr[7][3][5], pvr[7][4][5], pvr[7][5][5], pvr[8][3][5], pvr[8][4][5], pvr[8][5][5]}),
							valid_one_hot({pvr[6][3][4], pvr[6][4][4], pvr[6][5][4], pvr[7][3][4], pvr[7][4][4], pvr[7][5][4], pvr[8][3][4], pvr[8][4][4], pvr[8][5][4]}),
							valid_one_hot({pvr[6][3][3], pvr[6][4][3], pvr[6][5][3], pvr[7][3][3], pvr[7][4][3], pvr[7][5][3], pvr[8][3][3], pvr[8][4][3], pvr[8][5][3]}),
							valid_one_hot({pvr[6][3][2], pvr[6][4][2], pvr[6][5][2], pvr[7][3][2], pvr[7][4][2], pvr[7][5][2], pvr[8][3][2], pvr[8][4][2], pvr[8][5][2]}),
							valid_one_hot({pvr[6][3][1], pvr[6][4][1], pvr[6][5][1], pvr[7][3][1], pvr[7][4][1], pvr[7][5][1], pvr[8][3][1], pvr[8][4][1], pvr[8][5][1]}),
							valid_one_hot({pvr[6][3][0], pvr[6][4][0], pvr[6][5][0], pvr[7][3][0], pvr[7][4][0], pvr[7][5][0], pvr[8][3][0], pvr[8][4][0], pvr[8][5][0]})
						};
					end
					else 
					begin
						assign squares_contains_single = squares_contains[6];
						assign candidate_line_c =  candidate_line_cols_reg[0][col_genvar] & candidate_line_cols_reg[3][col_genvar];
						assign candidate_line_r = candidate_line_rows_reg[7][row_genvar-6] & candidate_line_rows_reg[8][row_genvar-6];
						assign single_pos_sq = {
							valid_one_hot({pvr[6][0][8], pvr[6][1][8], pvr[6][2][8], pvr[7][0][8], pvr[7][1][8], pvr[7][2][8], pvr[8][0][8], pvr[8][1][8], pvr[8][2][8]}),
							valid_one_hot({pvr[6][0][7], pvr[6][1][7], pvr[6][2][7], pvr[7][0][7], pvr[7][1][7], pvr[7][2][7], pvr[8][0][7], pvr[8][1][7], pvr[8][2][7]}),
							valid_one_hot({pvr[6][0][6], pvr[6][1][6], pvr[6][2][6], pvr[7][0][6], pvr[7][1][6], pvr[7][2][6], pvr[8][0][6], pvr[8][1][6], pvr[8][2][6]}),
							valid_one_hot({pvr[6][0][5], pvr[6][1][5], pvr[6][2][5], pvr[7][0][5], pvr[7][1][5], pvr[7][2][5], pvr[8][0][5], pvr[8][1][5], pvr[8][2][5]}),
							valid_one_hot({pvr[6][0][4], pvr[6][1][4], pvr[6][2][4], pvr[7][0][4], pvr[7][1][4], pvr[7][2][4], pvr[8][0][4], pvr[8][1][4], pvr[8][2][4]}),
							valid_one_hot({pvr[6][0][3], pvr[6][1][3], pvr[6][2][3], pvr[7][0][3], pvr[7][1][3], pvr[7][2][3], pvr[8][0][3], pvr[8][1][3], pvr[8][2][3]}),
							valid_one_hot({pvr[6][0][2], pvr[6][1][2], pvr[6][2][2], pvr[7][0][2], pvr[7][1][2], pvr[7][2][2], pvr[8][0][2], pvr[8][1][2], pvr[8][2][2]}),
							valid_one_hot({pvr[6][0][1], pvr[6][1][1], pvr[6][2][1], pvr[7][0][1], pvr[7][1][1], pvr[7][2][1], pvr[8][0][1], pvr[8][1][1], pvr[8][2][1]}),
							valid_one_hot({pvr[6][0][0], pvr[6][1][0], pvr[6][2][0], pvr[7][0][0], pvr[7][1][0], pvr[7][2][0], pvr[8][0][0], pvr[8][1][0], pvr[8][2][0]})
						};
					end
				end
				else if (row_genvar >= 3)
				begin
					if (col_genvar >= 6)
					begin
						assign squares_contains_single = squares_contains[5];
						assign candidate_line_c =  candidate_line_cols_reg[2][col_genvar-6] & candidate_line_cols_reg[8][col_genvar-6];
						assign candidate_line_r = candidate_line_rows_reg[3][row_genvar-3] & candidate_line_rows_reg[4][row_genvar-3];
						assign single_pos_sq = {
							valid_one_hot({pvr[3][6][8], pvr[3][7][8], pvr[3][8][8], pvr[4][6][8], pvr[4][7][8], pvr[4][8][8], pvr[5][6][8], pvr[5][7][8], pvr[5][8][8]}),
							valid_one_hot({pvr[3][6][7], pvr[3][7][7], pvr[3][8][7], pvr[4][6][7], pvr[4][7][7], pvr[4][8][7], pvr[5][6][7], pvr[5][7][7], pvr[5][8][7]}),
							valid_one_hot({pvr[3][6][6], pvr[3][7][6], pvr[3][8][6], pvr[4][6][6], pvr[4][7][6], pvr[4][8][6], pvr[5][6][6], pvr[5][7][6], pvr[5][8][6]}),
							valid_one_hot({pvr[3][6][5], pvr[3][7][5], pvr[3][8][5], pvr[4][6][5], pvr[4][7][5], pvr[4][8][5], pvr[5][6][5], pvr[5][7][5], pvr[5][8][5]}),
							valid_one_hot({pvr[3][6][4], pvr[3][7][4], pvr[3][8][4], pvr[4][6][4], pvr[4][7][4], pvr[4][8][4], pvr[5][6][4], pvr[5][7][4], pvr[5][8][4]}),
							valid_one_hot({pvr[3][6][3], pvr[3][7][3], pvr[3][8][3], pvr[4][6][3], pvr[4][7][3], pvr[4][8][3], pvr[5][6][3], pvr[5][7][3], pvr[5][8][3]}),
							valid_one_hot({pvr[3][6][2], pvr[3][7][2], pvr[3][8][2], pvr[4][6][2], pvr[4][7][2], pvr[4][8][2], pvr[5][6][2], pvr[5][7][2], pvr[5][8][2]}),
							valid_one_hot({pvr[3][6][1], pvr[3][7][1], pvr[3][8][1], pvr[4][6][1], pvr[4][7][1], pvr[4][8][1], pvr[5][6][1], pvr[5][7][1], pvr[5][8][1]}),
							valid_one_hot({pvr[3][6][0], pvr[3][7][0], pvr[3][8][0], pvr[4][6][0], pvr[4][7][0], pvr[4][8][0], pvr[5][6][0], pvr[5][7][0], pvr[5][8][0]})
						};
					end
					else if (col_genvar >= 3)
					begin
						assign squares_contains_single = squares_contains[4];
						assign candidate_line_c =  candidate_line_cols_reg[1][col_genvar-3] & candidate_line_cols_reg[7][col_genvar-3];
						assign candidate_line_r = candidate_line_rows_reg[3][row_genvar-3] & candidate_line_rows_reg[5][row_genvar-3];
						assign single_pos_sq = {
							valid_one_hot({pvr[3][3][8], pvr[3][4][8], pvr[3][5][8], pvr[4][3][8], pvr[4][4][8], pvr[4][5][8], pvr[5][3][8], pvr[5][4][8], pvr[5][5][8]}),
							valid_one_hot({pvr[3][3][7], pvr[3][4][7], pvr[3][5][7], pvr[4][3][7], pvr[4][4][7], pvr[4][5][7], pvr[5][3][7], pvr[5][4][7], pvr[5][5][7]}),
							valid_one_hot({pvr[3][3][6], pvr[3][4][6], pvr[3][5][6], pvr[4][3][6], pvr[4][4][6], pvr[4][5][6], pvr[5][3][6], pvr[5][4][6], pvr[5][5][6]}),
							valid_one_hot({pvr[3][3][5], pvr[3][4][5], pvr[3][5][5], pvr[4][3][5], pvr[4][4][5], pvr[4][5][5], pvr[5][3][5], pvr[5][4][5], pvr[5][5][5]}),
							valid_one_hot({pvr[3][3][4], pvr[3][4][4], pvr[3][5][4], pvr[4][3][4], pvr[4][4][4], pvr[4][5][4], pvr[5][3][4], pvr[5][4][4], pvr[5][5][4]}),
							valid_one_hot({pvr[3][3][3], pvr[3][4][3], pvr[3][5][3], pvr[4][3][3], pvr[4][4][3], pvr[4][5][3], pvr[5][3][3], pvr[5][4][3], pvr[5][5][3]}),
							valid_one_hot({pvr[3][3][2], pvr[3][4][2], pvr[3][5][2], pvr[4][3][2], pvr[4][4][2], pvr[4][5][2], pvr[5][3][2], pvr[5][4][2], pvr[5][5][2]}),
							valid_one_hot({pvr[3][3][1], pvr[3][4][1], pvr[3][5][1], pvr[4][3][1], pvr[4][4][1], pvr[4][5][1], pvr[5][3][1], pvr[5][4][1], pvr[5][5][1]}),
							valid_one_hot({pvr[3][3][0], pvr[3][4][0], pvr[3][5][0], pvr[4][3][0], pvr[4][4][0], pvr[4][5][0], pvr[5][3][0], pvr[5][4][0], pvr[5][5][0]})
						};
					end
					else 
					begin
						assign squares_contains_single = squares_contains[3];
						assign candidate_line_c =  candidate_line_cols_reg[0][col_genvar] & candidate_line_cols_reg[6][col_genvar];
						assign candidate_line_r = candidate_line_rows_reg[4][row_genvar-3] & candidate_line_rows_reg[5][row_genvar-3];
						assign single_pos_sq = {
							valid_one_hot({pvr[3][0][8], pvr[3][1][8], pvr[3][2][8], pvr[4][0][8], pvr[4][1][8], pvr[4][2][8], pvr[5][0][8], pvr[5][1][8], pvr[5][2][8]}),
							valid_one_hot({pvr[3][0][7], pvr[3][1][7], pvr[3][2][7], pvr[4][0][7], pvr[4][1][7], pvr[4][2][7], pvr[5][0][7], pvr[5][1][7], pvr[5][2][7]}),
							valid_one_hot({pvr[3][0][6], pvr[3][1][6], pvr[3][2][6], pvr[4][0][6], pvr[4][1][6], pvr[4][2][6], pvr[5][0][6], pvr[5][1][6], pvr[5][2][6]}),
							valid_one_hot({pvr[3][0][5], pvr[3][1][5], pvr[3][2][5], pvr[4][0][5], pvr[4][1][5], pvr[4][2][5], pvr[5][0][5], pvr[5][1][5], pvr[5][2][5]}),
							valid_one_hot({pvr[3][0][4], pvr[3][1][4], pvr[3][2][4], pvr[4][0][4], pvr[4][1][4], pvr[4][2][4], pvr[5][0][4], pvr[5][1][4], pvr[5][2][4]}),
							valid_one_hot({pvr[3][0][3], pvr[3][1][3], pvr[3][2][3], pvr[4][0][3], pvr[4][1][3], pvr[4][2][3], pvr[5][0][3], pvr[5][1][3], pvr[5][2][3]}),
							valid_one_hot({pvr[3][0][2], pvr[3][1][2], pvr[3][2][2], pvr[4][0][2], pvr[4][1][2], pvr[4][2][2], pvr[5][0][2], pvr[5][1][2], pvr[5][2][2]}),
							valid_one_hot({pvr[3][0][1], pvr[3][1][1], pvr[3][2][1], pvr[4][0][1], pvr[4][1][1], pvr[4][2][1], pvr[5][0][1], pvr[5][1][1], pvr[5][2][1]}),
							valid_one_hot({pvr[3][0][0], pvr[3][1][0], pvr[3][2][0], pvr[4][0][0], pvr[4][1][0], pvr[4][2][0], pvr[5][0][0], pvr[5][1][0], pvr[5][2][0]})
						};
					end					
				end
				else 
				begin
					if (col_genvar >= 6)
					begin
						assign squares_contains_single = squares_contains[2];
						assign candidate_line_c =  candidate_line_cols_reg[5][col_genvar-6] & candidate_line_cols_reg[8][col_genvar-6];
						assign candidate_line_r = candidate_line_rows_reg[0][row_genvar] & candidate_line_rows_reg[1][row_genvar];
						assign single_pos_sq = {
							valid_one_hot({pvr[0][6][8], pvr[0][7][8], pvr[0][8][8], pvr[1][6][8], pvr[1][7][8], pvr[1][8][8], pvr[2][6][8], pvr[2][7][8], pvr[2][8][8]}),
							valid_one_hot({pvr[0][6][7], pvr[0][7][7], pvr[0][8][7], pvr[1][6][7], pvr[1][7][7], pvr[1][8][7], pvr[2][6][7], pvr[2][7][7], pvr[2][8][7]}),
							valid_one_hot({pvr[0][6][6], pvr[0][7][6], pvr[0][8][6], pvr[1][6][6], pvr[1][7][6], pvr[1][8][6], pvr[2][6][6], pvr[2][7][6], pvr[2][8][6]}),
							valid_one_hot({pvr[0][6][5], pvr[0][7][5], pvr[0][8][5], pvr[1][6][5], pvr[1][7][5], pvr[1][8][5], pvr[2][6][5], pvr[2][7][5], pvr[2][8][5]}),
							valid_one_hot({pvr[0][6][4], pvr[0][7][4], pvr[0][8][4], pvr[1][6][4], pvr[1][7][4], pvr[1][8][4], pvr[2][6][4], pvr[2][7][4], pvr[2][8][4]}),
							valid_one_hot({pvr[0][6][3], pvr[0][7][3], pvr[0][8][3], pvr[1][6][3], pvr[1][7][3], pvr[1][8][3], pvr[2][6][3], pvr[2][7][3], pvr[2][8][3]}),
							valid_one_hot({pvr[0][6][2], pvr[0][7][2], pvr[0][8][2], pvr[1][6][2], pvr[1][7][2], pvr[1][8][2], pvr[2][6][2], pvr[2][7][2], pvr[2][8][2]}),
							valid_one_hot({pvr[0][6][1], pvr[0][7][1], pvr[0][8][1], pvr[1][6][1], pvr[1][7][1], pvr[1][8][1], pvr[2][6][1], pvr[2][7][1], pvr[2][8][1]}),
							valid_one_hot({pvr[0][6][0], pvr[0][7][0], pvr[0][8][0], pvr[1][6][0], pvr[1][7][0], pvr[1][8][0], pvr[2][6][0], pvr[2][7][0], pvr[2][8][0]})
						};
					end
					else if (col_genvar >= 3)
					begin
						assign squares_contains_single = squares_contains[1];
						assign candidate_line_c =  candidate_line_cols_reg[4][col_genvar-3] & candidate_line_cols_reg[7][col_genvar-3];
						assign candidate_line_r = candidate_line_rows_reg[0][row_genvar] & candidate_line_rows_reg[2][row_genvar];
						assign single_pos_sq = {
							valid_one_hot({pvr[0][3][8], pvr[0][4][8], pvr[0][5][8], pvr[1][3][8], pvr[1][4][8], pvr[1][5][8], pvr[2][3][8], pvr[2][4][8], pvr[2][5][8]}),
							valid_one_hot({pvr[0][3][7], pvr[0][4][7], pvr[0][5][7], pvr[1][3][7], pvr[1][4][7], pvr[1][5][7], pvr[2][3][7], pvr[2][4][7], pvr[2][5][7]}),
							valid_one_hot({pvr[0][3][6], pvr[0][4][6], pvr[0][5][6], pvr[1][3][6], pvr[1][4][6], pvr[1][5][6], pvr[2][3][6], pvr[2][4][6], pvr[2][5][6]}),
							valid_one_hot({pvr[0][3][5], pvr[0][4][5], pvr[0][5][5], pvr[1][3][5], pvr[1][4][5], pvr[1][5][5], pvr[2][3][5], pvr[2][4][5], pvr[2][5][5]}),
							valid_one_hot({pvr[0][3][4], pvr[0][4][4], pvr[0][5][4], pvr[1][3][4], pvr[1][4][4], pvr[1][5][4], pvr[2][3][4], pvr[2][4][4], pvr[2][5][4]}),
							valid_one_hot({pvr[0][3][3], pvr[0][4][3], pvr[0][5][3], pvr[1][3][3], pvr[1][4][3], pvr[1][5][3], pvr[2][3][3], pvr[2][4][3], pvr[2][5][3]}),
							valid_one_hot({pvr[0][3][2], pvr[0][4][2], pvr[0][5][2], pvr[1][3][2], pvr[1][4][2], pvr[1][5][2], pvr[2][3][2], pvr[2][4][2], pvr[2][5][2]}),
							valid_one_hot({pvr[0][3][1], pvr[0][4][1], pvr[0][5][1], pvr[1][3][1], pvr[1][4][1], pvr[1][5][1], pvr[2][3][1], pvr[2][4][1], pvr[2][5][1]}),
							valid_one_hot({pvr[0][3][0], pvr[0][4][0], pvr[0][5][0], pvr[1][3][0], pvr[1][4][0], pvr[1][5][0], pvr[2][3][0], pvr[2][4][0], pvr[2][5][0]})
						};
					end
					else 
					begin
						assign squares_contains_single = squares_contains[0];
						assign candidate_line_c =  candidate_line_cols_reg[3][col_genvar] & candidate_line_cols_reg[6][col_genvar];
						assign candidate_line_r = candidate_line_rows_reg[1][row_genvar] & candidate_line_rows_reg[2][row_genvar];
						assign single_pos_sq = {
							valid_one_hot({pvr[0][0][8], pvr[0][1][8], pvr[0][2][8], pvr[1][0][8], pvr[1][1][8], pvr[1][2][8], pvr[2][0][8], pvr[2][1][8], pvr[2][2][8]}),
							valid_one_hot({pvr[0][0][7], pvr[0][1][7], pvr[0][2][7], pvr[1][0][7], pvr[1][1][7], pvr[1][2][7], pvr[2][0][7], pvr[2][1][7], pvr[2][2][7]}),
							valid_one_hot({pvr[0][0][6], pvr[0][1][6], pvr[0][2][6], pvr[1][0][6], pvr[1][1][6], pvr[1][2][6], pvr[2][0][6], pvr[2][1][6], pvr[2][2][6]}),
							valid_one_hot({pvr[0][0][5], pvr[0][1][5], pvr[0][2][5], pvr[1][0][5], pvr[1][1][5], pvr[1][2][5], pvr[2][0][5], pvr[2][1][5], pvr[2][2][5]}),
							valid_one_hot({pvr[0][0][4], pvr[0][1][4], pvr[0][2][4], pvr[1][0][4], pvr[1][1][4], pvr[1][2][4], pvr[2][0][4], pvr[2][1][4], pvr[2][2][4]}),
							valid_one_hot({pvr[0][0][3], pvr[0][1][3], pvr[0][2][3], pvr[1][0][3], pvr[1][1][3], pvr[1][2][3], pvr[2][0][3], pvr[2][1][3], pvr[2][2][3]}),
							valid_one_hot({pvr[0][0][2], pvr[0][1][2], pvr[0][2][2], pvr[1][0][2], pvr[1][1][2], pvr[1][2][2], pvr[2][0][2], pvr[2][1][2], pvr[2][2][2]}),
							valid_one_hot({pvr[0][0][1], pvr[0][1][1], pvr[0][2][1], pvr[1][0][1], pvr[1][1][1], pvr[1][2][1], pvr[2][0][1], pvr[2][1][1], pvr[2][2][1]}),
							valid_one_hot({pvr[0][0][0], pvr[0][1][0], pvr[0][2][0], pvr[1][0][0], pvr[1][1][0], pvr[1][2][0], pvr[2][0][0], pvr[2][1][0], pvr[2][2][0]})
						};
					end					
				end

				assign single_candidate_mask 	  = ~rows_contains[row_genvar] & ~cols_contains[col_genvar] & ~squares_contains_single;
				assign single_position_mask_temp  = (single_pos_row | single_pos_col | single_pos_sq) & pvr[row_genvar][col_genvar];
				assign single_position_mask       = (|single_position_mask_temp) ? single_position_mask_temp : 9'b111_111_111;
				assign possibilities_mask   	  = pvr[row_genvar][col_genvar] 
													& single_candidate_mask 
													& single_position_mask 
													& (~candidate_line_c) 
													& ~(candidate_line_r);

				always @(posedge clk_in or posedge reset_in)
				begin
					if (reset_in)
					begin
						one_hot_board_reg[row_genvar][col_genvar]   <= one_hot(unsolved[row_genvar][col_genvar]);
						
						// If the board has a set value, it can only be that value
						// if not, the cell could be anything
						pvr[row_genvar][col_genvar] <= |(one_hot(unsolved[row_genvar][col_genvar])) ? 
																			one_hot(unsolved[row_genvar][col_genvar])
																			: 9'b111_111_111;
					end
					else if (one_hot_board_reg[row_genvar][col_genvar] == 0) 
					begin
						if (valid_one_hot(possibilities_mask))
						begin
							one_hot_board_reg[row_genvar][col_genvar] <= possibilities_mask;
						end
						pvr[row_genvar][col_genvar] <= possibilities_mask;
					end
				end

				assign unsolved[row_genvar][col_genvar]        = board_in[(row_genvar*GRID_SIZE*4)+(col_genvar*4)+3:
																		  (row_genvar*GRID_SIZE*4)+(col_genvar*4)];
				assign solved  [row_genvar][col_genvar]        = bcd(one_hot_board_reg[row_genvar][col_genvar]);
			end
		end
	endgenerate

	generate
		genvar solved_genvar;
		for (solved_genvar = 0; solved_genvar < (GRID_SIZE); solved_genvar = solved_genvar + 1)
		begin: contains_generator
			assign rows_contains[solved_genvar] = (
													one_hot_board_reg[solved_genvar][0]
												|   one_hot_board_reg[solved_genvar][1]
												|   one_hot_board_reg[solved_genvar][2]
												|   one_hot_board_reg[solved_genvar][3]
												|   one_hot_board_reg[solved_genvar][4]
												|   one_hot_board_reg[solved_genvar][5]
												|   one_hot_board_reg[solved_genvar][6]
												|   one_hot_board_reg[solved_genvar][7]
												|   one_hot_board_reg[solved_genvar][8]
											);
			assign cols_contains[solved_genvar] = (
													one_hot_board_reg[0][solved_genvar]
												|   one_hot_board_reg[1][solved_genvar]
												|   one_hot_board_reg[2][solved_genvar]
												|   one_hot_board_reg[3][solved_genvar]
												|   one_hot_board_reg[4][solved_genvar]
												|   one_hot_board_reg[5][solved_genvar]
												|   one_hot_board_reg[6][solved_genvar]
												|   one_hot_board_reg[7][solved_genvar]
												|   one_hot_board_reg[8][solved_genvar]
											);
			assign rows_solved[solved_genvar] = &(rows_contains[solved_genvar]);
			assign cols_solved[solved_genvar] = &(cols_contains[solved_genvar]);
		end
	endgenerate

	generate
		genvar row_square_genvar;
		genvar col_square_genvar;
		for (row_square_genvar = 0; row_square_genvar < 3; row_square_genvar = row_square_genvar + 1)
		begin: squares_generator
			for (col_square_genvar = 0; col_square_genvar < 3; col_square_genvar = col_square_genvar + 1)
			begin
				assign squares_contains[(row_square_genvar * 3) + col_square_genvar] = (
																					one_hot_board_reg[row_square_genvar * 3 + 0][col_square_genvar * 3 + 0]
																				|   one_hot_board_reg[row_square_genvar * 3 + 0][col_square_genvar * 3 + 1]
																				|   one_hot_board_reg[row_square_genvar * 3 + 0][col_square_genvar * 3 + 2]
																				|   one_hot_board_reg[row_square_genvar * 3 + 1][col_square_genvar * 3 + 0]
																				|   one_hot_board_reg[row_square_genvar * 3 + 1][col_square_genvar * 3 + 1]
																				|   one_hot_board_reg[row_square_genvar * 3 + 1][col_square_genvar * 3 + 2]
																				|   one_hot_board_reg[row_square_genvar * 3 + 2][col_square_genvar * 3 + 0]
																				|   one_hot_board_reg[row_square_genvar * 3 + 2][col_square_genvar * 3 + 1]
																				|   one_hot_board_reg[row_square_genvar * 3 + 2][col_square_genvar * 3 + 2]
																			   );
				assign squares_solved[(row_square_genvar * 3) + col_square_genvar] = &(squares_contains[(row_square_genvar * 3) + col_square_genvar]);
			end
		end
	endgenerate

	reg [3:0] square_counter;
	always @(posedge clk_in or posedge reset_in)
	begin
		if (reset_in)
		begin
			square_counter <= 0;
			`RESET_3_BY_9(candidate_line_rows_reg)
			`RESET_3_BY_9(candidate_line_cols_reg)
		end
		else
		begin
			case (square_counter)
				4'd0:
					begin
						candidate_line_rows_reg[0][0] <= get_exclusive_line_possibilities(
																						(pvr[0][0] | pvr[0][1] | pvr[0][2]),
																						(pvr[1][0] | pvr[1][1] | pvr[1][2]),
																						(pvr[2][0] | pvr[2][1] | pvr[2][2])
																					 );
						candidate_line_rows_reg[0][1] <= get_exclusive_line_possibilities(
																						(pvr[1][0] | pvr[1][1] | pvr[1][2]),
																						(pvr[0][0] | pvr[0][1] | pvr[0][2]),
																						(pvr[2][0] | pvr[2][1] | pvr[2][2])
																					 );
						candidate_line_rows_reg[0][2] <= get_exclusive_line_possibilities(
																						(pvr[2][0] | pvr[2][1] | pvr[2][2]),
																						(pvr[0][0] | pvr[0][1] | pvr[0][2]),
																						(pvr[1][0] | pvr[1][1] | pvr[1][2])
																					 );
						candidate_line_cols_reg[0][0] <= get_exclusive_line_possibilities(
																						(pvr[0][0] | pvr[1][0] | pvr[2][0]),
																						(pvr[0][1] | pvr[1][1] | pvr[2][1]),
																						(pvr[0][2] | pvr[1][2] | pvr[2][2])
																					 );
						candidate_line_cols_reg[0][1] <= get_exclusive_line_possibilities(
																						(pvr[0][1] | pvr[1][1] | pvr[2][1]),
																						(pvr[0][0] | pvr[1][0] | pvr[2][0]),
																						(pvr[0][2] | pvr[1][2] | pvr[2][2])
																					 );
						candidate_line_cols_reg[0][2] <= get_exclusive_line_possibilities(
																						(pvr[0][2] | pvr[1][2] | pvr[2][2]),
																						(pvr[0][0] | pvr[1][0] | pvr[2][0]),
																						(pvr[0][1] | pvr[1][1] | pvr[2][1])
																					 );
					end
				4'd1:
					begin
						candidate_line_rows_reg[1][0] <= get_exclusive_line_possibilities(
																						(pvr[0][3] | pvr[0][4] | pvr[0][5]),
																						(pvr[1][3] | pvr[1][4] | pvr[1][5]),
																						(pvr[2][3] | pvr[2][4] | pvr[2][5])
																					 );
						candidate_line_rows_reg[1][1] <= get_exclusive_line_possibilities(
																						(pvr[1][3] | pvr[1][4] | pvr[1][5]),
																						(pvr[0][3] | pvr[0][4] | pvr[0][5]),
																						(pvr[2][3] | pvr[2][4] | pvr[2][5])
																					 );
						candidate_line_rows_reg[1][2] <= get_exclusive_line_possibilities(
																						(pvr[2][3] | pvr[2][4] | pvr[2][5]),
																						(pvr[0][3] | pvr[0][4] | pvr[0][5]),
																						(pvr[1][3] | pvr[1][4] | pvr[1][5])
																					 );
						candidate_line_cols_reg[1][0] <= get_exclusive_line_possibilities(
																						(pvr[0][3] | pvr[1][3] | pvr[2][3]),
																						(pvr[0][4] | pvr[1][4] | pvr[2][4]),
																						(pvr[0][5] | pvr[1][5] | pvr[2][5])
																					 );
						candidate_line_cols_reg[1][1] <= get_exclusive_line_possibilities(
																						(pvr[0][4] | pvr[1][4] | pvr[2][4]),
																						(pvr[0][3] | pvr[1][3] | pvr[2][3]),
																						(pvr[0][5] | pvr[1][5] | pvr[2][5])
																					 );
						candidate_line_cols_reg[1][2] <= get_exclusive_line_possibilities(
																						(pvr[0][5] | pvr[1][5] | pvr[2][5]),
																						(pvr[0][3] | pvr[1][3] | pvr[2][3]),
																						(pvr[0][4] | pvr[1][4] | pvr[2][4])
																					 );					
					end
				4'd2:
					begin
						candidate_line_rows_reg[2][0] <= get_exclusive_line_possibilities(
																						(pvr[0][6] | pvr[0][7] | pvr[0][8]),
																						(pvr[1][6] | pvr[1][7] | pvr[1][8]),
																						(pvr[2][6] | pvr[2][7] | pvr[2][8])
																					 );
						candidate_line_rows_reg[2][1] <= get_exclusive_line_possibilities(
																						(pvr[1][6] | pvr[1][7] | pvr[1][8]),
																						(pvr[0][6] | pvr[0][7] | pvr[0][8]),
																						(pvr[2][6] | pvr[2][7] | pvr[2][8])
																					 );
						candidate_line_rows_reg[2][2] <= get_exclusive_line_possibilities(
																						(pvr[2][6] | pvr[2][7] | pvr[2][8]),
																						(pvr[0][6] | pvr[0][7] | pvr[0][8]),
																						(pvr[1][6] | pvr[1][7] | pvr[1][8])
																					 );
						candidate_line_cols_reg[2][0] <= get_exclusive_line_possibilities(
																						(pvr[0][6] | pvr[1][6] | pvr[2][6]),
																						(pvr[0][7] | pvr[1][7] | pvr[2][7]),
																						(pvr[0][8] | pvr[1][8] | pvr[2][8])
																					 );
						candidate_line_cols_reg[2][1] <= get_exclusive_line_possibilities(
																						(pvr[0][7] | pvr[1][7] | pvr[2][7]),
																						(pvr[0][6] | pvr[1][6] | pvr[2][6]),
																						(pvr[0][8] | pvr[1][8] | pvr[2][8])
																					 );
						candidate_line_cols_reg[2][2] <= get_exclusive_line_possibilities(
																						(pvr[0][8] | pvr[1][8] | pvr[2][8]),
																						(pvr[0][6] | pvr[1][6] | pvr[2][6]),
																						(pvr[0][7] | pvr[1][7] | pvr[2][7])
																					 );	
					end
				4'd3:
					begin
						candidate_line_rows_reg[3][0] <= get_exclusive_line_possibilities(
																						(pvr[3][0] | pvr[3][1] | pvr[3][2]),
																						(pvr[4][0] | pvr[4][1] | pvr[4][2]),
																						(pvr[5][0] | pvr[5][1] | pvr[5][2])
																					 );
						candidate_line_rows_reg[3][1] <= get_exclusive_line_possibilities(
																						(pvr[4][0] | pvr[4][1] | pvr[4][2]),
																						(pvr[3][0] | pvr[3][1] | pvr[3][2]),
																						(pvr[5][0] | pvr[5][1] | pvr[5][2])
																					 );
						candidate_line_rows_reg[3][2] <= get_exclusive_line_possibilities(
																						(pvr[5][0] | pvr[5][1] | pvr[5][2]),
																						(pvr[3][0] | pvr[3][1] | pvr[3][2]),
																						(pvr[4][0] | pvr[4][1] | pvr[4][2])
																					 );
						candidate_line_cols_reg[3][0] <= get_exclusive_line_possibilities(
																						(pvr[3][0] | pvr[4][0] | pvr[5][0]),
																						(pvr[3][1] | pvr[4][1] | pvr[5][1]),
																						(pvr[3][2] | pvr[4][2] | pvr[5][2])
																					 );
						candidate_line_cols_reg[3][1] <= get_exclusive_line_possibilities(
																						(pvr[3][1] | pvr[4][1] | pvr[5][1]),
																						(pvr[3][0] | pvr[4][0] | pvr[5][0]),
																						(pvr[3][2] | pvr[4][2] | pvr[5][2])
																					 );
						candidate_line_cols_reg[3][2] <= get_exclusive_line_possibilities(
																						(pvr[3][2] | pvr[4][2] | pvr[5][2]),
																						(pvr[3][0] | pvr[4][0] | pvr[5][0]),
																						(pvr[3][1] | pvr[4][1] | pvr[5][1])
																					 );
					end
				4'd4:
					begin
						candidate_line_rows_reg[4][0] <= get_exclusive_line_possibilities(
																						(pvr[3][3] | pvr[3][4] | pvr[3][5]),
																						(pvr[4][3] | pvr[4][4] | pvr[4][5]),
																						(pvr[5][3] | pvr[5][4] | pvr[5][5])
																					 );
						candidate_line_rows_reg[4][1] <= get_exclusive_line_possibilities(
																						(pvr[4][3] | pvr[4][4] | pvr[4][5]),
																						(pvr[3][3] | pvr[3][4] | pvr[3][5]),
																						(pvr[5][3] | pvr[5][4] | pvr[5][5])
																					 );
						candidate_line_rows_reg[4][2] <= get_exclusive_line_possibilities(
																						(pvr[5][3] | pvr[5][4] | pvr[5][5]),
																						(pvr[3][3] | pvr[3][4] | pvr[3][5]),
																						(pvr[4][3] | pvr[4][4] | pvr[4][5])
																					 );
						candidate_line_cols_reg[4][0] <= get_exclusive_line_possibilities(
																						(pvr[3][3] | pvr[4][3] | pvr[5][3]),
																						(pvr[3][4] | pvr[4][4] | pvr[5][4]),
																						(pvr[3][5] | pvr[4][5] | pvr[5][5])
																					 );
						candidate_line_cols_reg[4][1] <= get_exclusive_line_possibilities(
																						(pvr[3][4] | pvr[4][4] | pvr[5][4]),
																						(pvr[3][3] | pvr[4][3] | pvr[5][3]),
																						(pvr[3][5] | pvr[4][5] | pvr[5][5])
																					 );
						candidate_line_cols_reg[4][2] <= get_exclusive_line_possibilities(
																						(pvr[3][5] | pvr[4][5] | pvr[5][5]),
																						(pvr[3][3] | pvr[4][3] | pvr[5][3]),
																						(pvr[3][4] | pvr[4][4] | pvr[5][4])
																					 );					
					end
				4'd5:
					begin
						candidate_line_rows_reg[5][0] <= get_exclusive_line_possibilities(
																						(pvr[3][6] | pvr[3][7] | pvr[3][8]),
																						(pvr[4][6] | pvr[4][7] | pvr[4][8]),
																						(pvr[5][6] | pvr[5][7] | pvr[5][8])
																					 );
						candidate_line_rows_reg[5][1] <= get_exclusive_line_possibilities(
																						(pvr[4][6] | pvr[4][7] | pvr[4][8]),
																						(pvr[3][6] | pvr[3][7] | pvr[3][8]),
																						(pvr[5][6] | pvr[5][7] | pvr[5][8])
																					 );
						candidate_line_rows_reg[5][2] <= get_exclusive_line_possibilities(
																						(pvr[5][6] | pvr[5][7] | pvr[5][8]),
																						(pvr[3][6] | pvr[3][7] | pvr[3][8]),
																						(pvr[4][6] | pvr[4][7] | pvr[4][8])
																					 );
						candidate_line_cols_reg[5][0] <= get_exclusive_line_possibilities(
																						(pvr[3][6] | pvr[4][6] | pvr[5][6]),
																						(pvr[3][7] | pvr[4][7] | pvr[5][7]),
																						(pvr[3][8] | pvr[4][8] | pvr[5][8])
																					 );
						candidate_line_cols_reg[5][1] <= get_exclusive_line_possibilities(
																						(pvr[3][7] | pvr[4][7] | pvr[5][7]),
																						(pvr[3][6] | pvr[4][6] | pvr[5][6]),
																						(pvr[3][8] | pvr[4][8] | pvr[5][8])
																					 );
						candidate_line_cols_reg[5][2] <= get_exclusive_line_possibilities(
																						(pvr[3][8] | pvr[4][8] | pvr[5][8]),
																						(pvr[3][6] | pvr[4][6] | pvr[5][6]),
																						(pvr[3][7] | pvr[4][7] | pvr[5][7])
																					 );	
					end
				4'd6:
					begin
						candidate_line_rows_reg[6][0] <= get_exclusive_line_possibilities(
																						(pvr[6][0] | pvr[6][1] | pvr[6][2]),
																						(pvr[7][0] | pvr[7][1] | pvr[7][2]),
																						(pvr[8][0] | pvr[8][1] | pvr[8][2])
																					 );
						candidate_line_rows_reg[6][1] <= get_exclusive_line_possibilities(
																						(pvr[7][0] | pvr[7][1] | pvr[7][2]),
																						(pvr[6][0] | pvr[6][1] | pvr[6][2]),
																						(pvr[8][0] | pvr[8][1] | pvr[8][2])
																					 );
						candidate_line_rows_reg[6][2] <= get_exclusive_line_possibilities(
																						(pvr[8][0] | pvr[8][1] | pvr[8][2]),
																						(pvr[6][0] | pvr[6][1] | pvr[6][2]),
																						(pvr[7][0] | pvr[7][1] | pvr[7][2])
																					 );
						candidate_line_cols_reg[6][0] <= get_exclusive_line_possibilities(
																						(pvr[6][0] | pvr[7][0] | pvr[8][0]),
																						(pvr[6][1] | pvr[7][1] | pvr[8][1]),
																						(pvr[6][2] | pvr[7][2] | pvr[8][2])
																					 );
						candidate_line_cols_reg[6][1] <= get_exclusive_line_possibilities(
																						(pvr[6][1] | pvr[7][1] | pvr[8][1]),
																						(pvr[6][0] | pvr[7][0] | pvr[8][0]),
																						(pvr[6][2] | pvr[7][2] | pvr[8][2])
																					 );
						candidate_line_cols_reg[6][2] <= get_exclusive_line_possibilities(
																						(pvr[6][2] | pvr[7][2] | pvr[8][2]),
																						(pvr[6][0] | pvr[7][0] | pvr[8][0]),
																						(pvr[6][1] | pvr[7][1] | pvr[8][1])
																					 );
					end
				4'd7:
					begin
						candidate_line_rows_reg[7][0] <= get_exclusive_line_possibilities(
																						(pvr[6][3] | pvr[6][4] | pvr[6][5]),
																						(pvr[7][3] | pvr[7][4] | pvr[7][5]),
																						(pvr[8][3] | pvr[8][4] | pvr[8][5])
																					 );
						candidate_line_rows_reg[7][1] <= get_exclusive_line_possibilities(
																						(pvr[7][3] | pvr[7][4] | pvr[7][5]),
																						(pvr[6][3] | pvr[6][4] | pvr[6][5]),
																						(pvr[8][3] | pvr[8][4] | pvr[8][5])
																					 );
						candidate_line_rows_reg[7][2] <= get_exclusive_line_possibilities(
																						(pvr[8][3] | pvr[8][4] | pvr[8][5]),
																						(pvr[6][3] | pvr[6][4] | pvr[6][5]),
																						(pvr[7][3] | pvr[7][4] | pvr[7][5])
																					 );
						candidate_line_cols_reg[7][0] <= get_exclusive_line_possibilities(
																						(pvr[6][3] | pvr[7][3] | pvr[8][3]),
																						(pvr[6][4] | pvr[7][4] | pvr[8][4]),
																						(pvr[6][5] | pvr[7][5] | pvr[8][5])
																					 );
						candidate_line_cols_reg[7][1] <= get_exclusive_line_possibilities(
																						(pvr[6][4] | pvr[7][4] | pvr[8][4]),
																						(pvr[6][3] | pvr[7][3] | pvr[8][3]),
																						(pvr[6][5] | pvr[7][5] | pvr[8][5])
																					 );
						candidate_line_cols_reg[7][2] <= get_exclusive_line_possibilities(
																						(pvr[6][5] | pvr[7][5] | pvr[8][5]),
																						(pvr[6][3] | pvr[7][3] | pvr[8][3]),
																						(pvr[6][4] | pvr[7][4] | pvr[8][4])
																					 );					
					end
				4'd8:
					begin
						candidate_line_rows_reg[8][0] <= get_exclusive_line_possibilities(
																						(pvr[6][6] | pvr[6][7] | pvr[6][8]),
																						(pvr[7][6] | pvr[7][7] | pvr[7][8]),
																						(pvr[8][6] | pvr[8][7] | pvr[8][8])
																					 );
						candidate_line_rows_reg[8][1] <= get_exclusive_line_possibilities(
																						(pvr[7][6] | pvr[7][7] | pvr[7][8]),
																						(pvr[6][6] | pvr[6][7] | pvr[6][8]),
																						(pvr[8][6] | pvr[8][7] | pvr[8][8])
																					 );
						candidate_line_rows_reg[8][2] <= get_exclusive_line_possibilities(
																						(pvr[8][6] | pvr[8][7] | pvr[8][8]),
																						(pvr[6][6] | pvr[6][7] | pvr[6][8]),
																						(pvr[7][6] | pvr[7][7] | pvr[7][8])
																					 );
						candidate_line_cols_reg[8][0] <= get_exclusive_line_possibilities(
																						(pvr[6][6] | pvr[7][6] | pvr[8][6]),
																						(pvr[6][7] | pvr[7][7] | pvr[8][7]),
																						(pvr[6][8] | pvr[7][8] | pvr[8][8])
																					 );
						candidate_line_cols_reg[8][1] <= get_exclusive_line_possibilities(
																						(pvr[6][7] | pvr[7][7] | pvr[8][7]),
																						(pvr[6][6] | pvr[7][6] | pvr[8][6]),
																						(pvr[6][8] | pvr[7][8] | pvr[8][8])
																					 );
						candidate_line_cols_reg[8][2] <= get_exclusive_line_possibilities(
																						(pvr[6][8] | pvr[7][8] | pvr[8][8]),
																						(pvr[6][6] | pvr[7][6] | pvr[8][6]),
																						(pvr[6][7] | pvr[7][7] | pvr[8][7])
																					 );	
					end
				default: ;
			endcase

			if (square_counter < 8)
			begin
				square_counter <= square_counter + 1;
			end
			else 
			begin
				square_counter <= 0;	
			end
		end
	end
endmodule
