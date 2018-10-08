module soduku_solver(
						clk_in         ,
						reset_in       ,
						board_in       ,
						board_out      ,
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
	// 2D array of 4 bit BCD values
	// Contains all the numbers in unsolved board
	// Number = 0 implies missing value
	wire  [3:0] unsolved [0:(GRID_SIZE-1)] [0:(GRID_SIZE-1)];

	// 2D array of 4 bit BCD values
	// Contains all the numbers in solved board
	wire [3:0] solved [0:(GRID_SIZE-1)] [0:(GRID_SIZE-1)];

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
	reg    [(GRID_SIZE-1):0] one_hot_board_reg [0:(GRID_SIZE-1)] [0:(GRID_SIZE-1)];


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

	// Contains zeros where the numbers are missing
	wire    [(GRID_SIZE-1):0] rows_missing         [0:(GRID_SIZE-1)];
	// Determines if we need made a mistake (check for equality)
	reg     [(GRID_SIZE-1):0] rows_missing_prev    [0:(GRID_SIZE-1)];
	
	wire    [(GRID_SIZE-1):0] cols_missing         [0:(GRID_SIZE-1)];
	// Determines if we need made a mistake (check for equality)
	reg     [(GRID_SIZE-1):0] cols_missing_prev    [0:(GRID_SIZE-1)];

	wire    [(GRID_SIZE-1):0] squares_missing      [0:(GRID_SIZE-1)];
	// Determines if we need made a mistake (check for equality)
	reg     [(GRID_SIZE-1):0] squares_missing_prev [0:(GRID_SIZE-1)];

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
				wire    [(GRID_SIZE-1):0] squares_missing_single;
				if (row_genvar >= 6)
				begin
					if (col_genvar >= 6)
					begin
						assign squares_missing_single = squares_missing[8];
					end
					else if (col_genvar >= 3)
					begin
						assign squares_missing_single = squares_missing[7];						
					end
					else 
					begin
						assign squares_missing_single = squares_missing[6];						
					end
				end
				else if (row_genvar >= 3)
				begin
					if (col_genvar >= 6)
					begin
						assign squares_missing_single = squares_missing[5];							
					end
					else if (col_genvar >= 3)
					begin
						assign squares_missing_single = squares_missing[4];						
					end
					else 
					begin
						assign squares_missing_single = squares_missing[3];						
					end					
				end
				else 
				begin
					if (col_genvar >= 6)
					begin
						assign squares_missing_single = squares_missing[2];							
					end
					else if (col_genvar >= 3)
					begin
						assign squares_missing_single = squares_missing[1];	
					end
					else 
					begin
						assign squares_missing_single = squares_missing[0];	
					end					
				end

				always @(posedge clk_in or posedge reset_in)
				begin
					if (reset_in)
					begin
						one_hot_board_reg[row_genvar][col_genvar] <= one_hot(unsolved[row_genvar][col_genvar]);
					end
					else if (one_hot_board_reg[row_genvar][col_genvar] == 0) 
					begin
						/*
						Need to change the singleton solve function to a check possibilitiesl:
						Take as input the column, row and square that is being worked on
						Generate 10 masks:
							- mask of values containing 1s for values in the row
							- mask of values containing 1s for values in the column
							- mask of values containing 1s for values in the square
							=> OR these masks. The 0 positions are the only values which the singleton can take.
							
							- mask of values containing 1s for values which can be present in other unsolved singletons in the column
							- mask of values containing 1s for values which can be present in other unsolved singletons in the row
							- mask of values containing 1s for values which can be present in other unsolved singletons in the square
							=> OR these masks. The 0 positions are the values which only this singleton can take.

							- mask of values containing 1s of the exclusive possible values from the row of the adjacent square
							- mask of values containing 1s of the exclusive possible values from the row of the next adjacent square
							- mask of values containing 1s of the exclusive possible values from the column of the adjacent square
							- mask of values containing 1s of the exclusive possible values from the column of the next adjacent square
							=> OR these masks. The 0 positions are the values which this singleton can take
						store the mask in some register somewhere
						check if it is one-cold
						*/
						one_hot_board_reg[row_genvar][col_genvar] <= singleton_solve(
																						rows_missing   [row_genvar],
																						cols_missing   [col_genvar],
																						squares_missing_single
																					);
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
		begin: missing_generator
			assign rows_missing[solved_genvar] = (
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
			assign cols_missing[solved_genvar] = (
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
			assign rows_solved[solved_genvar] = &(rows_missing[solved_genvar]);
			assign cols_solved[solved_genvar] = &(cols_missing[solved_genvar]);
		end
	endgenerate

	generate
		genvar row_square_genvar;
		genvar col_square_genvar;
		for (row_square_genvar = 0; row_square_genvar < 3; row_square_genvar = row_square_genvar + 1)
		begin: squares_generator
			for (col_square_genvar = 0; col_square_genvar < 3; col_square_genvar = col_square_genvar + 1)
			begin
				assign squares_missing[(row_square_genvar * 3) + col_square_genvar] = (
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
				assign squares_solved[(row_square_genvar * 3) + col_square_genvar] = &(squares_missing[(row_square_genvar * 3) + col_square_genvar]);
			end
		end
	endgenerate
endmodule
