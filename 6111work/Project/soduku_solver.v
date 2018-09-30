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

	// !!DISGUSTING-CODE WARNING!!
	// GET YOUR SICK BAG READY.

	assign unsolved[0][0] = board_in[3:0];
	assign unsolved[0][1] = board_in[7:4];
	assign unsolved[0][2] = board_in[11:8];
	assign unsolved[0][3] = board_in[15:12];
	assign unsolved[0][4] = board_in[19:16];
	assign unsolved[0][5] = board_in[23:20];
	assign unsolved[0][6] = board_in[27:24];
	assign unsolved[0][7] = board_in[31:28];
	assign unsolved[0][8] = board_in[35:32];
	assign unsolved[1][0] = board_in[39:36];
	assign unsolved[1][1] = board_in[43:40];
	assign unsolved[1][2] = board_in[47:44];
	assign unsolved[1][3] = board_in[51:48];
	assign unsolved[1][4] = board_in[55:52];
	assign unsolved[1][5] = board_in[59:56];
	assign unsolved[1][6] = board_in[63:60];
	assign unsolved[1][7] = board_in[67:64];
	assign unsolved[1][8] = board_in[71:68];
	assign unsolved[2][0] = board_in[75:72];
	assign unsolved[2][1] = board_in[79:76];
	assign unsolved[2][2] = board_in[83:80];
	assign unsolved[2][3] = board_in[87:84];
	assign unsolved[2][4] = board_in[91:88];
	assign unsolved[2][5] = board_in[95:92];
	assign unsolved[2][6] = board_in[99:96];
	assign unsolved[2][7] = board_in[103:100];
	assign unsolved[2][8] = board_in[107:104];
	assign unsolved[3][0] = board_in[111:108];
	assign unsolved[3][1] = board_in[115:112];
	assign unsolved[3][2] = board_in[119:116];
	assign unsolved[3][3] = board_in[123:120];
	assign unsolved[3][4] = board_in[127:124];
	assign unsolved[3][5] = board_in[131:128];
	assign unsolved[3][6] = board_in[135:132];
	assign unsolved[3][7] = board_in[139:136];
	assign unsolved[3][8] = board_in[143:140];
	assign unsolved[4][0] = board_in[147:144];
	assign unsolved[4][1] = board_in[151:148];
	assign unsolved[4][2] = board_in[155:152];
	assign unsolved[4][3] = board_in[159:156];
	assign unsolved[4][4] = board_in[163:160];
	assign unsolved[4][5] = board_in[167:164];
	assign unsolved[4][6] = board_in[171:168];
	assign unsolved[4][7] = board_in[175:172];
	assign unsolved[4][8] = board_in[179:176];
	assign unsolved[5][0] = board_in[183:180];
	assign unsolved[5][1] = board_in[187:184];
	assign unsolved[5][2] = board_in[191:188];
	assign unsolved[5][3] = board_in[195:192];
	assign unsolved[5][4] = board_in[199:196];
	assign unsolved[5][5] = board_in[203:200];
	assign unsolved[5][6] = board_in[207:204];
	assign unsolved[5][7] = board_in[211:208];
	assign unsolved[5][8] = board_in[215:212];
	assign unsolved[6][0] = board_in[219:216];
	assign unsolved[6][1] = board_in[223:220];
	assign unsolved[6][2] = board_in[227:224];
	assign unsolved[6][3] = board_in[231:228];
	assign unsolved[6][4] = board_in[235:232];
	assign unsolved[6][5] = board_in[239:236];
	assign unsolved[6][6] = board_in[243:240];
	assign unsolved[6][7] = board_in[247:244];
	assign unsolved[6][8] = board_in[251:248];
	assign unsolved[7][0] = board_in[255:252];
	assign unsolved[7][1] = board_in[259:256];
	assign unsolved[7][2] = board_in[263:260];
	assign unsolved[7][3] = board_in[267:264];
	assign unsolved[7][4] = board_in[271:268];
	assign unsolved[7][5] = board_in[275:272];
	assign unsolved[7][6] = board_in[279:276];
	assign unsolved[7][7] = board_in[283:280];
	assign unsolved[7][8] = board_in[287:284];
	assign unsolved[8][0] = board_in[291:288];
	assign unsolved[8][1] = board_in[295:292];
	assign unsolved[8][2] = board_in[299:296];
	assign unsolved[8][3] = board_in[303:300];
	assign unsolved[8][4] = board_in[307:304];
	assign unsolved[8][5] = board_in[311:308];
	assign unsolved[8][6] = board_in[315:312];
	assign unsolved[8][7] = board_in[319:316];
	assign unsolved[8][8] = board_in[323:320];

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

//
// INCLUDES
//

	`include "soduku_functions.v"
//
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

	// Contains zeros where the rows are solved
	wire    [(GRID_SIZE-1):0] rows_solved;
	// Determines if we need to start backtracking
	reg     [(GRID_SIZE-1):0] rows_solved_prev;
	// Contains zeros where the columns are solved
	wire    [(GRID_SIZE-1):0] cols_solved;
	// Determines if we need to start backtracking
	reg     [(GRID_SIZE-1):0] cols_solved_prev;
	// Contains zeros where the squares are solved
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
// GENERATORS
//
	generate
		genvar row_genvar;
		genvar col_genvar;
		for (row_genvar = 0; row_genvar < (GRID_SIZE); row_genvar = row_genvar + 1)
		begin
			for (col_genvar = 0; col_genvar < (GRID_SIZE); col_genvar = col_genvar + 1)
			begin
				always @(posedge clk_in)
				begin
					one_hot_board_reg[row_genvar][col_genvar] <= one_hot(unsolved[row_genvar][col_genvar]);
				end
				assign solved[row_genvar][col_genvar]         = bcd(one_hot_board_reg[row_genvar][col_genvar]);
			end
		end
	endgenerate

	generate
		genvar solved_genvar;
		for (solved_genvar = 0; solved_genvar < (GRID_SIZE); solved_genvar = solved_genvar + 1)
		begin
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
			assign rows_solved[solved_genvar] = &rows_missing[solved_genvar];
			assign cols_solved[solved_genvar] = &cols_missing[solved_genvar];
		end
	endgenerate

	generate
		genvar row_square_genvar;
		genvar col_square_genvar;
		for (row_square_genvar = 0; row_square_genvar < 3; row_square_genvar = row_square_genvar + 1)
		begin
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
				assign squares_solved[(row_square_genvar * 3) + col_square_genvar] = &squares_missing[(row_square_genvar * 3) + col_square_genvar];
			end
		end
	endgenerate
endmodule
