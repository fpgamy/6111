module video_playback(
    input wire [11:0] pixel_data,
    input wire [11:0] rescaled_pix_data,
    input wire video_clk,
    output wire [18:0] memory_addr,
    output reg vsync,
    output reg hsync,
    output wire [11:0] video_out,
    input[9:0] x1, y1,
    input[9:0] x2, y2,
    input[3:0] state,
    input switch_vid
    );
    
    parameter IDLE = 0;
    parameter CHOOSE_XY1 = 1;
    parameter CHOOSE_XY2 = 2;
    parameter TARGET_WIDTH = 144;
    
    // horizontal: 800 pixels total
    // display 640 pixels per line
    reg hblank,vblank;
    wire hsyncon,hsyncoff,hreset,hblankon;
    reg [11:0] hcount = 0;
    reg [11:0] vcount = 0;
    reg blank; 
    
    //kludges to fix frame alignment due to memory access time
    reg blank_delay;
    reg blank_delay_2;
    reg hsync_pre_delay;
    reg hsync_pre_delay_2;
    reg vsync_pre_delay;
    reg vsync_pre_delay_2;
    
    
    // Excessive? Maybe.
    assign video_out = blank_delay_2                                           ? 12'b0             : 
                       (switch_vid)                                            ? rescaled_pix_data : 
                       ((hcount == x1 || vcount == y1) && state == CHOOSE_XY1) ? ~pixel_data       : 
                       ((hcount == x2 || vcount == y2) && state == CHOOSE_XY2) ? ~pixel_data       : 
                       ((hcount == x1 || vcount == y1) && state == CHOOSE_XY2) ? 12'hF00           : pixel_data; 

    
    assign hblankon = (hcount == 639);   //blank after display width   
    assign hsyncon = (hcount == 655);  // active video + front porch
    assign hsyncoff = (hcount == 751); //active video + front portch + sync
    assign hreset = (hcount == 799); //plus back porch
    
    // vertical:  525 lines total
    // display 480 lines
    wire vsyncon,vsyncoff,vreset,vblankon;
    assign vblankon = hreset & (vcount == 479);    
    assign vsyncon = hreset & (vcount == 489);
    assign vsyncoff = hreset & (vcount == 491);
    assign vreset = (hreset & (vcount == 524));
    
    // sync and blanking
    wire next_hblank,next_vblank;
    assign next_hblank = hreset ? 0 : hblankon ? 1 : hblank;
    assign next_vblank = vreset ? 0 : vblankon ? 1 : vblank;
    // trust in this line
    assign memory_addr = (switch_vid) ? (((hcount < TARGET_WIDTH) && (vcount < TARGET_WIDTH)) ? hcount+(vcount*TARGET_WIDTH) : 0) : hcount+(vcount*640);
      
    always @(posedge video_clk) begin
        blank_delay <= blank;
        blank_delay_2 <= blank_delay;
        hsync_pre_delay_2 <= hsync_pre_delay;
        vsync_pre_delay_2 <= vsync_pre_delay;
        vsync <= vsync_pre_delay_2;
        hsync <= hsync_pre_delay_2;
         //hcount 
         hcount <= hreset ? 0 : hcount + 1;
         hblank <= next_hblank;
         hsync_pre_delay <= hsyncon ? 0 : hsyncoff ? 1 : hsync_pre_delay;  // active low
        
         vcount <= hreset ? (vreset ? 0 : vcount + 1) : vcount;
         vblank <= next_vblank;
         vsync_pre_delay <= vsyncon ? 0 : vsyncoff ? 1 : vsync_pre_delay;  // active low
        
         blank <= next_vblank | (next_hblank & ~hreset);
    end
endmodule