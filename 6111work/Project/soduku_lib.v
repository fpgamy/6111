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

function automatic valid_one_cold;
input [8:0] one_cold_in;
begin
	case(one_cold_in)
		9'b1_1111_1110	: valid_one_cold = 1'b1;
		9'b1_1111_1101	: valid_one_cold = 1'b1;
		9'b1_1111_1011	: valid_one_cold = 1'b1;
		9'b1_1111_0111	: valid_one_cold = 1'b1;
		9'b1_1110_1111	: valid_one_cold = 1'b1;
		9'b1_1101_1111	: valid_one_cold = 1'b1;
		9'b1_1011_1111	: valid_one_cold = 1'b1;
		9'b1_0111_1111	: valid_one_cold = 1'b1;
		9'b0_1111_1111	: valid_one_cold = 1'b1;
		default			: valid_one_cold = 1'b0;
	endcase
end
endfunction

function automatic [8:0] singleton_solve;
input [8:0] row_missing_in;
input [8:0] col_missing_in;
input [8:0] square_missing_in;

begin
	if (valid_one_cold((row_missing_in | col_missing_in | square_missing_in)))
	begin
		singleton_solve = ~(row_missing_in | col_missing_in | square_missing_in);
	end
	else
	begin
		singleton_solve = 9'b0;
	end
end
endfunction