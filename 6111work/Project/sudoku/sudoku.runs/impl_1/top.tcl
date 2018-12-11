proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  set_param xicom.use_bs_reader 1
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.cache/wt [current_project]
  set_property parent.project_path /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.xpr [current_project]
  set_property ip_repo_paths /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.cache/ip [current_project]
  set_property ip_output_repo /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.cache/ip [current_project]
  set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.runs/synth_1/top.dcp
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/frame_buffer/frame_buffer.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/frame_buffer/frame_buffer.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/video_clk/video_clk.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/video_clk/video_clk.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/rescaled_frame_buffer/rescaled_frame_buffer.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/rescaled_frame_buffer/rescaled_frame_buffer.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/one_16_d/one_16_d.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/one_16_d/one_16_d.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/nine_16_d/nine_16_d.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/nine_16_d/nine_16_d.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/five_16_d/five_16_d.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/five_16_d/five_16_d.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/six_16_d/six_16_d.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/six_16_d/six_16_d.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/four_16_d/four_16_d.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/four_16_d/four_16_d.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/seven_16_d/seven_16_d.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/seven_16_d/seven_16_d.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/two_16_d/two_16_d.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/two_16_d/two_16_d.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/eight_16_d/eight_16_d.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/eight_16_d/eight_16_d.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/three_16_d_1/three_16_d.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/three_16_d_1/three_16_d.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/eight_image_48_48/eight_image_48_48.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/eight_image_48_48/eight_image_48_48.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/four_image_48_48/four_image_48_48.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/four_image_48_48/four_image_48_48.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/two_image_48_48/two_image_48_48.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/two_image_48_48/two_image_48_48.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/six_image_48_48/six_image_48_48.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/six_image_48_48/six_image_48_48.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/five_image_48_48/five_image_48_48.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/five_image_48_48/five_image_48_48.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/nine_image_48_48/nine_image_48_48.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/nine_image_48_48/nine_image_48_48.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/one_image_48_48/one_image_48_48.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/one_image_48_48/one_image_48_48.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/seven_image_48_48/seven_image_48_48.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/seven_image_48_48/seven_image_48_48.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/three_image_48_48/three_image_48_48.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/three_image_48_48/three_image_48_48.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/victor/victor.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/victor/victor.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/yeung/yeung.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/yeung/yeung.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/driss/driss.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/driss/driss.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/aaron/aaron.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/aaron/aaron.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/melinda/melinda.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/melinda/melinda.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/mike/mike.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/mike/mike.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/diana/diana.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/diana/diana.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/gim/gim.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/gim/gim.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/joe/joe.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/joe/joe.dcp]
  read_xdc -mode out_of_context -ref frame_buffer -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/frame_buffer/frame_buffer_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/frame_buffer/frame_buffer_ooc.xdc]
  read_xdc -mode out_of_context -ref video_clk -cells inst /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/video_clk/video_clk_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/video_clk/video_clk_ooc.xdc]
  read_xdc -prop_thru_buffers -ref video_clk -cells inst /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/video_clk/video_clk_board.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/video_clk/video_clk_board.xdc]
  read_xdc -ref video_clk -cells inst /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/video_clk/video_clk.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/video_clk/video_clk.xdc]
  read_xdc -mode out_of_context -ref rescaled_frame_buffer -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/rescaled_frame_buffer/rescaled_frame_buffer_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/rescaled_frame_buffer/rescaled_frame_buffer_ooc.xdc]
  read_xdc -mode out_of_context -ref one_16_d -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/one_16_d/one_16_d_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/one_16_d/one_16_d_ooc.xdc]
  read_xdc -mode out_of_context -ref nine_16_d -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/nine_16_d/nine_16_d_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/nine_16_d/nine_16_d_ooc.xdc]
  read_xdc -mode out_of_context -ref five_16_d -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/five_16_d/five_16_d_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/five_16_d/five_16_d_ooc.xdc]
  read_xdc -mode out_of_context -ref six_16_d -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/six_16_d/six_16_d_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/six_16_d/six_16_d_ooc.xdc]
  read_xdc -mode out_of_context -ref four_16_d -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/four_16_d/four_16_d_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/four_16_d/four_16_d_ooc.xdc]
  read_xdc -mode out_of_context -ref seven_16_d -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/seven_16_d/seven_16_d_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/seven_16_d/seven_16_d_ooc.xdc]
  read_xdc -mode out_of_context -ref two_16_d -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/two_16_d/two_16_d_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/two_16_d/two_16_d_ooc.xdc]
  read_xdc -mode out_of_context -ref eight_16_d -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/eight_16_d/eight_16_d_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/eight_16_d/eight_16_d_ooc.xdc]
  read_xdc -mode out_of_context -ref three_16_d -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/three_16_d_1/three_16_d_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/three_16_d_1/three_16_d_ooc.xdc]
  read_xdc -mode out_of_context -ref eight_image_48_48 -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/eight_image_48_48/eight_image_48_48_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/eight_image_48_48/eight_image_48_48_ooc.xdc]
  read_xdc -mode out_of_context -ref four_image_48_48 -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/four_image_48_48/four_image_48_48_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/four_image_48_48/four_image_48_48_ooc.xdc]
  read_xdc -mode out_of_context -ref two_image_48_48 -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/two_image_48_48/two_image_48_48_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/two_image_48_48/two_image_48_48_ooc.xdc]
  read_xdc -mode out_of_context -ref six_image_48_48 -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/six_image_48_48/six_image_48_48_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/six_image_48_48/six_image_48_48_ooc.xdc]
  read_xdc -mode out_of_context -ref five_image_48_48 -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/five_image_48_48/five_image_48_48_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/five_image_48_48/five_image_48_48_ooc.xdc]
  read_xdc -mode out_of_context -ref nine_image_48_48 -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/nine_image_48_48/nine_image_48_48_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/nine_image_48_48/nine_image_48_48_ooc.xdc]
  read_xdc -mode out_of_context -ref one_image_48_48 -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/one_image_48_48/one_image_48_48_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/one_image_48_48/one_image_48_48_ooc.xdc]
  read_xdc -mode out_of_context -ref seven_image_48_48 -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/seven_image_48_48/seven_image_48_48_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/seven_image_48_48/seven_image_48_48_ooc.xdc]
  read_xdc -mode out_of_context -ref three_image_48_48 -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/three_image_48_48/three_image_48_48_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/three_image_48_48/three_image_48_48_ooc.xdc]
  read_xdc -mode out_of_context -ref victor -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/victor/victor_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/victor/victor_ooc.xdc]
  read_xdc -mode out_of_context -ref yeung -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/yeung/yeung_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/yeung/yeung_ooc.xdc]
  read_xdc -mode out_of_context -ref driss -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/driss/driss_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/driss/driss_ooc.xdc]
  read_xdc -mode out_of_context -ref aaron -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/aaron/aaron_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/aaron/aaron_ooc.xdc]
  read_xdc -mode out_of_context -ref melinda -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/melinda/melinda_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/melinda/melinda_ooc.xdc]
  read_xdc -mode out_of_context -ref mike -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/mike/mike_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/mike/mike_ooc.xdc]
  read_xdc -mode out_of_context -ref diana -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/diana/diana_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/diana/diana_ooc.xdc]
  read_xdc -mode out_of_context -ref gim -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/gim/gim_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/gim/gim_ooc.xdc]
  read_xdc -mode out_of_context -ref joe -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/joe/joe_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/sources_1/ip/joe/joe_ooc.xdc]
  read_xdc /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.srcs/constrs_1/imports/Downloads/Nexys4DDR_Master.xdc
  link_design -top top -part xc7a100tcsg324-1
  write_hwdef -file top.hwdef
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force top_opt.dcp
  report_drc -file top_drc_opted.rpt
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design 
  write_checkpoint -force top_placed.dcp
  report_io -file top_io_placed.rpt
  report_utilization -file top_utilization_placed.rpt -pb top_utilization_placed.pb
  report_control_sets -verbose -file top_control_sets_placed.rpt
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force top_routed.dcp
  report_drc -file top_drc_routed.rpt -pb top_drc_routed.pb
  report_timing_summary -warn_on_violation -max_paths 10 -file top_timing_summary_routed.rpt -rpx top_timing_summary_routed.rpx
  report_power -file top_power_routed.rpt -pb top_power_summary_routed.pb -rpx top_power_routed.rpx
  report_route_status -file top_route_status.rpt -pb top_route_status.pb
  report_clock_utilization -file top_clock_utilization_routed.rpt
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  catch { write_mem_info -force top.mmi }
  write_bitstream -force top.bit -bin_file
  catch { write_sysdef -hwdef top.hwdef -bitfile top.bit -meminfo top.mmi -file top.sysdef }
  catch {write_debug_probes -quiet -force debug_nets}
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

