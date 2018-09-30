`define assert(signal, value) \
        if (signal !== value) \
        begin \
            $display("ASSERTION FAILED in %m at time %0t: signal != value", $time); \
        end

`define PRINTVEC(vec_in)\
	$write("%d ", vec_in[0]);\
	$write("%d ", vec_in[1]);\
	$write("%d ", vec_in[2]);\
	$write("%d ", vec_in[3]);\
	$write("%d ", vec_in[4]);\
	$write("%d ", vec_in[5]);\
	$write("%d ", vec_in[6]);\
	$write("%d ", vec_in[7]);\
	$write("%d ", vec_in[8]);\
	$display("");\

`define PRINTVECBIN(vec_in)\
	$write("%b ", vec_in[0]);\
	$write("%b ", vec_in[1]);\
	$write("%b ", vec_in[2]);\
	$write("%b ", vec_in[3]);\
	$write("%b ", vec_in[4]);\
	$write("%b ", vec_in[5]);\
	$write("%b ", vec_in[6]);\
	$write("%b ", vec_in[7]);\
	$write("%b ", vec_in[8]);\
	$display("");\

`define PRINTGRID(grid_in)\
	$write("%c[1;34m",27);\
	$write("%d ", grid_in[0][0]);\
	$write("%d ", grid_in[0][1]);\
	$write("%d ", grid_in[0][2]);\
	$write("%c[0m",27);\
	$write("%c[1;31m",27);\
	$write("%d ", grid_in[0][3]);\
	$write("%d ", grid_in[0][4]);\
	$write("%d ", grid_in[0][5]);\
	$write("%c[0m",27);\
	$write("%c[1;34m",27);\
	$write("%d ", grid_in[0][6]);\
	$write("%d ", grid_in[0][7]);\
	$write("%d ", grid_in[0][8]);\
	$display("");\
	$write("%c[0m",27);\
	$write("%c[1;34m",27);\
	$write("%d ", grid_in[1][0]);\
	$write("%d ", grid_in[1][1]);\
	$write("%d ", grid_in[1][2]);\
	$write("%c[0m",27);\
	$write("%c[1;31m",27);\
	$write("%d ", grid_in[1][3]);\
	$write("%d ", grid_in[1][4]);\
	$write("%d ", grid_in[1][5]);\
	$write("%c[0m",27);\
	$write("%c[1;34m",27);\
	$write("%d ", grid_in[1][6]);\
	$write("%d ", grid_in[1][7]);\
	$write("%d ", grid_in[1][8]);\
	$write("%c[0m",27);\
	$write("%c[1;34m",27);\
	$display("");\
	$write("%d ", grid_in[2][0]);\
	$write("%d ", grid_in[2][1]);\
	$write("%d ", grid_in[2][2]);\
	$write("%c[0m",27);\
	$write("%c[1;31m",27);\
	$write("%d ", grid_in[2][3]);\
	$write("%d ", grid_in[2][4]);\
	$write("%d ", grid_in[2][5]);\
	$write("%c[0m",27);\
	$write("%c[1;34m",27);\
	$write("%d ", grid_in[2][6]);\
	$write("%d ", grid_in[2][7]);\
	$write("%d ", grid_in[2][8]);\
	$write("%c[0m",27);\
	$write("%c[1;31m",27);\
	$display("");\
	$write("%d ", grid_in[3][0]);\
	$write("%d ", grid_in[3][1]);\
	$write("%d ", grid_in[3][2]);\
	$write("%c[0m",27);\
	$write("%c[1;34m",27);\
	$write("%d ", grid_in[3][3]);\
	$write("%d ", grid_in[3][4]);\
	$write("%d ", grid_in[3][5]);\
	$write("%c[0m",27);\
	$write("%c[1;31m",27);\
	$write("%d ", grid_in[3][6]);\
	$write("%d ", grid_in[3][7]);\
	$write("%d ", grid_in[3][8]);\
	$write("%c[0m",27);\
	$write("%c[1;31m",27);\
	$display("");\
	$write("%d ", grid_in[4][0]);\
	$write("%d ", grid_in[4][1]);\
	$write("%d ", grid_in[4][2]);\
	$write("%c[0m",27);\
	$write("%c[1;34m",27);\
	$write("%d ", grid_in[4][3]);\
	$write("%d ", grid_in[4][4]);\
	$write("%d ", grid_in[4][5]);\
	$write("%c[0m",27);\
	$write("%c[1;31m",27);\
	$write("%d ", grid_in[4][6]);\
	$write("%d ", grid_in[4][7]);\
	$write("%d ", grid_in[4][8]);\
	$write("%c[0m",27);\
	$write("%c[1;31m",27);\
	$display("");\
	$write("%d ", grid_in[5][0]);\
	$write("%d ", grid_in[5][1]);\
	$write("%d ", grid_in[5][2]);\
	$write("%c[0m",27);\
	$write("%c[1;34m",27);\
	$write("%d ", grid_in[5][3]);\
	$write("%d ", grid_in[5][4]);\
	$write("%d ", grid_in[5][5]);\
	$write("%c[0m",27);\
	$write("%c[1;31m",27);\
	$write("%d ", grid_in[5][6]);\
	$write("%d ", grid_in[5][7]);\
	$write("%d ", grid_in[5][8]);\
	$write("%c[0m",27);\
	$write("%c[1;34m",27);\
	$display("");\
	$write("%d ", grid_in[6][0]);\
	$write("%d ", grid_in[6][1]);\
	$write("%d ", grid_in[6][2]);\
	$write("%c[0m",27);\
	$write("%c[1;31m",27);\
	$write("%d ", grid_in[6][3]);\
	$write("%d ", grid_in[6][4]);\
	$write("%d ", grid_in[6][5]);\
	$write("%c[0m",27);\
	$write("%c[1;34m",27);\
	$write("%d ", grid_in[6][6]);\
	$write("%d ", grid_in[6][7]);\
	$write("%d ", grid_in[6][8]);\
	$write("%c[0m",27);\
	$write("%c[1;34m",27);\
	$display("");\
	$write("%d ", grid_in[7][0]);\
	$write("%d ", grid_in[7][1]);\
	$write("%d ", grid_in[7][2]);\
	$write("%c[0m",27);\
	$write("%c[1;31m",27);\
	$write("%d ", grid_in[7][3]);\
	$write("%d ", grid_in[7][4]);\
	$write("%d ", grid_in[7][5]);\
	$write("%c[0m",27);\
	$write("%c[1;34m",27);\
	$write("%d ", grid_in[7][6]);\
	$write("%d ", grid_in[7][7]);\
	$write("%d ", grid_in[7][8]);\
	$write("%c[0m",27);\
	$write("%c[1;34m",27);\
	$display("");\
	$write("%d ", grid_in[8][0]);\
	$write("%d ", grid_in[8][1]);\
	$write("%d ", grid_in[8][2]);\
	$write("%c[0m",27);\
	$write("%c[1;31m",27);\
	$write("%d ", grid_in[8][3]);\
	$write("%d ", grid_in[8][4]);\
	$write("%d ", grid_in[8][5]);\
	$write("%c[0m",27);\
	$write("%c[1;34m",27);\
	$write("%d ", grid_in[8][6]);\
	$write("%d ", grid_in[8][7]);\
	$write("%d ", grid_in[8][8]);\
	$write("%c[0m",27);\
	$write("%c[1;34m",27);\
	$display("");\
	$write("%c[0m",27);

`define PRINTGRIDONEHOT(grid_in)\
	$write("%c[1;34m",27);\
	$write("%b ", grid_in[0][0]);\
	$write("%b ", grid_in[0][1]);\
	$write("%b ", grid_in[0][2]);\
	$write("%c[0m",27);\
	$write("%c[1;31m",27);\
	$write("%b ", grid_in[0][3]);\
	$write("%b ", grid_in[0][4]);\
	$write("%b ", grid_in[0][5]);\
	$write("%c[0m",27);\
	$write("%c[1;34m",27);\
	$write("%b ", grid_in[0][6]);\
	$write("%b ", grid_in[0][7]);\
	$write("%b ", grid_in[0][8]);\
	$display("");\
	$write("%c[0m",27);\
	$write("%c[1;34m",27);\
	$write("%b ", grid_in[1][0]);\
	$write("%b ", grid_in[1][1]);\
	$write("%b ", grid_in[1][2]);\
	$write("%c[0m",27);\
	$write("%c[1;31m",27);\
	$write("%b ", grid_in[1][3]);\
	$write("%b ", grid_in[1][4]);\
	$write("%b ", grid_in[1][5]);\
	$write("%c[0m",27);\
	$write("%c[1;34m",27);\
	$write("%b ", grid_in[1][6]);\
	$write("%b ", grid_in[1][7]);\
	$write("%b ", grid_in[1][8]);\
	$write("%c[0m",27);\
	$write("%c[1;34m",27);\
	$display("");\
	$write("%b ", grid_in[2][0]);\
	$write("%b ", grid_in[2][1]);\
	$write("%b ", grid_in[2][2]);\
	$write("%c[0m",27);\
	$write("%c[1;31m",27);\
	$write("%b ", grid_in[2][3]);\
	$write("%b ", grid_in[2][4]);\
	$write("%b ", grid_in[2][5]);\
	$write("%c[0m",27);\
	$write("%c[1;34m",27);\
	$write("%b ", grid_in[2][6]);\
	$write("%b ", grid_in[2][7]);\
	$write("%b ", grid_in[2][8]);\
	$write("%c[0m",27);\
	$write("%c[1;31m",27);\
	$display("");\
	$write("%b ", grid_in[3][0]);\
	$write("%b ", grid_in[3][1]);\
	$write("%b ", grid_in[3][2]);\
	$write("%c[0m",27);\
	$write("%c[1;34m",27);\
	$write("%b ", grid_in[3][3]);\
	$write("%b ", grid_in[3][4]);\
	$write("%b ", grid_in[3][5]);\
	$write("%c[0m",27);\
	$write("%c[1;31m",27);\
	$write("%b ", grid_in[3][6]);\
	$write("%b ", grid_in[3][7]);\
	$write("%b ", grid_in[3][8]);\
	$write("%c[0m",27);\
	$write("%c[1;31m",27);\
	$display("");\
	$write("%b ", grid_in[4][0]);\
	$write("%b ", grid_in[4][1]);\
	$write("%b ", grid_in[4][2]);\
	$write("%c[0m",27);\
	$write("%c[1;34m",27);\
	$write("%b ", grid_in[4][3]);\
	$write("%b ", grid_in[4][4]);\
	$write("%b ", grid_in[4][5]);\
	$write("%c[0m",27);\
	$write("%c[1;31m",27);\
	$write("%b ", grid_in[4][6]);\
	$write("%b ", grid_in[4][7]);\
	$write("%b ", grid_in[4][8]);\
	$write("%c[0m",27);\
	$write("%c[1;31m",27);\
	$display("");\
	$write("%b ", grid_in[5][0]);\
	$write("%b ", grid_in[5][1]);\
	$write("%b ", grid_in[5][2]);\
	$write("%c[0m",27);\
	$write("%c[1;34m",27);\
	$write("%b ", grid_in[5][3]);\
	$write("%b ", grid_in[5][4]);\
	$write("%b ", grid_in[5][5]);\
	$write("%c[0m",27);\
	$write("%c[1;31m",27);\
	$write("%b ", grid_in[5][6]);\
	$write("%b ", grid_in[5][7]);\
	$write("%b ", grid_in[5][8]);\
	$write("%c[0m",27);\
	$write("%c[1;34m",27);\
	$display("");\
	$write("%b ", grid_in[6][0]);\
	$write("%b ", grid_in[6][1]);\
	$write("%b ", grid_in[6][2]);\
	$write("%c[0m",27);\
	$write("%c[1;31m",27);\
	$write("%b ", grid_in[6][3]);\
	$write("%b ", grid_in[6][4]);\
	$write("%b ", grid_in[6][5]);\
	$write("%c[0m",27);\
	$write("%c[1;34m",27);\
	$write("%b ", grid_in[6][6]);\
	$write("%b ", grid_in[6][7]);\
	$write("%b ", grid_in[6][8]);\
	$write("%c[0m",27);\
	$write("%c[1;34m",27);\
	$display("");\
	$write("%b ", grid_in[7][0]);\
	$write("%b ", grid_in[7][1]);\
	$write("%b ", grid_in[7][2]);\
	$write("%c[0m",27);\
	$write("%c[1;31m",27);\
	$write("%b ", grid_in[7][3]);\
	$write("%b ", grid_in[7][4]);\
	$write("%b ", grid_in[7][5]);\
	$write("%c[0m",27);\
	$write("%c[1;34m",27);\
	$write("%b ", grid_in[7][6]);\
	$write("%b ", grid_in[7][7]);\
	$write("%b ", grid_in[7][8]);\
	$write("%c[0m",27);\
	$write("%c[1;34m",27);\
	$display("");\
	$write("%b ", grid_in[8][0]);\
	$write("%b ", grid_in[8][1]);\
	$write("%b ", grid_in[8][2]);\
	$write("%c[0m",27);\
	$write("%c[1;31m",27);\
	$write("%b ", grid_in[8][3]);\
	$write("%b ", grid_in[8][4]);\
	$write("%b ", grid_in[8][5]);\
	$write("%c[0m",27);\
	$write("%c[1;34m",27);\
	$write("%b ", grid_in[8][6]);\
	$write("%b ", grid_in[8][7]);\
	$write("%b ", grid_in[8][8]);\
	$write("%c[0m",27);\
	$write("%c[1;34m",27);\
	$display("");\
	$write("%c[0m",27);