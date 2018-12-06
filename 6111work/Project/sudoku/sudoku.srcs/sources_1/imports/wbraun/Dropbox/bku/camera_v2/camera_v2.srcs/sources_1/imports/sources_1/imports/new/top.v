`timescale 1ns / 1ps
//`default_nettype none 

module top(
    input wire CLK_100M,
	input wire [15:0] SW,
	output wire [15:0] LED,
	output wire RGB1_Blue, RGB1_Green, RGB1_Red,
	output wire RGB2_Blue, RGB2_Green, RGB2_Red,
	output wire [7:0] SEG, [7:0] AN, //7 segment LED display
	input wire CPU_RESETN, BTNC, BTNU, BTNL, BTNR, BTND, //buttons
	inout wire [7:0] JA, JB, JC, JD, //PMOD headers
	//input wire [3:0] XA_N, XA_P, //analog inputs
	output wire [3:0] VGA_R, VGA_G, VGA_B, //VGA outputs
	output wire VGA_HS, VGA_VS
    );
    localparam   GRID_SIZE = 9;

    wire reset;
//    assign reset = 0;
   
    wire video_clk;
    
    wire VGA_VSYNC;
    assign VGA_VS = VGA_VSYNC;
    
    //camera signals
    wire camera_pwdn;
    wire camera_clk_in;
    wire camera_clk_out;
    wire [7:0] camera_dout;
    wire camera_scl, camera_sda;
    wire camera_vsync, camera_hsync;      
    wire [15:0] camera_pixel;
    wire camera_pixel_valid;
    wire camera_reset;
    wire camera_frame_done;
     
    assign camera_clk_in = video_clk;
    assign camera_pwdn = 0;
    assign camera_reset = 1'b1;//~reset; 
    
//assign camera outputs
   assign JA[0] = camera_pwdn;
   assign camera_dout[0] = JA[1];
   assign camera_dout[2] = JA[2];
   assign camera_dout[4] = JA[3];
   assign JA[4] = camera_reset;
   assign camera_dout[1] = JA[5];
   assign camera_dout[3] = JA[6];
   assign camera_dout[5] = JA[7];
   
   assign camera_dout[6] = JB[0];
   assign JB[1] = camera_clk_in;
   assign camera_hsync = JB[2];
   assign JB[3]= camera_sda; 
   assign camera_dout[7] = JB[4];
   assign camera_clk_out = JB[7];
   assign camera_vsync = JB[5];
   //assign JB[7] = camera_scl;
   
   wire [11:0] memory_read_data;
   wire [11:0] memory_write_data;
   
   wire [18:0] video_read_addr;
   wire [18:0] memory_read_addr;
   wire [18:0] img_read_addr;

//   assign img_read_addr = 0;

   wire [18:0] memory_write_addr;
   wire memory_write_enable; 
   
   // No longer camera shit lmao
   
   //  instantiate 7-segment display;  
   wire [31:0] data;
   wire [6:0] segments;
   display_8hex display(.clk(video_clk),.data(data), .seg(segments), .strobe(AN));    
   assign SEG[6:0] = segments;
   assign SEG[7] = 1'b1;
   
   reg[3:0] state = 6;

//   assign data[3:0] = state;
    // 104
   reg[9:0] x1 = 108;
   reg[9:0] y1 = 28;
   reg[9:0] x2 = 540;
   reg[9:0] y2 = 460;
   
   // Synchronizers and power-on-reset
   
   pwr_reset reset_1 (.clk(CLK_100M), .reset_input(SW[15]), .reset(reset));
    
    // FSM shit

    
//    sudoku_fsm sudoku_fsm_1 (
//        .clk(video_clk), 
//        .state_out(state), 
//        .enter(BTNC), 
//        .reset(SW[15]));    

    wire[323:0] recg_sudoku;
    
    wire [4*(GRID_SIZE)*(GRID_SIZE)-1:0] board;
    wire [4*(GRID_SIZE)*(GRID_SIZE)-1:0] board_solved;
    wire sudoku_invalid;
    wire sudoku_done;
    
    assign board = {4'd0, 4'd0, 4'd4, 4'd0, 4'd0, 4'd0, 4'd0, 4'd9, 4'd0,
                            4'd0, 4'd1, 4'd0, 4'd0, 4'd0, 4'd5, 4'd8, 4'd0, 4'd0,
                            4'd8, 4'd6, 4'd0, 4'd0, 4'd0, 4'd0, 4'd1, 4'd0, 4'd0,
                            4'd0, 4'd3, 4'd0, 4'd0, 4'd0, 4'd1, 4'd0, 4'd0, 4'd0,
                            4'd0, 4'd0, 4'd7, 4'd5, 4'd4, 4'd0, 4'd0, 4'd0, 4'd0,
                            4'd0, 4'd0, 4'd0, 4'd7, 4'd0, 4'd0, 4'd0, 4'd5, 4'd0,
                            4'd0, 4'd0, 4'd2, 4'd0, 4'd9, 4'd0, 4'd0, 4'd7, 4'd0,
                            4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd6, 4'd3, 4'd0, 4'd0,
                            4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd0, 4'd8};
                            
    soduku_solver my_love(.clk_in(video_clk), .reset_in(reset), .board_in(board), .board_out(board_solved), .done_out(sudoku_done), .invalid_out(sudoku_invalid));

    // States
    parameter IDLE = 0;
    parameter CHOOSE_XY1 = 1;
    parameter CHOOSE_XY2 = 2;
    parameter RESIZING = 3;
    parameter RECOGNIZING = 4;
    parameter SOLVING = 5;
    parameter OUTPUT = 6;
    
    assign state_out = state;
    
    wire btnc_cln;
    wire btnl_cln;
    wire btnr_cln;
    wire btnu_cln;
    wire btnd_cln;
    
    
    debounce deb_btnc (.clk(video_clk), .reset(reset), .noisy(BTNC), .clean(btnc_cln));
    
    debounce deb_btnl (.clk(video_clk), .reset(reset), .noisy(BTNL), .clean(btnl_cln));
    debounce deb_btnr (.clk(video_clk), .reset(reset), .noisy(BTNR), .clean(btnr_cln));
    debounce deb_btnu (.clk(video_clk), .reset(reset), .noisy(BTNU), .clean(btnu_cln));
    debounce deb_btnd (.clk(video_clk), .reset(reset), .noisy(BTND), .clean(btnd_cln));
    
    reg frame_parser_start = 0;

    reg last_btnc = 0;
    wire btnc_rise = (btnc_cln && ~last_btnc);
    
    wire clk_ps;
    clk_prescale clk_prescale_1 (.clk(video_clk), .clk_ps(clk_ps));
    wire frame_parser_done;
    reg char_rec_start = 0;

    reg frame_parser_started = 0;
    reg char_rec_started = 0;
    wire char_rec_done;
    
        
    always @(posedge video_clk) begin
        if(SW[15]) begin
            state <= 0;//IDLE;
            frame_parser_started <= 0;
            char_rec_started <= 0;
        end
        
        else if (VGA_VS) begin 
            case(state)
                IDLE: begin
                    if(btnc_rise) begin
                        state <= CHOOSE_XY1;
                    end
                end
                CHOOSE_XY1: begin
                   if(btnc_rise) begin
                      state <= CHOOSE_XY2;
                    end else if(clk_ps) begin
                       if (btnl_cln) begin
                            x1 <= x1 - 1;
                        end else if (btnr_cln) begin
                            x1 <= x1 + 1;
                        end else if (btnu_cln) begin
                            y1 <= y1 - 1;
                        end else if (btnd_cln) begin
                            y1 <= y1 + 1;
                        end  
                    end
                end
                CHOOSE_XY2: begin
                   if(btnc_rise) begin
                     state <= RESIZING;
                   end else if(clk_ps) begin
                      if (btnl_cln) begin
                           x2 <= x2 - 1;
                       end else if (btnr_cln) begin
                           x2 <= x2 + 1;
                       end else if (btnu_cln) begin
                           y2 <= y2 - 1;
                       end else if (btnd_cln) begin
                           y2 <= y2 + 1;
                       end  
                   end
                end
                RESIZING: begin
                    if(btnr_cln) begin 
                        frame_parser_start <= 1;
                        frame_parser_started <= 1;
                    end else begin
                        frame_parser_start <= 0;
                    end
                    
                    if(frame_parser_done && frame_parser_started) begin
                        state <= RECOGNIZING;
                        frame_parser_start <= 0;
                    end
                end
                RECOGNIZING: begin
                    if(btnl_cln) begin
                        char_rec_start <= 1;
                        char_rec_started <= 1;
                    end
                    
                    if(char_rec_done && char_rec_started) begin
//                        board <= recg_sudoku;
                        state <= SOLVING;
                    end
                end
                SOLVING: begin
                        
                end
                OUTPUT: begin
                                
                end   
            endcase
        end
        last_btnc <= btnc_cln;  
        if(char_rec_start) char_rec_start <= 0;
    end

   
   // Camera shit
   
    //clock generation
    video_clk video_clk_1 (
        .clk_in1(CLK_100M), 
        .clk_out1(video_clk)              
         );
        
    camera camera_1 (
        .video_clk(video_clk),
        .camera_start(SW[15]),
        .sioc(JB[6]),
        .siod(JB[3]),
        .capture_frame(state == 0),
        .camera_vsync(camera_vsync),
        .camera_hsync(camera_hsync),
        .camera_dout(camera_dout),
        .camera_clk(camera_clk_out),
        .camera_pixel(camera_pixel),
        .camera_pixel_valid(camera_pixel_valid),
        .camera_frame_done(camera_frame_done),
        .memory_write_data(memory_write_data),
        .memory_write_addr(memory_write_addr),
        .memory_write_enable(memory_write_enable));
            
    wire[11:0] rescaled_pix_data;
    wire[11:0] rescaled_fb_dout;
    wire switch_vid = SW[1];

                      
                      
    wire[9:0] hcount;
    wire[9:0] vcount;
    wire blank;
    

        
    video_playback video_playback_1 (
        .pixel_data(memory_read_data),
        .rescaled_pix_data(rescaled_fb_dout),
        .video_clk(video_clk),
        .memory_addr(video_read_addr),
        .vsync(VGA_VSYNC),
        .hsync(VGA_HS),
        .hcount_out(hcount),
        .vcount_out(vcount),
        .blank_out(blank),
        .video_out({VGA_R, VGA_G, VGA_B}),
        .x1(x1), .y1(y1), .x2(x2), .y2(y2), 
        .state(state),
        .switch_vid(switch_vid),
        .board_in((state == OUTPUT) ? board_solved : recg_sudoku)
        );
        
        
    
    // Memory shit
    
    assign memory_read_addr = (state == 0 || state == 1 || state == 2) ? video_read_addr : img_read_addr;
       
    //frame buffer memory   
    frame_buffer frame_buffer_1 (
        .clka(camera_clk_out),
        .wea(memory_write_enable),
        .addra(memory_write_addr),
        .dina(memory_write_data),
        .clkb(video_clk),
        //.enb(1'b1),
        .addrb(memory_read_addr),
        .doutb(memory_read_data)
        );
        
    wire rescaled_fb_we;    
    wire[14:0] rescaled_fb_vid_addr = video_read_addr[14:0];
    wire[14:0] rescaled_fb_write_addr;
    wire[14:0] char_ram_addr;
    
    wire[11:0] rescaled_fb_din;

    wire[14:0] rescaled_fb_addr = 
            switch_vid ? rescaled_fb_vid_addr : (~SW[2] ? rescaled_fb_write_addr : char_ram_addr);
    
    assign LED[0] = switch_vid;
    assign LED[1] = (state == RESIZING);
    
    frame_parser frame_parser_1 (
        .clk(video_clk),
        .start(frame_parser_start),
        .x1(x1), .y1(y1),
        .x2(x2), .y2(y2),
        
        .img_read_data_in(memory_read_data),
        .img_read_addr_out(img_read_addr),
        
        .img_write_data_out(rescaled_fb_din),
        .img_write_addr_out(rescaled_fb_write_addr),
        
        .we_out(rescaled_fb_we),
        
        .done(frame_parser_done)
        );

    rescaled_frame_buffer rescaled_fb_1 (
        .clka(video_clk),
        .addra(rescaled_fb_addr),
        .dina(rescaled_fb_din),
        .douta(rescaled_fb_dout),
        .wea(rescaled_fb_we));
        
    wire[7:0] rom_addr;
    wire one_d;
    wire two_d;
    wire three_d;
    wire four_d;
    wire five_d;
    wire six_d;
    wire seven_d;
    wire eight_d;
    wire nine_d;
    
    char_rec char_rec_1 (
        .clk(video_clk),
        .start(char_rec_start),
        .done(char_rec_done),
        .img_ram_addr(char_ram_addr),
        .img_ram_data(rescaled_fb_dout),
        .recg_sudoku(recg_sudoku));
        

    assign LED[2] = sudoku_done;
    assign data[3:0] = state;
endmodule