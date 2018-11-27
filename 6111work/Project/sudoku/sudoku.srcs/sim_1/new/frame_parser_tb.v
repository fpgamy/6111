`timescale 1ns / 1ps

module frame_parser_tb;

reg clk = 0;
reg start = 0;

reg[9:0] x1, y1 = 0; // top-left
reg[9:0] x2, y2 = 0; // bottom right

reg[11:0] img_read_data = 0;
wire[18:0] img_read_addr = 0;

wire[11:0] img_write_data_out;
wire[14:0] img_write_addr_out;
wire we_out;

wire done;


frame_parser uut (
    .clk(clk),
    .start(start),
    .x1(x1), .y1(y1),
    .x2(x2), .y2(y2),
    .img_read_data_in(img_read_data),
    .img_read_addr_out(img_read_addr),
    .img_write_data_out(img_write_data_out),
    .img_write_addr_out(img_write_addr_out),
    .we_out(we_out),
    .done(done));
    
initial begin
    #100;
    x1 = 0;
    y1 = 0;
    
    x2 = 440;
    y2 =  440;
    
    start = 1;
    #10;
    start = 0;
    
    #275 img_read_data = 1200;
    #20 img_read_data = 0;
end

always #5 clk = ~clk;

endmodule
