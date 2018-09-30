`define assert(signal, value) \
        if (signal !== value) \
        begin \
            $display("ASSERTION FAILED in %m at time %0t: signal != value", $time); \
        end

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
	
	assign solved[8][8] = test_output[3:0];
	assign solved[8][7] = test_output[7:4];
	assign solved[8][6] = test_output[11:8];
	assign solved[8][5] = test_output[15:12];
	assign solved[8][4] = test_output[19:16];
	assign solved[8][3] = test_output[23:20];
	assign solved[8][2] = test_output[27:24];
	assign solved[8][1] = test_output[31:28];
	assign solved[8][0] = test_output[35:32];
	assign solved[7][8] = test_output[39:36];
	assign solved[7][7] = test_output[43:40];
	assign solved[7][6] = test_output[47:44];
	assign solved[7][5] = test_output[51:48];
	assign solved[7][4] = test_output[55:52];
	assign solved[7][3] = test_output[59:56];
	assign solved[7][2] = test_output[63:60];
	assign solved[7][1] = test_output[67:64];
	assign solved[7][0] = test_output[71:68];
	assign solved[6][8] = test_output[75:72];
	assign solved[6][7] = test_output[79:76];
	assign solved[6][6] = test_output[83:80];
	assign solved[6][5] = test_output[87:84];
	assign solved[6][4] = test_output[91:88];
	assign solved[6][3] = test_output[95:92];
	assign solved[6][2] = test_output[99:96];
	assign solved[6][1] = test_output[103:100];
	assign solved[6][0] = test_output[107:104];
	assign solved[5][8] = test_output[111:108];
	assign solved[5][7] = test_output[115:112];
	assign solved[5][6] = test_output[119:116];
	assign solved[5][5] = test_output[123:120];
	assign solved[5][4] = test_output[127:124];
	assign solved[5][3] = test_output[131:128];
	assign solved[5][2] = test_output[135:132];
	assign solved[5][1] = test_output[139:136];
	assign solved[5][0] = test_output[143:140];
	assign solved[4][8] = test_output[147:144];
	assign solved[4][7] = test_output[151:148];
	assign solved[4][6] = test_output[155:152];
	assign solved[4][5] = test_output[159:156];
	assign solved[4][4] = test_output[163:160];
	assign solved[4][3] = test_output[167:164];
	assign solved[4][2] = test_output[171:168];
	assign solved[4][1] = test_output[175:172];
	assign solved[4][0] = test_output[179:176];
	assign solved[3][8] = test_output[183:180];
	assign solved[3][7] = test_output[187:184];
	assign solved[3][6] = test_output[191:188];
	assign solved[3][5] = test_output[195:192];
	assign solved[3][4] = test_output[199:196];
	assign solved[3][3] = test_output[203:200];
	assign solved[3][2] = test_output[207:204];
	assign solved[3][1] = test_output[211:208];
	assign solved[3][0] = test_output[215:212];
	assign solved[2][8] = test_output[219:216];
	assign solved[2][7] = test_output[223:220];
	assign solved[2][6] = test_output[227:224];
	assign solved[2][5] = test_output[231:228];
	assign solved[2][4] = test_output[235:232];
	assign solved[2][3] = test_output[239:236];
	assign solved[2][2] = test_output[243:240];
	assign solved[2][1] = test_output[247:244];
	assign solved[2][0] = test_output[251:248];
	assign solved[1][8] = test_output[255:252];
	assign solved[1][7] = test_output[259:256];
	assign solved[1][6] = test_output[263:260];
	assign solved[1][5] = test_output[267:264];
	assign solved[1][4] = test_output[271:268];
	assign solved[1][3] = test_output[275:272];
	assign solved[1][2] = test_output[279:276];
	assign solved[1][1] = test_output[283:280];
	assign solved[1][0] = test_output[287:284];
	assign solved[0][8] = test_output[291:288];
	assign solved[0][7] = test_output[295:292];
	assign solved[0][6] = test_output[299:296];
	assign solved[0][5] = test_output[303:300];
	assign solved[0][4] = test_output[307:304];
	assign solved[0][3] = test_output[311:308];
	assign solved[0][2] = test_output[315:312];
	assign solved[0][1] = test_output[319:316];
	assign solved[0][0] = test_output[323:320];

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
					    4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0,
					    4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0};
		#10;

		test_input  =  {4'd2, 4'd5, 4'd4, 4'd8, 4'd1, 4'd3, 4'd6, 4'd9, 4'd7,
					    4'd7, 4'd1, 4'd9, 4'd6, 4'd2, 4'd5, 4'd8, 4'd3, 4'd4,
					    4'd8, 4'd6, 4'd3, 4'd4, 4'd7, 4'd9, 4'd1, 4'd2, 4'd5,
					    4'd4, 4'd3, 4'd5, 4'd9, 4'd6, 4'd1, 4'd7, 4'd8, 4'd2,
					    4'd1, 4'd2, 4'd7, 4'd5, 4'd4, 4'd8, 4'd9, 4'd6, 4'd3,
					    4'd6, 4'd9, 4'd8, 4'd7, 4'd3, 4'd2, 4'd4, 4'd5, 4'd1,
					    4'd3, 4'd8, 4'd2, 4'd1, 4'd9, 4'd4, 4'd5, 4'd7, 4'd6,
					    4'd5, 4'd7, 4'd1, 4'd2, 4'd8, 4'd6, 4'd3, 4'd4, 4'd9,
					    4'd9, 4'd4, 4'd6, 4'd3, 4'd5, 4'd7, 4'd2, 4'd1, 4'd8};
		#10;
		
		printstatus;

		test_input  =  {4'd0, 4'd5, 4'd4, 4'd8, 4'd1, 4'd3, 4'd6, 4'd9, 4'd7,
					    4'd7, 4'd1, 4'd9, 4'd6, 4'd2, 4'd5, 4'd8, 4'd3, 4'd4,
					    4'd8, 4'd6, 4'd3, 4'd4, 4'd7, 4'd9, 4'd1, 4'd2, 4'd5,
					    4'd4, 4'd3, 4'd5, 4'd9, 4'd6, 4'd1, 4'd7, 4'd8, 4'd2,
					    4'd1, 4'd2, 4'd7, 4'd5, 4'd4, 4'd8, 4'd9, 4'd6, 4'd3,
					    4'd6, 4'd9, 4'd8, 4'd7, 4'd3, 4'd2, 4'd4, 4'd5, 4'd1,
					    4'd3, 4'd8, 4'd2, 4'd1, 4'd9, 4'd4, 4'd5, 4'd7, 4'd6,
					    4'd5, 4'd7, 4'd1, 4'd2, 4'd8, 4'd6, 4'd3, 4'd4, 4'd9,
					    4'd9, 4'd4, 4'd6, 4'd3, 4'd5, 4'd7, 4'd2, 4'd1, 4'd8};
		#10;
		
		printstatus;

		test_input  =  {4'd0, 4'd5, 4'd4, 4'd8, 4'd1, 4'd3, 4'd6, 4'd9, 4'd7,
					    4'd7, 4'd1, 4'd9, 4'd6, 4'd2, 4'd5, 4'd8, 4'd3, 4'd4,
					    4'd8, 4'd6, 4'd3, 4'd4, 4'd7, 4'd9, 4'd1, 4'd2, 4'd5,
					    4'd4, 4'd3, 4'd5, 4'd9, 4'd6, 4'd1, 4'd7, 4'd8, 4'd2,
					    4'd1, 4'd2, 4'd7, 4'd5, 4'd4, 4'd8, 4'd9, 4'd6, 4'd3,
					    4'd6, 4'd9, 4'd8, 4'd7, 4'd3, 4'd0, 4'd4, 4'd5, 4'd1,
					    4'd3, 4'd8, 4'd2, 4'd1, 4'd9, 4'd4, 4'd5, 4'd7, 4'd6,
					    4'd5, 4'd7, 4'd1, 4'd2, 4'd8, 4'd6, 4'd3, 4'd4, 4'd9,
					    4'd9, 4'd4, 4'd6, 4'd3, 4'd5, 4'd7, 4'd2, 4'd1, 4'd8};
		#10;
		
		printstatus;

		test_input  =  {4'd0, 4'd5, 4'd4, 4'd8, 4'd1, 4'd3, 4'd6, 4'd9, 4'd7,
					    4'd7, 4'd1, 4'd9, 4'd6, 4'd2, 4'd5, 4'd8, 4'd3, 4'd4,
					    4'd8, 4'd6, 4'd3, 4'd4, 4'd7, 4'd9, 4'd1, 4'd2, 4'd5,
					    4'd4, 4'd3, 4'd5, 4'd9, 4'd6, 4'd1, 4'd7, 4'd8, 4'd2,
					    4'd1, 4'd2, 4'd7, 4'd5, 4'd4, 4'd8, 4'd9, 4'd6, 4'd3,
					    4'd6, 4'd9, 4'd8, 4'd7, 4'd3, 4'd0, 4'd4, 4'd5, 4'd1,
					    4'd3, 4'd8, 4'd2, 4'd1, 4'd9, 4'd4, 4'd5, 4'd7, 4'd6,
					    4'd5, 4'd7, 4'd1, 4'd2, 4'd8, 4'd6, 4'd3, 4'd4, 4'd9,
					    4'd9, 4'd4, 4'd6, 4'd3, 4'd5, 4'd0, 4'd2, 4'd1, 4'd8};
		#10;
		
		printstatus;

		#50;
		$finish;
	end

	always #5 clk = ~clk;

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