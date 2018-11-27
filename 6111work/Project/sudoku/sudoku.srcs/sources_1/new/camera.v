module camera(
    input video_clk,
    input camera_start,
    input sioc,
    input siod,
    input capture_frame,
    input camera_vsync,
    input camera_hsync,
    input[7:0] camera_dout,
    input camera_clk,
    output[15:0] camera_pixel,
    output camera_pixel_valid,
    output camera_frame_done,
    output[11:0] memory_write_data,
    output[18:0] memory_write_addr,
    output memory_write_enable
);


//camera configuration module    
camera_configure camera_configure_1 (
    .clk(video_clk),
    .start(camera_start),
    .sioc(sioc),
    .siod(siod),
    .done()
    );

//camera interface
camera_read camera_read_1 (
    .p_clock(camera_clk), 
    .vsync(camera_vsync), 
    .href(camera_hsync),
    .p_data(camera_dout), 
    .pixel_data(camera_pixel), 
    .pixel_valid(camera_pixel_valid),
    .frame_done(camera_frame_done) 
    );
    
        
//write camera data to frame buffer     
camera_address_gen camera_address_gen_1 (
    .camera_clk(camera_clk),
    .camera_pixel_valid(camera_pixel_valid),
    .camera_frame_done(camera_frame_done),
    .capture_frame(capture_frame),
    .camera_pixel(camera_pixel),
    .memory_data(memory_write_data),
    .memory_addr(memory_write_addr),
    .memory_we(memory_write_enable)
    );

endmodule