module camera_address_gen(
    input wire camera_clk,
    input wire camera_pixel_valid,
    input wire camera_frame_done,
    input wire capture_frame,
    input wire [15:0] camera_pixel,
    output reg [11:0] memory_data,
    output wire [18:0] memory_addr,
    output reg memory_we
    );
    
    
    parameter VCOUNT_MAX = 479;
    parameter HCOUNT_MAX = 639;
    
    reg [11:0] vcount = 0;
    reg [11:0] hcount = 0;
    reg capture_frame_latched = 0;
    
    assign memory_addr = hcount + vcount * (HCOUNT_MAX+1);
    
    always@(posedge camera_clk) begin
    
        capture_frame_latched <= capture_frame ? 1 : camera_frame_done ? 0 : capture_frame_latched;
        if(camera_frame_done) begin //set frame done
            vcount <= 0;
            hcount <= 0;
            memory_we <= 0;
        end
        
        else begin 
            hcount <= camera_pixel_valid ? (hcount >= HCOUNT_MAX) ? 0 : hcount + 1 : hcount;
            vcount <= camera_pixel_valid & (hcount >= HCOUNT_MAX) ? vcount + 1 : vcount; 
            memory_we <= capture_frame_latched ? camera_pixel_valid : 0;
            memory_data <= {camera_pixel[15:12], camera_pixel[10:7], camera_pixel[4:1]}; //convert camera RGB:565 to RGB:444
        end
    end
endmodule