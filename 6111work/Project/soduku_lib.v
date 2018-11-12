//
// DEFINITIONS
//
`define RESET_3_BY_9(GRID) \
GRID[0][0] <= 0;\
GRID[1][0] <= 0;\
GRID[2][0] <= 0;\
GRID[3][0] <= 0;\
GRID[4][0] <= 0;\
GRID[5][0] <= 0;\
GRID[6][0] <= 0;\
GRID[7][0] <= 0;\
GRID[8][0] <= 0;\
GRID[0][1] <= 0;\
GRID[1][1] <= 0;\
GRID[2][1] <= 0;\
GRID[3][1] <= 0;\
GRID[4][1] <= 0;\
GRID[5][1] <= 0;\
GRID[6][1] <= 0;\
GRID[7][1] <= 0;\
GRID[8][1] <= 0;\
GRID[0][2] <= 0;\
GRID[1][2] <= 0;\
GRID[2][2] <= 0;\
GRID[3][2] <= 0;\
GRID[4][2] <= 0;\
GRID[5][2] <= 0;\
GRID[6][2] <= 0;\
GRID[7][2] <= 0;\
GRID[8][2] <= 0;\

//
// FUNCTIONS
//
function automatic [8:0] one_hot;
input [3:0] raw_in;
begin
	case(raw_in)
		4'd1	: one_hot = 9'b0_0000_0001;
		4'd2	: one_hot = 9'b0_0000_0010;
		4'd3	: one_hot = 9'b0_0000_0100;
		4'd4	: one_hot = 9'b0_0000_1000;
		4'd5	: one_hot = 9'b0_0001_0000;
		4'd6	: one_hot = 9'b0_0010_0000;
		4'd7	: one_hot = 9'b0_0100_0000;
		4'd8	: one_hot = 9'b0_1000_0000;
		4'd9	: one_hot = 9'b1_0000_0000;
		default	: one_hot = 9'b0_0000_0000;
	endcase
end
endfunction

function automatic [3:0] bcd;
input [8:0] one_hot_in;
begin
	case(one_hot_in)
		9'b0_0000_0001	: bcd = 4'd1;
		9'b0_0000_0010	: bcd = 4'd2;
		9'b0_0000_0100	: bcd = 4'd3;
		9'b0_0000_1000	: bcd = 4'd4;
		9'b0_0001_0000	: bcd = 4'd5;
		9'b0_0010_0000	: bcd = 4'd6;
		9'b0_0100_0000	: bcd = 4'd7;
		9'b0_1000_0000	: bcd = 4'd8;
		9'b1_0000_0000	: bcd = 4'd9;
		default			: bcd = 4'd0;
	endcase
end
endfunction

function automatic valid_one_hot;
input [8:0] one_hot_in;
begin
	case(one_hot_in)
		9'b0_0000_0001	: valid_one_hot = 1'b1;
		9'b0_0000_0010	: valid_one_hot = 1'b1;
		9'b0_0000_0100	: valid_one_hot = 1'b1;
		9'b0_0000_1000	: valid_one_hot = 1'b1;
		9'b0_0001_0000	: valid_one_hot = 1'b1;
		9'b0_0010_0000	: valid_one_hot = 1'b1;
		9'b0_0100_0000	: valid_one_hot = 1'b1;
		9'b0_1000_0000	: valid_one_hot = 1'b1;
		9'b1_0000_0000	: valid_one_hot = 1'b1;
		default			: valid_one_hot = 1'b0;
	endcase
end
endfunction

function automatic [8:0] get_exclusive_line_possibilities;
input [8:0] p1, p2, p3;
begin
	get_exclusive_line_possibilities = p1 & (~p2) & (~p3);
end
endfunction
