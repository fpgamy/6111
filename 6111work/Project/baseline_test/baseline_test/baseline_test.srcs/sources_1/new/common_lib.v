localparam   GRID_SIZE = 9;
localparam   MAX_GUESSES = 16;

`define GET_LSB(M)\
-M & M
