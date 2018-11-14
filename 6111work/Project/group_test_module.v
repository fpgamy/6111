module group_test_module(
							clk_in,
							reset_in,
							pvr_in
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
	input  [(GRID_SIZE)*(GRID_SIZE)*(GRID_SIZE)-1:0] pvr_in;

	wire  [(GRID_SIZE-1):0] pvr [0:(GRID_SIZE-1)] [0:(GRID_SIZE-1)];

	// Masks of the pvr due to the gidden and naked groups
	reg    [(GRID_SIZE-1):0] gmr [0:(GRID_SIZE-1)] [0:(GRID_SIZE-1)];
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
				assign pvr[row_genvar][col_genvar]        = pvr_in[(row_genvar*GRID_SIZE*GRID_SIZE)+(col_genvar*GRID_SIZE)+GRID_SIZE-1:
																		  (row_genvar*GRID_SIZE*GRID_SIZE)+(col_genvar*GRID_SIZE)];
			end
		end
	endgenerate

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

	always @(posedge clk_in or posedge reset_in)
	begin
		if (reset_in)
		begin
			`RESET_GRID(gmr, 9'b111_111_111);
			row_counter <= 0;
			col_counter <= 0;
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
endmodule
