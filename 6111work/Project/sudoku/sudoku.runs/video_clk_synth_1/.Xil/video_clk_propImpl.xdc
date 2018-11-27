set_property SRC_FILE_INFO {cfile:/afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/sudoku/sudoku.srcs/sources_1/ip/video_clk/video_clk.xdc rfile:../../../sudoku.srcs/sources_1/ip/video_clk/video_clk.xdc id:1 order:EARLY scoped_inst:inst} [current_design]
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1]] 0.1
