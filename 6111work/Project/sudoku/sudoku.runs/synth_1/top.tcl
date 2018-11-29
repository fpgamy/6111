# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.cache/wt [current_project]
set_property parent.project_path /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
add_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/coe/one.coe
add_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/coe/two.coe
add_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/coe/three.coe
add_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/coe/four.coe
add_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/coe/five.coe
add_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/coe/six.coe
add_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/coe/seven.coe
add_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/coe/eight.coe
add_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/coe/nine.coe
add_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/coe/chartest.coe
add_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/imports/baseline_test/eight.coe
add_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/imports/baseline_test/three.coe
add_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/imports/baseline_test/seven.coe
add_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/imports/baseline_test/one.coe
add_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/imports/baseline_test/nine.coe
add_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/imports/baseline_test/five.coe
add_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/imports/baseline_test/six.coe
add_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/imports/baseline_test/two.coe
add_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/imports/baseline_test/four.coe
add_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/coe/48/one.coe
add_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/coe/48/two.coe
add_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/coe/48/three.coe
add_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/coe/48/four.coe
add_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/coe/48/five.coe
add_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/coe/48/six.coe
add_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/coe/48/seven.coe
add_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/coe/48/eight.coe
add_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/coe/48/nine.coe
add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/frame_buffer/frame_buffer.dcp
set_property used_in_implementation false [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/frame_buffer/frame_buffer.dcp]
add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/video_clk/video_clk.dcp
set_property used_in_implementation false [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/video_clk/video_clk.dcp]
add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/rescaled_frame_buffer/rescaled_frame_buffer.dcp
set_property used_in_implementation false [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/rescaled_frame_buffer/rescaled_frame_buffer.dcp]
add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/one_16_d/one_16_d.dcp
set_property used_in_implementation false [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/one_16_d/one_16_d.dcp]
add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/nine_16_d/nine_16_d.dcp
set_property used_in_implementation false [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/nine_16_d/nine_16_d.dcp]
add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/five_16_d/five_16_d.dcp
set_property used_in_implementation false [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/five_16_d/five_16_d.dcp]
add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/six_16_d/six_16_d.dcp
set_property used_in_implementation false [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/six_16_d/six_16_d.dcp]
add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/four_16_d/four_16_d.dcp
set_property used_in_implementation false [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/four_16_d/four_16_d.dcp]
add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/seven_16_d/seven_16_d.dcp
set_property used_in_implementation false [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/seven_16_d/seven_16_d.dcp]
add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/two_16_d/two_16_d.dcp
set_property used_in_implementation false [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/two_16_d/two_16_d.dcp]
add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/eight_16_d/eight_16_d.dcp
set_property used_in_implementation false [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/eight_16_d/eight_16_d.dcp]
add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/three_16_d_1/three_16_d.dcp
set_property used_in_implementation false [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/three_16_d_1/three_16_d.dcp]
add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/eight_image_48_48/eight_image_48_48.dcp
set_property used_in_implementation false [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/eight_image_48_48/eight_image_48_48.dcp]
add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/four_image_48_48/four_image_48_48.dcp
set_property used_in_implementation false [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/four_image_48_48/four_image_48_48.dcp]
add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/two_image_48_48/two_image_48_48.dcp
set_property used_in_implementation false [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/two_image_48_48/two_image_48_48.dcp]
add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/six_image_48_48/six_image_48_48.dcp
set_property used_in_implementation false [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/six_image_48_48/six_image_48_48.dcp]
add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/five_image_48_48/five_image_48_48.dcp
set_property used_in_implementation false [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/five_image_48_48/five_image_48_48.dcp]
add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/nine_image_48_48/nine_image_48_48.dcp
set_property used_in_implementation false [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/nine_image_48_48/nine_image_48_48.dcp]
add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/one_image_48_48/one_image_48_48.dcp
set_property used_in_implementation false [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/one_image_48_48/one_image_48_48.dcp]
add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/seven_image_48_48/seven_image_48_48.dcp
set_property used_in_implementation false [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/seven_image_48_48/seven_image_48_48.dcp]
add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/three_image_48_48/three_image_48_48.dcp
set_property used_in_implementation false [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/three_image_48_48/three_image_48_48.dcp]
read_verilog -library xil_defaultlib {
  /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/imports/wbraun/projects/OV7670-Verilog/src/SCCB_interface.v
  /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/imports/wbraun/projects/OV7670-Verilog/src/OV7670_config_rom.v
  /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/imports/wbraun/projects/OV7670-Verilog/src/OV7670_config.v
  /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/new/frame_transfer.v
  /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/imports/Downloads/divider.v
  /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/new/max_score.v
  /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/imports/wbraun/projects/OV7670-Verilog/src/camera_read.v
  /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/imports/wbraun/projects/OV7670-Verilog/src/camera_configure.v
  /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/new/camera_address_gen.v
  /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/imports/new/frame_parser.v
  /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/new/video_playback.v
  /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/new/reset.v
  /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/imports/lab4/display_8hex.v
  /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/imports/lab4/debounce.v
  /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/new/clk_prescale.v
  /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/new/char_rec.v
  /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/new/camera.v
  /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/new/bram_quarantine.v
  /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/imports/wbraun/Dropbox/bku/camera_v2/camera_v2.srcs/sources_1/imports/sources_1/imports/new/top.v
  /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/imports/lab4/synchronize.v
  /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/new/sudoku_fsm.v
  /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/imports/new/majority_enc.v
  /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/imports/new/display_grid.v
  /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/imports/new/display_lib.v
  /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/imports/new/common_lib.v
}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/constrs_1/imports/Downloads/Nexys4DDR_Master.xdc
set_property used_in_implementation false [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/constrs_1/imports/Downloads/Nexys4DDR_Master.xdc]


synth_design -top top -part xc7a100tcsg324-1


write_checkpoint -force -noxdef top.dcp

catch { report_utilization -file top_utilization_synth.rpt -pb top_utilization_synth.pb }
