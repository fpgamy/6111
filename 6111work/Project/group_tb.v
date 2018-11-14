module group_tb;
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
	// Number = 1 implies contains value

	reg  [(GRID_SIZE)*(GRID_SIZE)*(GRID_SIZE)-1:0] test_input;

	group_test_module ss1   (
							.clk_in    (clk)       ,
							.reset_in  (reset)     ,
							.pvr_in  (test_input)
						);
	initial
	begin
	    $dumpfile("test.vcd");
		$dumpvars(0,group_tb);
		clk         = 0;
		reset       = 1;
		test_input  =  {9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0,
					    9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0,
					    9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0,
					    9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0,
					    9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0,
					    9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0,
					    9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0,
					    9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0,
					    9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0};
		#10;
		reset       = 0;
		#10;
		$display("HIDDEN TEST 1: -------------");
		
		test_input  =  {9'b0, 9'b0, 9'b0, 9'b0, 9'b0, 9'b0, 9'b0, 9'b0, 9'b0,
					    9'b0, 9'b0, 9'b0, 9'b0, 9'b0, 9'b0, 9'b0, 9'b0, 9'b0,
					    9'b0, 9'b0, 9'b0, 9'b0, 9'b0, 9'b0, 9'b0, 9'b0, 9'b0,
					    9'b0, 9'b0, 9'b0, 9'b0, 9'b0, 9'b0, 9'b0, 9'b0, 9'b0,
					    9'b0, 9'b0, 9'b0, 9'b0, 9'b0, 9'b0, 9'b0, 9'b0, 9'b0,
					    9'b0, 9'b0, 9'b0, 9'b0, 9'b0, 9'b0, 9'b0, 9'b0, 9'b0,
					    9'b0, 9'b0, 9'b0, 9'b0, 9'b0, 9'b0, 9'b0, 9'b0, 9'b0,
					    9'b0, 9'b0, 9'b0, 9'b0, 9'b0, 9'b0, 9'b0, 9'b0, 9'b0,
					    9'b000000111, 9'b000100010, 9'b000010000, 9'b000000101, 9'b010000000, 9'b000001010, 9'b000101000, 9'b001000000, 9'b100000000};
		test_solver;
		$display("HIDDEN TEST 2: -------------");

		test_input  =  {9'b000000111, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0,
					    9'b000100010, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0,
					    9'b000010000, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0,
					    9'b000000101, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0,
					    9'b010000000, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0,
					    9'b000001010, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0,
					    9'b000101000, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0,
					    9'b001000000, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0,
					    9'b100000000, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0};
		test_solver;

		$display("HIDDEN TEST 3: -------------");
		test_input  =  {9'b000000111, 9'b000100010, 9'b000010000, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0,
					    9'b000000101, 9'b010000000, 9'b000001010, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0,
					    9'b000101000, 9'b001000000, 9'b100000000, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0,
					    9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0,
					    9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0,
					    9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0,
					    9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0,
					    9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0,
					    9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0, 9'd0};
		test_solver;

		$display("NAKED TEST 1: -------------");
		
		test_input  =  {9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111,
					    9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111,
					    9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111,
					    9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111,
					    9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111,
					    9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111,
					    9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111,
					    9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111,
					    9'b000000111, 9'b000000111, 9'b001000101, 9'b000000111, 9'b010000111, 9'b000001111, 9'b000101111, 9'b001010111, 9'b100000111};
		test_solver;
		$display("NAKED TEST 2: -------------");

		test_input  =  {9'b000000111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111,
					    9'b000000111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111,
					    9'b001000101, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111,
					    9'b000000111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111,
					    9'b010000111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111,
					    9'b000001111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111,
					    9'b000101111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111,
					    9'b001010111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111,
					    9'b100000111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111};
		test_solver;

		$display("NAKED TEST 3: -------------");
		test_input  =  {9'b000000111, 9'b000000111, 9'b001000101, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111,
					    9'b000000111, 9'b010000111, 9'b000001111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111,
					    9'b000101111, 9'b001010111, 9'b100000111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111,
					    9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111,
					    9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111,
					    9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111,
					    9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111,
					    9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111,
					    9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111, 9'b111111111};
		test_solver;

		#50;
		$finish;
	end

	always #5 
	begin
		clk = ~clk;
`ifdef VERBOSE
		if (clk)
		begin
			printstatus;
		end
`endif

	end

	always @(posedge ss1.naked_group_detected)
	begin
		if (ss1.naked_group_detected_row | ss1.naked_group_detected_col | ss1.naked_group_detected_sq)
		begin
			$display("NAKED GROUP DETECTED");
			$display("ROW COUNTER:    %d", ss1.row_counter);
			$display("COLUMN COUNTER: %d", ss1.col_counter);
			$display("pvr: %b", ss1.pvr[ss1.row_counter][ss1.col_counter]);
			printstatus;
		end
	end

	always @(posedge ss1.hidden_group_detected)
	begin
		if (ss1.hidden_group_detected_row | ss1.hidden_group_detected_col | ss1.hidden_group_detected_sq)
		begin
			$display("HIDDEN GROUP DETECTED");
			$display("ROW COUNTER:    %d", ss1.row_counter);
			$display("COLUMN COUNTER: %d", ss1.col_counter);
			$display("pvr: %b", ss1.pvr[ss1.row_counter][ss1.col_counter]);
			printstatus;
		end
	end

	task test_solver;
	begin
		reset       = 1;
		#20;
		reset       = 0;

		#1000;

		printstatus;
		#10;
	end
	endtask

	task printstatus;
	begin
		$display("");

		$display("Input: ");
		`PRINTGRIDONEHOT(ss1.pvr);

		$display("And ROWS: ");		
		`PRINTVECBIN(ss1.anded_masks_row);
		$display("And COLS: ");
		`PRINTVECBIN(ss1.anded_masks_col);
		$display("And SQS: ");
		`PRINTVECBIN(ss1.anded_masks_sq);

`ifdef VERBOSE
		$display("ROW COUNTER:    %d", ss1.row_counter);
		$display("COLUMN COUNTER: %d", ss1.col_counter);
		$display("pvr: %b", ss1.pvr[ss1.row_counter][ss1.col_counter]);
`endif

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

		$display("Naked Group in Row");
		$display("%b", ss1.naked_group_detected_row);
		$display("Naked Group in Col");
		$display("%b", ss1.naked_group_detected_col);
		$display("Naked Group in Square");
		$display("%b", ss1.naked_group_detected_sq);
		$display("number_of_ones_in_mask");
		$display("%d", ss1.number_of_ones_in_mask);
		$display("Naked Rows Mask");
		$display("MASK 1: ");
		$display("%b", ss1.naked_rows_mask_1);
		$display("MASK 2: ");
		$display("%b", ss1.naked_rows_mask_2);
		$display("SUM 1: ");
		`PRINTVEC(ss1.naked_rows_sum_1);
		$display("SUM 2: ");
		`PRINTVEC(ss1.naked_rows_sum_2);
		$display("FINAL MASK: ");
		$display("%b", ss1.naked_rows_mask);
		$display("Naked Cols Mask");
		$display("MASK 1: ");
		$display("%b", ss1.naked_cols_mask_1);
		$display("MASK 2: ");
		$display("%b", ss1.naked_cols_mask_2);		
		$display("SUM 1: ");
		`PRINTVEC(ss1.naked_cols_sum_1);
		$display("SUM 2: ");
		`PRINTVEC(ss1.naked_cols_sum_2);
		$display("FINAL MASK: ");
		$display("%b", ss1.naked_cols_mask);
		$display("Naked Sqs Mask");
		$display("MASK 1: ");
		$display("%b", ss1.naked_sqs_mask_1);
		$display("MASK 2: ");
		$display("%b", ss1.naked_sqs_mask_2);
		$display("SUM 1: ");
		`PRINTVEC(ss1.naked_sqs_sum_1);
		$display("SUM 2: ");
		`PRINTVEC(ss1.naked_sqs_sum_2);
		$display("FINAL MASK: ");
		$display("%b", ss1.naked_sqs_mask);


		$display("Hidden Group Grid: ");
		`PRINTGRIDONEHOT(ss1.gmr);

	end
	endtask
endmodule