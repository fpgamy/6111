`ifndef DISPLAY_SV
`define DISPLAY_SV

`define INSIDE(pixel_x, pixel_y, region_x, region_y, region_w, region_h) \
	(((pixel_x > region_x) && (pixel_x < (region_x + region_w))) && ((pixel_y > region_y) && (pixel_y < (region_y + region_h))))

`define ONBORDER(pixel_x, pixel_y) \
	`INSIDE(pixel_x, pixel_y, 0, 0, 640, 6)     | \
	`INSIDE(pixel_x, pixel_y, 0, CELL_PIXELS*GRID_SIZE-6, 640, 6)   | \
	`INSIDE(pixel_x, pixel_y, 0, 0, 6, 640)     | \
	`INSIDE(pixel_x, pixel_y, CELL_PIXELS*GRID_SIZE-6, 0, 6, 640)

`define ONGRID(pixel_x, pixel_y) \
	`INSIDE(pixel_x, pixel_y, 0, 3*48-1, 640, 2)     | \
	`INSIDE(pixel_x, pixel_y, 0, 6*48-1, 640, 2)     | \
	`INSIDE(pixel_x, pixel_y, 3*48-1, 0, 2, 640)     | \
	`INSIDE(pixel_x, pixel_y, 6*48-1, 0, 2, 640)

`define OR_ARR(ARR) \
ARR[0] |\
ARR[1] |\
ARR[2] |\
ARR[3] |\
ARR[4] |\
ARR[5] |\
ARR[6] |\
ARR[7] |\
ARR[8] |\
ARR[9] |\
ARR[10] |\
ARR[11] |\
ARR[12] |\
ARR[13] |\
ARR[14] |\
ARR[15] |\
ARR[16] |\
ARR[17] |\
ARR[18] |\
ARR[19] |\
ARR[20] |\
ARR[21] |\
ARR[22] |\
ARR[23] |\
ARR[24] |\
ARR[25] |\
ARR[26] |\
ARR[27] |\
ARR[28] |\
ARR[29] |\
ARR[30] |\
ARR[31] |\
ARR[32] |\
ARR[33] |\
ARR[34] |\
ARR[35] |\
ARR[36] |\
ARR[37] |\
ARR[38] |\
ARR[39] |\
ARR[40] |\
ARR[41] |\
ARR[42] |\
ARR[43] |\
ARR[44] |\
ARR[45] |\
ARR[46] |\
ARR[47]

function automatic [3:0] get_line;
input [9:0] line;
begin
	if (line < CELL_PIXELS)
	begin
		get_line = 1;
	end
	else if (line < 2*CELL_PIXELS)
	begin
		get_line = 2;		
	end
	else if (line < 3*CELL_PIXELS)
	begin
		get_line = 3;
	end
	else if (line < 4*CELL_PIXELS)
	begin
		get_line = 4;
	end
	else if (line < 5*CELL_PIXELS)
	begin
		get_line = 5;
	end
	else if (line < 6*CELL_PIXELS)
	begin
		get_line = 6;
	end
	else if (line < 7*CELL_PIXELS)
	begin
		get_line = 7;
	end
	else if (line < 8*CELL_PIXELS)
	begin
		get_line = 8;
	end
	else
	begin
		get_line = 9;
	end
end
endfunction

function automatic pick_num;
input [3:0] num;
input one, two, three, four, five, six, seven, eight, nine;
begin
	case (num)
		4'd0: pick_num = 0;
		4'd1: pick_num = one;
		4'd2: pick_num = two;
		4'd3: pick_num = three;
		4'd4: pick_num = four;
		4'd5: pick_num = five;
		4'd6: pick_num = six;
		4'd7: pick_num = seven;
		4'd8: pick_num = eight;
		4'd9: pick_num = nine;
		default: pick_num = 0;
	endcase
end
endfunction

`endif