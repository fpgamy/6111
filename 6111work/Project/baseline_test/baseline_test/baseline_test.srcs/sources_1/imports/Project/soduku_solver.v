module soduku_solver(
						clk_in         ,
						reset_in       ,
						board_in       ,
						board_out      ,
						done_out
					);
// INCLUDES
//
	`include "common_lib.v"
	`include "soduku_lib.v"
	// `include "soduku_tb_lib.v"

//
// PARAMETERS
//
	localparam   DONE_COUNTDOWN_START = 81;
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

    // the depth in the pvr_prevs we need to restore from
    reg     [15:0]                        guess_number;
    reg     [(GRID_SIZE*GRID_SIZE-1):0] error_detected;

// REG/WIRE DEFINITIONS
//
	// Contains the current progress of the board
	// Uses one hot encoding
	reg    [(GRID_SIZE-1):0] one_hot_board_reg   [0:(GRID_SIZE-1)] [0:(GRID_SIZE-1)];

	// Contains 1s where the possible values are
	reg    [(GRID_SIZE-1):0] pvr [0:(GRID_SIZE-1)] [0:(GRID_SIZE-1)];

	// Contains the past 16 pre-guess pvrs
	reg    [(GRID_SIZE-1):0]   pvr_prevs [0:(GRID_SIZE-1)] [0:(GRID_SIZE-1)] [0:(MAX_GUESSES-1)];

	// Masks of the pvr due to the hidden and naked groups
	reg    [(GRID_SIZE-1):0] gmr [0:(GRID_SIZE-1)] [0:(GRID_SIZE-1)];

	// A grid containing masks for guesses
	reg    [(GRID_SIZE-1):0] guesses   [0:(MAX_GUESSES-1)];
	// the row we will guess next
	reg 	[3:0]			 guess_row [0:(MAX_GUESSES-1)];
	// the column we will guess next
	reg     [3:0]			 guess_col [0:(MAX_GUESSES-1)];

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
	// Contains ones where the columns are solved
	wire    [(GRID_SIZE-1):0] cols_solved;
	// Contains ones where the squares are solved
	wire    [(GRID_SIZE-1):0] squares_solved;

	// Contains ones where the numbers are contained
	wire    [(GRID_SIZE-1):0] rows_contains         [0:(GRID_SIZE-1)];

	wire    [(GRID_SIZE-1):0] cols_contains         [0:(GRID_SIZE-1)];

	wire    [(GRID_SIZE-1):0] squares_contains      [0:(GRID_SIZE-1)];

	// candidate line [i][j] is the mask of values which exist on the ith square on the jth line in the square.
	// candidate lines rows
	reg     [(GRID_SIZE-1):0] candidate_line_rows_reg   [(GRID_SIZE-1):0] [2:0];
	// candidate lines columns
	reg     [(GRID_SIZE-1):0] candidate_line_cols_reg   [(GRID_SIZE-1):0] [2:0];
	// groups
	wire    [(GRID_SIZE-1):0] row_groups [(GRID_SIZE-1):0] [(GRID_SIZE-1):0];
	wire    [(GRID_SIZE-1):0] col_groups [(GRID_SIZE-1):0] [(GRID_SIZE-1):0];
	wire    [(GRID_SIZE-1):0] squ_groups [(GRID_SIZE-1):0] [(GRID_SIZE-1):0];

	reg     [6:0]             			done_countdown [(GRID_SIZE-1):0] [(GRID_SIZE-1):0];
	wire    [6:0]             			done_countdown_orred;
	wire                      			timeout;


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
				// contains 0s where there is space
				wire    [(GRID_SIZE-1):0] single_pos_row;
				wire    [(GRID_SIZE-1):0] single_pos_col;
				wire    [(GRID_SIZE-1):0] single_pos_sq;

				wire    [(GRID_SIZE-1):0] possibilities_mask;
				wire    [(GRID_SIZE-1):0] candidate_line_r;
				wire    [(GRID_SIZE-1):0] candidate_line_c;

				wire 					  guess_this_cell;
				wire 					  full_row;
				wire 					  full_col;

				assign full_row = 	valid_one_hot(pvr[row_genvar][0]) &
									valid_one_hot(pvr[row_genvar][1]) &
									valid_one_hot(pvr[row_genvar][2]) &
									valid_one_hot(pvr[row_genvar][3]) &
									valid_one_hot(pvr[row_genvar][4]) &
									valid_one_hot(pvr[row_genvar][5]) &
									valid_one_hot(pvr[row_genvar][6]) &
									valid_one_hot(pvr[row_genvar][7]) &
									valid_one_hot(pvr[row_genvar][8]);
				assign full_col = 	valid_one_hot(pvr[0][col_genvar]) &
									valid_one_hot(pvr[1][col_genvar]) &
									valid_one_hot(pvr[2][col_genvar]) &
									valid_one_hot(pvr[3][col_genvar]) &
									valid_one_hot(pvr[4][col_genvar]) &
									valid_one_hot(pvr[5][col_genvar]) &
									valid_one_hot(pvr[6][col_genvar]) &
									valid_one_hot(pvr[7][col_genvar]) &
									valid_one_hot(pvr[8][col_genvar]);

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

				assign single_candidate_mask 	  = (~rows_contains[row_genvar]) & (~cols_contains[col_genvar]) & (~squares_contains_single);
				assign single_position_mask_temp  = (single_pos_row | single_pos_col | single_pos_sq) & pvr[row_genvar][col_genvar];
				assign single_position_mask       = (|single_position_mask_temp) ? single_position_mask_temp : 9'b111_111_111;
				assign guess_this_cell 			  = (timeout == 1) && (row_genvar == guess_row[guess_number]) && (col_genvar == guess_col[guess_number]);
				assign possibilities_mask   	  = pvr[row_genvar][col_genvar]
													& single_candidate_mask
													& single_position_mask
													& (~candidate_line_c)
													& (~candidate_line_r)
													& gmr[row_genvar][col_genvar]
													& (guess_this_cell ? (guesses[guess_number]) : (9'b111_111_111));

				always @(posedge clk_in)
				begin
					if (reset_in)
					begin
						done_countdown[row_genvar][col_genvar]            <= DONE_COUNTDOWN_START;
						error_detected[row_genvar*GRID_SIZE + col_genvar] <= 1'b0;
						one_hot_board_reg[row_genvar][col_genvar]         <= one_hot(unsolved[row_genvar][col_genvar]);
						// If the board has a set value, it can only be that value
						// if not, the cell could be anything
						pvr[row_genvar][col_genvar] <= |(one_hot(unsolved[row_genvar][col_genvar])) ?
																			one_hot(unsolved[row_genvar][col_genvar])
																			: 9'b111_111_111;
						`RESET_PREVS(pvr_prevs[row_genvar][col_genvar], |(one_hot(unsolved[row_genvar][col_genvar])) ?
																			one_hot(unsolved[row_genvar][col_genvar])
																			: 9'b111_111_111);
					end
					else if ((|error_detected) & (|guess_number))
					begin
						error_detected[row_genvar*GRID_SIZE + col_genvar] <= 1'b0;
						done_countdown[row_genvar][col_genvar] <= DONE_COUNTDOWN_START;
						pvr[row_genvar][col_genvar] <= pvr_prevs[row_genvar][col_genvar][guess_number-1];

						if (valid_one_hot(pvr_prevs[row_genvar][col_genvar][guess_number-1]))
						begin
							one_hot_board_reg[row_genvar][col_genvar] <= pvr_prevs[row_genvar][col_genvar][guess_number-1];
						end
						else
						begin
							one_hot_board_reg[row_genvar][col_genvar] <= 0;
						end
					end
					else if ((full_row & ~(rows_solved[row_genvar])) | (full_col & ~(cols_solved[col_genvar])))
					begin
						// $display("ROW: %d, COL: %d", row_genvar, col_genvar);
						// $display("ERROR DETECTED HERE");
						// $display("FULL_COL: %d", full_col);
						// $display("FULL_ROW: %d", full_row);

						// $display("Rows Solved: ");
						// $display("%b %b %b %b %b %b %b %b %b", rows_solved[0],
						// 									   rows_solved[1],
						// 									   rows_solved[2],
						// 									   rows_solved[3],
						// 									   rows_solved[4],
						// 									   rows_solved[5],
						// 									   rows_solved[6],
						// 									   rows_solved[7],
						// 									   rows_solved[8] );

						// $display("Columns Solved: ");
						// $display("%b %b %b %b %b %b %b %b %b", cols_solved[0],
						// 									   cols_solved[1],
						// 									   cols_solved[2],
						// 									   cols_solved[3],
						// 									   cols_solved[4],
						// 									   cols_solved[5],
						// 									   cols_solved[6],
						// 									   cols_solved[7],
						// 									   cols_solved[8] );

						error_detected[row_genvar*GRID_SIZE + col_genvar] <= 1;
						// $display("Output: ");
						// `PRINTGRID(solved);
					end
					else if (one_hot_board_reg[row_genvar][col_genvar] == 0)
					begin
						if (possibilities_mask == 0)
						begin
							error_detected[row_genvar*GRID_SIZE + col_genvar] <= 1;
						end
						if (valid_one_hot(possibilities_mask))
						begin
							one_hot_board_reg[row_genvar][col_genvar] <= possibilities_mask;
						end
						pvr[row_genvar][col_genvar] <= possibilities_mask;

						if (timeout)
						begin
							done_countdown[row_genvar][col_genvar] <= DONE_COUNTDOWN_START;
						end
						else if ((possibilities_mask == pvr[row_genvar][col_genvar]) && (done_countdown[row_genvar][col_genvar] > 0))
						begin
							done_countdown[row_genvar][col_genvar] <= done_countdown[row_genvar][col_genvar] - 1;
						end
						else if (done_countdown[row_genvar][col_genvar] > 0)
						begin // something changed
							done_countdown[row_genvar][col_genvar] <= DONE_COUNTDOWN_START;
						end
					end
					else if (done_countdown[row_genvar][col_genvar] > 0)
					begin // already solved
						done_countdown[row_genvar][col_genvar] <= 0;
					end

					if ((timeout == 0) && (row_genvar == guess_row[guess_number]) && (col_genvar == guess_col[guess_number]))
					begin
						pvr_prevs[row_genvar][col_genvar][guess_number] <= (~guesses[guess_number]) & pvr[row_genvar][col_genvar];
					end
					else if (~timeout)
					begin
						pvr_prevs[row_genvar][col_genvar][guess_number] <= pvr[row_genvar][col_genvar];
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

//
// DONE/TIMEOUT
//

	assign done_countdown_orred = `OR_GRID(done_countdown);
	assign timeout = ~|done_countdown_orred;
	assign done_out = (&{rows_solved, cols_solved, squares_solved});// | timeout | (|error_detected);

//
// SEQUENTIAL
//

	// Naked group and Hidden group alg

	reg  [3:0] row_counter;
	reg  [3:0] col_counter;
	wire [3:0] sq_number;

	wire    [3:0]             number_of_ones_in_mask;
	wire    [3:0]             number_of_zero_masks_rows;
	wire    [3:0]             number_of_zero_masks_cols;
	wire    [3:0]             number_of_zero_masks_sqs;

	wire    [(GRID_SIZE-1):0] anded_masks_row [(GRID_SIZE-1):0];
	wire    [(GRID_SIZE-1):0] anded_masks_col [(GRID_SIZE-1):0];
	wire    [(GRID_SIZE-1):0] anded_masks_sq  [(GRID_SIZE-1):0];

	wire    [(GRID_SIZE-1):0] pvr_sq		  [(GRID_SIZE-1):0];

	wire    [(GRID_SIZE-1):0] hidden_rows_mask;
	wire    [(GRID_SIZE-1):0] hidden_cols_mask;
	wire    [(GRID_SIZE-1):0] hidden_sqs_mask;
	wire    [(GRID_SIZE-1):0] naked_rows_mask_1;
	wire                [3:0] naked_rows_sum_1 [(GRID_SIZE-1):0];
	wire    [(GRID_SIZE-1):0] naked_rows_mask_2;
	wire                [3:0] naked_rows_sum_2 [(GRID_SIZE-1):0];
	wire    [(GRID_SIZE-1):0] naked_rows_mask;
	wire    [(GRID_SIZE-1):0] naked_cols_mask_1;
	wire                [3:0] naked_cols_sum_1 [(GRID_SIZE-1):0];
	wire    [(GRID_SIZE-1):0] naked_cols_mask_2;
	wire                [3:0] naked_cols_sum_2 [(GRID_SIZE-1):0];
	wire    [(GRID_SIZE-1):0] naked_cols_mask;
	wire    [(GRID_SIZE-1):0] naked_sqs_mask_1;
	wire                [3:0] naked_sqs_sum_1  [(GRID_SIZE-1):0];
	wire    [(GRID_SIZE-1):0] naked_sqs_mask_2;
	wire                [3:0] naked_sqs_sum_2  [(GRID_SIZE-1):0];
	wire    [(GRID_SIZE-1):0] naked_sqs_mask;

	wire                      hidden_group_detected_row;
	wire                      hidden_group_detected_col;
	wire                      hidden_group_detected_sq;
	wire 					  hidden_group_detected;

	wire                      naked_group_detected_row;
	wire                      naked_group_detected_col;
	wire                      naked_group_detected_sq;
	wire 					  naked_group_detected;

	generate
		genvar a_genvar;
		for (a_genvar = 0; a_genvar < (GRID_SIZE); a_genvar = a_genvar + 1)
		begin: a_generator
			assign anded_masks_row[a_genvar] = pvr[row_counter][col_counter] & pvr[row_counter][a_genvar];
			assign anded_masks_col[a_genvar] = pvr[row_counter][col_counter] & pvr[a_genvar][col_counter];
			if (a_genvar < 3)
			begin
				assign pvr_sq[a_genvar]  		 = mux9mask(sq_number,
															pvr[0][0+a_genvar],
															pvr[0][3+a_genvar],
															pvr[0][6+a_genvar],
															pvr[3][0+a_genvar],
															pvr[3][3+a_genvar],
															pvr[3][6+a_genvar],
															pvr[6][0+a_genvar],
															pvr[6][3+a_genvar],
															pvr[6][6+a_genvar]
															);
				assign anded_masks_sq[a_genvar]  = pvr[row_counter][col_counter] & pvr_sq[a_genvar];
			end
			else if (a_genvar < 6)
			begin
				assign pvr_sq[a_genvar]  		 = mux9mask(sq_number,
															pvr[1][0+a_genvar-3],
															pvr[1][3+a_genvar-3],
															pvr[1][6+a_genvar-3],
															pvr[4][0+a_genvar-3],
															pvr[4][3+a_genvar-3],
															pvr[4][6+a_genvar-3],
															pvr[7][0+a_genvar-3],
															pvr[7][3+a_genvar-3],
															pvr[7][6+a_genvar-3]
															);
				assign anded_masks_sq[a_genvar]  = pvr[row_counter][col_counter] & pvr_sq[a_genvar];
			end
			else
			begin
				assign pvr_sq[a_genvar]			 = mux9mask(sq_number,
															pvr[2][0+a_genvar-6],
															pvr[2][3+a_genvar-6],
															pvr[2][6+a_genvar-6],
															pvr[5][0+a_genvar-6],
															pvr[5][3+a_genvar-6],
															pvr[5][6+a_genvar-6],
															pvr[8][0+a_genvar-6],
															pvr[8][3+a_genvar-6],
															pvr[8][6+a_genvar-6]
															);
				assign anded_masks_sq[a_genvar]  = pvr[row_counter][col_counter] & pvr_sq[a_genvar];
			end
		end
	endgenerate

	assign sq_number = get_square(row_counter, col_counter);

	assign hidden_rows_mask          = `HIDDEN_GROUP_MASK(anded_masks_row);
	assign hidden_cols_mask          = `HIDDEN_GROUP_MASK(anded_masks_col);
	assign hidden_sqs_mask           = `HIDDEN_GROUP_MASK(anded_masks_sq);
	// also need to check the ANDED masks
	`SET_ARR_TO_SUM(naked_rows_sum_1, anded_masks_row);
	assign naked_rows_mask_1		 = (`NAKED_GROUP_MASK(naked_rows_sum_1, number_of_ones_in_mask));
	`SET_ARR_TO_SUM(naked_rows_sum_2, pvr[row_counter]);
	assign naked_rows_mask_2		 = (`NAKED_GROUP_MASK(naked_rows_sum_2, number_of_ones_in_mask));
	`SET_ARR_TO_SUM(naked_cols_sum_1, anded_masks_col);
	assign naked_cols_mask_1		 = (`NAKED_GROUP_MASK(naked_cols_sum_1, number_of_ones_in_mask));
	`SET_ARR_TO_SUM_2D(naked_cols_sum_2, pvr, col_counter);
	assign naked_cols_mask_2		 = (`NAKED_GROUP_MASK(naked_cols_sum_2, number_of_ones_in_mask));
	`SET_ARR_TO_SUM(naked_sqs_sum_1, anded_masks_sq);
	assign naked_sqs_mask_1 		 = (`NAKED_GROUP_MASK(naked_sqs_sum_1, number_of_ones_in_mask));
	`SET_ARR_TO_SUM(naked_sqs_sum_2, pvr_sq);
	assign naked_sqs_mask_2			 = (`NAKED_GROUP_MASK(naked_sqs_sum_2, number_of_ones_in_mask));

	assign naked_cols_mask           = naked_cols_mask_1 & naked_cols_mask_2;
	assign naked_rows_mask           = naked_rows_mask_1 & naked_rows_mask_2;
	assign naked_sqs_mask            = naked_sqs_mask_1 & naked_sqs_mask_2;

	assign number_of_ones_in_mask    = `SUM_L9_MASK(pvr[row_counter][col_counter]);
	assign number_of_zero_masks_rows = 9-(`SUM_L9_MASK(hidden_rows_mask));
	assign number_of_zero_masks_cols = 9-(`SUM_L9_MASK(hidden_cols_mask));
	assign number_of_zero_masks_sqs  = 9-(`SUM_L9_MASK(hidden_sqs_mask));

	assign hidden_group_detected_row = (naked_group_detected == 0) && (number_of_ones_in_mask > 1) && (number_of_ones_in_mask < 9) && (9 == (number_of_ones_in_mask + number_of_zero_masks_rows));
	assign hidden_group_detected_col = (naked_group_detected == 0) && (number_of_ones_in_mask > 1) && (number_of_ones_in_mask < 9) && (9 == (number_of_ones_in_mask + number_of_zero_masks_cols));
	assign hidden_group_detected_sq  = (naked_group_detected == 0) && (number_of_ones_in_mask > 1) && (number_of_ones_in_mask < 9) && (9 == (number_of_ones_in_mask + number_of_zero_masks_sqs));

	assign  naked_group_detected  = naked_group_detected_sq  | naked_group_detected_col  | naked_group_detected_row;
	assign  hidden_group_detected = hidden_group_detected_sq | hidden_group_detected_col | hidden_group_detected_row;

	assign naked_group_detected_row  = (number_of_ones_in_mask > 1) && (number_of_ones_in_mask < 9) && (number_of_ones_in_mask == `SUM_L9_MASK(naked_rows_mask));
	assign naked_group_detected_col  = (number_of_ones_in_mask > 1) && (number_of_ones_in_mask < 9) && (number_of_ones_in_mask == `SUM_L9_MASK(naked_cols_mask));
	assign naked_group_detected_sq   = (number_of_ones_in_mask > 1) && (number_of_ones_in_mask < 9) && (number_of_ones_in_mask == `SUM_L9_MASK(naked_sqs_mask));

	always @(posedge clk_in)
	begin
		if (reset_in)
		begin
			`RESET_GRID(gmr, 9'b111_111_111);
			row_counter <= 0;
			col_counter <= 0;
		end
		else if (|error_detected)
		begin
			`RESET_GRID(gmr, 9'b111_111_111);
		end
		else
		begin
			if (row_counter == 4'd8)
			begin
				if (col_counter == 4'd8)
				begin
					col_counter <= 4'b0;
				end
				else
				begin
					col_counter <= col_counter + 1;
				end
				row_counter <= 4'b0;
			end
			else
			begin
				row_counter <= row_counter + 1;
			end

			if (hidden_group_detected_row)
			begin
				`ASSIGN_ARR_9(gmr[row_counter], anded_masks_row, hidden_rows_mask);
			end
			if (hidden_group_detected_col)
			begin
				`ASSIGN_ARR_TO_DIM_2_9(gmr, anded_masks_col, col_counter, hidden_cols_mask);
			end
			if (hidden_group_detected_sq)
			begin
				case(sq_number)
					0:
						begin
							gmr[0][0] <= hidden_sqs_mask[0] ? anded_masks_sq[0] : gmr[0][0];
							gmr[0][1] <= hidden_sqs_mask[1] ? anded_masks_sq[1] : gmr[0][1];
							gmr[0][2] <= hidden_sqs_mask[2] ? anded_masks_sq[2] : gmr[0][2];
							gmr[1][0] <= hidden_sqs_mask[3] ? anded_masks_sq[3] : gmr[1][0];
							gmr[1][1] <= hidden_sqs_mask[4] ? anded_masks_sq[4] : gmr[1][1];
							gmr[1][2] <= hidden_sqs_mask[5] ? anded_masks_sq[5] : gmr[1][2];
							gmr[2][0] <= hidden_sqs_mask[6] ? anded_masks_sq[6] : gmr[2][0];
							gmr[2][1] <= hidden_sqs_mask[7] ? anded_masks_sq[7] : gmr[2][1];
							gmr[2][2] <= hidden_sqs_mask[8] ? anded_masks_sq[8] : gmr[2][2];
						end
					1:
						begin
							gmr[0][3] <= hidden_sqs_mask[0] ? anded_masks_sq[0] : gmr[0][3];
							gmr[0][4] <= hidden_sqs_mask[1] ? anded_masks_sq[1] : gmr[0][4];
							gmr[0][5] <= hidden_sqs_mask[2] ? anded_masks_sq[2] : gmr[0][5];
							gmr[1][3] <= hidden_sqs_mask[3] ? anded_masks_sq[3] : gmr[1][3];
							gmr[1][4] <= hidden_sqs_mask[4] ? anded_masks_sq[4] : gmr[1][4];
							gmr[1][5] <= hidden_sqs_mask[5] ? anded_masks_sq[5] : gmr[1][5];
							gmr[2][3] <= hidden_sqs_mask[6] ? anded_masks_sq[6] : gmr[2][3];
							gmr[2][4] <= hidden_sqs_mask[7] ? anded_masks_sq[7] : gmr[2][4];
							gmr[2][5] <= hidden_sqs_mask[8] ? anded_masks_sq[8] : gmr[2][5];
						end
					2:
						begin
							gmr[0][6] <= hidden_sqs_mask[0] ? anded_masks_sq[0] : gmr[0][6];
							gmr[0][7] <= hidden_sqs_mask[1] ? anded_masks_sq[1] : gmr[0][7];
							gmr[0][8] <= hidden_sqs_mask[2] ? anded_masks_sq[2] : gmr[0][8];
							gmr[1][6] <= hidden_sqs_mask[3] ? anded_masks_sq[3] : gmr[1][6];
							gmr[1][7] <= hidden_sqs_mask[4] ? anded_masks_sq[4] : gmr[1][7];
							gmr[1][8] <= hidden_sqs_mask[5] ? anded_masks_sq[5] : gmr[1][8];
							gmr[2][6] <= hidden_sqs_mask[6] ? anded_masks_sq[6] : gmr[2][6];
							gmr[2][7] <= hidden_sqs_mask[7] ? anded_masks_sq[7] : gmr[2][7];
							gmr[2][8] <= hidden_sqs_mask[8] ? anded_masks_sq[8] : gmr[2][8];
						end
					3:
						begin
							gmr[3][0] <= hidden_sqs_mask[0] ? anded_masks_sq[0] : gmr[3][0];
							gmr[3][1] <= hidden_sqs_mask[1] ? anded_masks_sq[1] : gmr[3][1];
							gmr[3][2] <= hidden_sqs_mask[2] ? anded_masks_sq[2] : gmr[3][2];
							gmr[4][0] <= hidden_sqs_mask[3] ? anded_masks_sq[3] : gmr[4][0];
							gmr[4][1] <= hidden_sqs_mask[4] ? anded_masks_sq[4] : gmr[4][1];
							gmr[4][2] <= hidden_sqs_mask[5] ? anded_masks_sq[5] : gmr[4][2];
							gmr[5][0] <= hidden_sqs_mask[6] ? anded_masks_sq[6] : gmr[5][0];
							gmr[5][1] <= hidden_sqs_mask[7] ? anded_masks_sq[7] : gmr[5][1];
							gmr[5][2] <= hidden_sqs_mask[8] ? anded_masks_sq[8] : gmr[5][2];
						end
					4:
						begin
							gmr[3][3] <= hidden_sqs_mask[0] ? anded_masks_sq[0] : gmr[3][3];
							gmr[3][4] <= hidden_sqs_mask[1] ? anded_masks_sq[1] : gmr[3][4];
							gmr[3][5] <= hidden_sqs_mask[2] ? anded_masks_sq[2] : gmr[3][5];
							gmr[4][3] <= hidden_sqs_mask[3] ? anded_masks_sq[3] : gmr[4][3];
							gmr[4][4] <= hidden_sqs_mask[4] ? anded_masks_sq[4] : gmr[4][4];
							gmr[4][5] <= hidden_sqs_mask[5] ? anded_masks_sq[5] : gmr[4][5];
							gmr[5][3] <= hidden_sqs_mask[6] ? anded_masks_sq[6] : gmr[5][3];
							gmr[5][4] <= hidden_sqs_mask[7] ? anded_masks_sq[7] : gmr[5][4];
							gmr[5][5] <= hidden_sqs_mask[8] ? anded_masks_sq[8] : gmr[5][5];
						end
					5:
						begin
							gmr[3][6] <= hidden_sqs_mask[0] ? anded_masks_sq[0] : gmr[3][6];
							gmr[3][7] <= hidden_sqs_mask[1] ? anded_masks_sq[1] : gmr[3][7];
							gmr[3][8] <= hidden_sqs_mask[2] ? anded_masks_sq[2] : gmr[3][8];
							gmr[4][6] <= hidden_sqs_mask[3] ? anded_masks_sq[3] : gmr[4][6];
							gmr[4][7] <= hidden_sqs_mask[4] ? anded_masks_sq[4] : gmr[4][7];
							gmr[4][8] <= hidden_sqs_mask[5] ? anded_masks_sq[5] : gmr[4][8];
							gmr[5][6] <= hidden_sqs_mask[6] ? anded_masks_sq[6] : gmr[5][6];
							gmr[5][7] <= hidden_sqs_mask[7] ? anded_masks_sq[7] : gmr[5][7];
							gmr[5][8] <= hidden_sqs_mask[8] ? anded_masks_sq[8] : gmr[5][8];
						end
					6:
						begin
							gmr[6][0] <= hidden_sqs_mask[0] ? anded_masks_sq[0] : gmr[6][0];
							gmr[6][1] <= hidden_sqs_mask[1] ? anded_masks_sq[1] : gmr[6][1];
							gmr[6][2] <= hidden_sqs_mask[2] ? anded_masks_sq[2] : gmr[6][2];
							gmr[7][0] <= hidden_sqs_mask[3] ? anded_masks_sq[3] : gmr[7][0];
							gmr[7][1] <= hidden_sqs_mask[4] ? anded_masks_sq[4] : gmr[7][1];
							gmr[7][2] <= hidden_sqs_mask[5] ? anded_masks_sq[5] : gmr[7][2];
							gmr[8][0] <= hidden_sqs_mask[6] ? anded_masks_sq[6] : gmr[8][0];
							gmr[8][1] <= hidden_sqs_mask[7] ? anded_masks_sq[7] : gmr[8][1];
							gmr[8][2] <= hidden_sqs_mask[8] ? anded_masks_sq[8] : gmr[8][2];
						end
					7:
						begin
							gmr[6][3] <= hidden_sqs_mask[0] ? anded_masks_sq[0] : gmr[6][3];
							gmr[6][4] <= hidden_sqs_mask[1] ? anded_masks_sq[1] : gmr[6][4];
							gmr[6][5] <= hidden_sqs_mask[2] ? anded_masks_sq[2] : gmr[6][5];
							gmr[7][3] <= hidden_sqs_mask[3] ? anded_masks_sq[3] : gmr[7][3];
							gmr[7][4] <= hidden_sqs_mask[4] ? anded_masks_sq[4] : gmr[7][4];
							gmr[7][5] <= hidden_sqs_mask[5] ? anded_masks_sq[5] : gmr[7][5];
							gmr[8][3] <= hidden_sqs_mask[6] ? anded_masks_sq[6] : gmr[8][3];
							gmr[8][4] <= hidden_sqs_mask[7] ? anded_masks_sq[7] : gmr[8][4];
							gmr[8][5] <= hidden_sqs_mask[8] ? anded_masks_sq[8] : gmr[8][5];
						end
					8:
						begin
							gmr[6][6] <= hidden_sqs_mask[0] ? anded_masks_sq[0] : gmr[6][6];
							gmr[6][7] <= hidden_sqs_mask[1] ? anded_masks_sq[1] : gmr[6][7];
							gmr[6][8] <= hidden_sqs_mask[2] ? anded_masks_sq[2] : gmr[6][8];
							gmr[7][6] <= hidden_sqs_mask[3] ? anded_masks_sq[3] : gmr[7][6];
							gmr[7][7] <= hidden_sqs_mask[4] ? anded_masks_sq[4] : gmr[7][7];
							gmr[7][8] <= hidden_sqs_mask[5] ? anded_masks_sq[5] : gmr[7][8];
							gmr[8][6] <= hidden_sqs_mask[6] ? anded_masks_sq[6] : gmr[8][6];
							gmr[8][7] <= hidden_sqs_mask[7] ? anded_masks_sq[7] : gmr[8][7];
							gmr[8][8] <= hidden_sqs_mask[8] ? anded_masks_sq[8] : gmr[8][8];
						end
					default: ;
				endcase
			end
			if (naked_group_detected_row)
			begin
				`ASSIGN_ARR_9_CONST(gmr[row_counter], ~pvr[row_counter][col_counter], ~naked_rows_mask);
			end
			if (naked_group_detected_col)
			begin
				`ASSIGN_ARR_TO_DIM_2_9_CONST(gmr, ~pvr[row_counter][col_counter], col_counter, ~naked_cols_mask);
			end
			if (naked_group_detected_sq)
			begin
				case(sq_number)
					0:
						begin
							gmr[0][0] <= ~naked_sqs_mask[0] ? ~pvr[row_counter][col_counter] : gmr[0][0];
							gmr[0][1] <= ~naked_sqs_mask[1] ? ~pvr[row_counter][col_counter] : gmr[0][1];
							gmr[0][2] <= ~naked_sqs_mask[2] ? ~pvr[row_counter][col_counter] : gmr[0][2];
							gmr[1][0] <= ~naked_sqs_mask[3] ? ~pvr[row_counter][col_counter] : gmr[1][0];
							gmr[1][1] <= ~naked_sqs_mask[4] ? ~pvr[row_counter][col_counter] : gmr[1][1];
							gmr[1][2] <= ~naked_sqs_mask[5] ? ~pvr[row_counter][col_counter] : gmr[1][2];
							gmr[2][0] <= ~naked_sqs_mask[6] ? ~pvr[row_counter][col_counter] : gmr[2][0];
							gmr[2][1] <= ~naked_sqs_mask[7] ? ~pvr[row_counter][col_counter] : gmr[2][1];
							gmr[2][2] <= ~naked_sqs_mask[8] ? ~pvr[row_counter][col_counter] : gmr[2][2];
						end
					1:
						begin
							gmr[0][3] <= ~naked_sqs_mask[0] ? ~pvr[row_counter][col_counter] : gmr[0][3];
							gmr[0][4] <= ~naked_sqs_mask[1] ? ~pvr[row_counter][col_counter] : gmr[0][4];
							gmr[0][5] <= ~naked_sqs_mask[2] ? ~pvr[row_counter][col_counter] : gmr[0][5];
							gmr[1][3] <= ~naked_sqs_mask[3] ? ~pvr[row_counter][col_counter] : gmr[1][3];
							gmr[1][4] <= ~naked_sqs_mask[4] ? ~pvr[row_counter][col_counter] : gmr[1][4];
							gmr[1][5] <= ~naked_sqs_mask[5] ? ~pvr[row_counter][col_counter] : gmr[1][5];
							gmr[2][3] <= ~naked_sqs_mask[6] ? ~pvr[row_counter][col_counter] : gmr[2][3];
							gmr[2][4] <= ~naked_sqs_mask[7] ? ~pvr[row_counter][col_counter] : gmr[2][4];
							gmr[2][5] <= ~naked_sqs_mask[8] ? ~pvr[row_counter][col_counter] : gmr[2][5];
						end
					2:
						begin
							gmr[0][6] <= ~naked_sqs_mask[0] ? ~pvr[row_counter][col_counter] : gmr[0][6];
							gmr[0][7] <= ~naked_sqs_mask[1] ? ~pvr[row_counter][col_counter] : gmr[0][7];
							gmr[0][8] <= ~naked_sqs_mask[2] ? ~pvr[row_counter][col_counter] : gmr[0][8];
							gmr[1][6] <= ~naked_sqs_mask[3] ? ~pvr[row_counter][col_counter] : gmr[1][6];
							gmr[1][7] <= ~naked_sqs_mask[4] ? ~pvr[row_counter][col_counter] : gmr[1][7];
							gmr[1][8] <= ~naked_sqs_mask[5] ? ~pvr[row_counter][col_counter] : gmr[1][8];
							gmr[2][6] <= ~naked_sqs_mask[6] ? ~pvr[row_counter][col_counter] : gmr[2][6];
							gmr[2][7] <= ~naked_sqs_mask[7] ? ~pvr[row_counter][col_counter] : gmr[2][7];
							gmr[2][8] <= ~naked_sqs_mask[8] ? ~pvr[row_counter][col_counter] : gmr[2][8];
						end
					3:
						begin
							gmr[3][0] <= ~naked_sqs_mask[0] ? ~pvr[row_counter][col_counter] : gmr[3][0];
							gmr[3][1] <= ~naked_sqs_mask[1] ? ~pvr[row_counter][col_counter] : gmr[3][1];
							gmr[3][2] <= ~naked_sqs_mask[2] ? ~pvr[row_counter][col_counter] : gmr[3][2];
							gmr[4][0] <= ~naked_sqs_mask[3] ? ~pvr[row_counter][col_counter] : gmr[4][0];
							gmr[4][1] <= ~naked_sqs_mask[4] ? ~pvr[row_counter][col_counter] : gmr[4][1];
							gmr[4][2] <= ~naked_sqs_mask[5] ? ~pvr[row_counter][col_counter] : gmr[4][2];
							gmr[5][0] <= ~naked_sqs_mask[6] ? ~pvr[row_counter][col_counter] : gmr[5][0];
							gmr[5][1] <= ~naked_sqs_mask[7] ? ~pvr[row_counter][col_counter] : gmr[5][1];
							gmr[5][2] <= ~naked_sqs_mask[8] ? ~pvr[row_counter][col_counter] : gmr[5][2];
						end
					4:
						begin
							gmr[3][3] <= ~naked_sqs_mask[0] ? ~pvr[row_counter][col_counter] : gmr[3][3];
							gmr[3][4] <= ~naked_sqs_mask[1] ? ~pvr[row_counter][col_counter] : gmr[3][4];
							gmr[3][5] <= ~naked_sqs_mask[2] ? ~pvr[row_counter][col_counter] : gmr[3][5];
							gmr[4][3] <= ~naked_sqs_mask[3] ? ~pvr[row_counter][col_counter] : gmr[4][3];
							gmr[4][4] <= ~naked_sqs_mask[4] ? ~pvr[row_counter][col_counter] : gmr[4][4];
							gmr[4][5] <= ~naked_sqs_mask[5] ? ~pvr[row_counter][col_counter] : gmr[4][5];
							gmr[5][3] <= ~naked_sqs_mask[6] ? ~pvr[row_counter][col_counter] : gmr[5][3];
							gmr[5][4] <= ~naked_sqs_mask[7] ? ~pvr[row_counter][col_counter] : gmr[5][4];
							gmr[5][5] <= ~naked_sqs_mask[8] ? ~pvr[row_counter][col_counter] : gmr[5][5];
						end
					5:
						begin
							gmr[3][6] <= ~naked_sqs_mask[0] ? ~pvr[row_counter][col_counter] : gmr[3][6];
							gmr[3][7] <= ~naked_sqs_mask[1] ? ~pvr[row_counter][col_counter] : gmr[3][7];
							gmr[3][8] <= ~naked_sqs_mask[2] ? ~pvr[row_counter][col_counter] : gmr[3][8];
							gmr[4][6] <= ~naked_sqs_mask[3] ? ~pvr[row_counter][col_counter] : gmr[4][6];
							gmr[4][7] <= ~naked_sqs_mask[4] ? ~pvr[row_counter][col_counter] : gmr[4][7];
							gmr[4][8] <= ~naked_sqs_mask[5] ? ~pvr[row_counter][col_counter] : gmr[4][8];
							gmr[5][6] <= ~naked_sqs_mask[6] ? ~pvr[row_counter][col_counter] : gmr[5][6];
							gmr[5][7] <= ~naked_sqs_mask[7] ? ~pvr[row_counter][col_counter] : gmr[5][7];
							gmr[5][8] <= ~naked_sqs_mask[8] ? ~pvr[row_counter][col_counter] : gmr[5][8];
						end
					6:
						begin
							gmr[6][0] <= ~naked_sqs_mask[0] ? ~pvr[row_counter][col_counter] : gmr[6][0];
							gmr[6][1] <= ~naked_sqs_mask[1] ? ~pvr[row_counter][col_counter] : gmr[6][1];
							gmr[6][2] <= ~naked_sqs_mask[2] ? ~pvr[row_counter][col_counter] : gmr[6][2];
							gmr[7][0] <= ~naked_sqs_mask[3] ? ~pvr[row_counter][col_counter] : gmr[7][0];
							gmr[7][1] <= ~naked_sqs_mask[4] ? ~pvr[row_counter][col_counter] : gmr[7][1];
							gmr[7][2] <= ~naked_sqs_mask[5] ? ~pvr[row_counter][col_counter] : gmr[7][2];
							gmr[8][0] <= ~naked_sqs_mask[6] ? ~pvr[row_counter][col_counter] : gmr[8][0];
							gmr[8][1] <= ~naked_sqs_mask[7] ? ~pvr[row_counter][col_counter] : gmr[8][1];
							gmr[8][2] <= ~naked_sqs_mask[8] ? ~pvr[row_counter][col_counter] : gmr[8][2];
						end
					7:
						begin
							gmr[6][3] <= ~naked_sqs_mask[0] ? ~pvr[row_counter][col_counter] : gmr[6][3];
							gmr[6][4] <= ~naked_sqs_mask[1] ? ~pvr[row_counter][col_counter] : gmr[6][4];
							gmr[6][5] <= ~naked_sqs_mask[2] ? ~pvr[row_counter][col_counter] : gmr[6][5];
							gmr[7][3] <= ~naked_sqs_mask[3] ? ~pvr[row_counter][col_counter] : gmr[7][3];
							gmr[7][4] <= ~naked_sqs_mask[4] ? ~pvr[row_counter][col_counter] : gmr[7][4];
							gmr[7][5] <= ~naked_sqs_mask[5] ? ~pvr[row_counter][col_counter] : gmr[7][5];
							gmr[8][3] <= ~naked_sqs_mask[6] ? ~pvr[row_counter][col_counter] : gmr[8][3];
							gmr[8][4] <= ~naked_sqs_mask[7] ? ~pvr[row_counter][col_counter] : gmr[8][4];
							gmr[8][5] <= ~naked_sqs_mask[8] ? ~pvr[row_counter][col_counter] : gmr[8][5];
						end
					8:
						begin
							gmr[6][6] <= ~naked_sqs_mask[0] ? ~pvr[row_counter][col_counter] : gmr[6][6];
							gmr[6][7] <= ~naked_sqs_mask[1] ? ~pvr[row_counter][col_counter] : gmr[6][7];
							gmr[6][8] <= ~naked_sqs_mask[2] ? ~pvr[row_counter][col_counter] : gmr[6][8];
							gmr[7][6] <= ~naked_sqs_mask[3] ? ~pvr[row_counter][col_counter] : gmr[7][6];
							gmr[7][7] <= ~naked_sqs_mask[4] ? ~pvr[row_counter][col_counter] : gmr[7][7];
							gmr[7][8] <= ~naked_sqs_mask[5] ? ~pvr[row_counter][col_counter] : gmr[7][8];
							gmr[8][6] <= ~naked_sqs_mask[6] ? ~pvr[row_counter][col_counter] : gmr[8][6];
							gmr[8][7] <= ~naked_sqs_mask[7] ? ~pvr[row_counter][col_counter] : gmr[8][7];
							gmr[8][8] <= ~naked_sqs_mask[8] ? ~pvr[row_counter][col_counter] : gmr[8][8];
						end
					default: ;
				endcase
			end
		end
	end

	// Candidate line alg
	reg [3:0] square_counter;
	always @(posedge clk_in)
	begin
		if (reset_in)
		begin
			square_counter <= 0;
			`RESET_3_BY_9(candidate_line_rows_reg);
			`RESET_3_BY_9(candidate_line_cols_reg);
		end
		else if (|error_detected)
		begin
			`RESET_3_BY_9(candidate_line_rows_reg);
			`RESET_3_BY_9(candidate_line_cols_reg);
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

	// the lowest number of ones in the grid
	reg 	[3:0]						min_ones_reg;
	always @(posedge clk_in)
	begin
		if (reset_in)
		begin
			min_ones_reg <= 4'd10;
			guess_number <= 16'b0;
			`RESET_PREVS(guess_col, 10);
			`RESET_PREVS(guess_row, 10);
			`RESET_PREVS(guesses, 0);
		end
		else
		begin
			if ((|error_detected) & (|guess_number))
			begin //error at guess_number-1
				min_ones_reg <= 4'd10;
				guess_number <= guess_number - 1;
				guesses[guess_number-1]   <= `GET_LSB(pvr_prevs[guess_row[guess_number-1]][guess_col[guess_number-1]][guess_number-1]);
			end
			else if (timeout)
			begin
				// if ((guess_row[guess_number] == 10) & ~(done_out))
				// begin
				// 	$display("INVALID GUESS");
				// 	$finish;
				// end
				min_ones_reg <= 4'd10;
				guess_number <= guess_number + 1;
			end
			if ( ( (number_of_ones_in_mask < min_ones_reg) && (number_of_ones_in_mask > 1) )
				|| ((~valid_one_hot(pvr[row_counter][col_counter]))
				 	&& valid_one_hot(pvr[guess_row[guess_number]][guess_col[guess_number]]) ) )
			begin
				min_ones_reg			<= number_of_ones_in_mask;
				guesses[guess_number]   <= `GET_LSB(pvr[row_counter][col_counter]);
				guess_col[guess_number] <= col_counter;
				guess_row[guess_number] <= row_counter;
			end
		end
	end
endmodule
