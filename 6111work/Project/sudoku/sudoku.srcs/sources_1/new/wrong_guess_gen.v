`timescale 1ns / 1ps


module wrong_guess_gen(
        input[323:0] input_board,
        input[323:0] solved_board,
        input[3:0] state,
        output wrong_guess
    );
    
wire[80:0] different;

genvar i;
generate
    
for(i = 0; i < 81; i = i + 1) begin: diff_gen
    assign different[i] = (input_board[(4 * i) + 3-:4] != solved_board[(4 * i) + 3-:4]) && (input_board[(4 * i) + 3-:4]);
end
endgenerate

assign wrong_guess = (|different) && (state == 9);
endmodule
