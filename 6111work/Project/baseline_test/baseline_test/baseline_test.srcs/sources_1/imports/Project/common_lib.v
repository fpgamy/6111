localparam   GRID_SIZE = 9;
localparam   MAX_GUESSES = 16;

`define GET_LSB(M)\
-M & M

`define MAX(N1, N2)\
((N1 > N2) ? N1 : N2)

`define MAX_OUT_OF_NINE(N1, N2, N3, N4, N5, N6, N7, N8, N9)\
`MAX(N1, `MAX(N2, `MAX(N3, `MAX(N4, `MAX(N5, `MAX(N6, `MAX(N7, `MAX(N8, N9) ) ) ) ) ) ) )
