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
  create_project -in_memory -part xc7a100tcsg324-1
  set_property board_part digilentinc.com:nexys4_ddr:part0:1.1 [current_project]
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.cache/wt [current_project]
  set_property parent.project_path /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.xpr [current_project]
  set_property ip_repo_paths /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.cache/ip [current_project]
  set_property ip_output_repo /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.cache/ip [current_project]
  set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.runs/synth_1/labkit.dcp
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/one_image_48_48/one_image_48_48.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/one_image_48_48/one_image_48_48.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/two_image_48_48/two_image_48_48.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/two_image_48_48/two_image_48_48.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/three_image_48_48/three_image_48_48.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/three_image_48_48/three_image_48_48.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/four_image_48_48/four_image_48_48.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/four_image_48_48/four_image_48_48.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/five_image_48_48/five_image_48_48.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/five_image_48_48/five_image_48_48.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/six_image_48_48/six_image_48_48.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/six_image_48_48/six_image_48_48.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/seven_image_48_48/seven_image_48_48.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/seven_image_48_48/seven_image_48_48.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/eight_image_48_48/eight_image_48_48.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/eight_image_48_48/eight_image_48_48.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/nine_image_48_48/nine_image_48_48.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/nine_image_48_48/nine_image_48_48.dcp]
  add_files -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.dcp
  set_property netlist_only true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.dcp]
  read_xdc -mode out_of_context -ref one_image_48_48 -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/one_image_48_48/one_image_48_48_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/one_image_48_48/one_image_48_48_ooc.xdc]
  read_xdc -mode out_of_context -ref two_image_48_48 -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/two_image_48_48/two_image_48_48_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/two_image_48_48/two_image_48_48_ooc.xdc]
  read_xdc -mode out_of_context -ref three_image_48_48 -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/three_image_48_48/three_image_48_48_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/three_image_48_48/three_image_48_48_ooc.xdc]
  read_xdc -mode out_of_context -ref four_image_48_48 -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/four_image_48_48/four_image_48_48_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/four_image_48_48/four_image_48_48_ooc.xdc]
  read_xdc -mode out_of_context -ref five_image_48_48 -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/five_image_48_48/five_image_48_48_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/five_image_48_48/five_image_48_48_ooc.xdc]
  read_xdc -mode out_of_context -ref six_image_48_48 -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/six_image_48_48/six_image_48_48_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/six_image_48_48/six_image_48_48_ooc.xdc]
  read_xdc -mode out_of_context -ref seven_image_48_48 -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/seven_image_48_48/seven_image_48_48_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/seven_image_48_48/seven_image_48_48_ooc.xdc]
  read_xdc -mode out_of_context -ref eight_image_48_48 -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/eight_image_48_48/eight_image_48_48_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/eight_image_48_48/eight_image_48_48_ooc.xdc]
  read_xdc -mode out_of_context -ref nine_image_48_48 -cells U0 /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/nine_image_48_48/nine_image_48_48_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/nine_image_48_48/nine_image_48_48_ooc.xdc]
  read_xdc -mode out_of_context -ref clk_wiz_0 -cells inst /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_ooc.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_ooc.xdc]
  read_xdc -prop_thru_buffers -ref clk_wiz_0 -cells inst /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_board.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0_board.xdc]
  read_xdc -ref clk_wiz_0 -cells inst /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc
  set_property processing_order EARLY [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc]
  read_xdc /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/constrs_1/imports/baseline_test/Nexys4DDR_Master_lab5c.xdc
  link_design -top labkit -part xc7a100tcsg324-1
  write_hwdef -file labkit.hwdef
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
  write_checkpoint -force labkit_opt.dcp
  report_drc -file labkit_drc_opted.rpt
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
  write_checkpoint -force labkit_placed.dcp
  report_io -file labkit_io_placed.rpt
  report_utilization -file labkit_utilization_placed.rpt -pb labkit_utilization_placed.pb
  report_control_sets -verbose -file labkit_control_sets_placed.rpt
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
  write_checkpoint -force labkit_routed.dcp
  report_drc -file labkit_drc_routed.rpt -pb labkit_drc_routed.pb
  report_timing_summary -warn_on_violation -max_paths 10 -file labkit_timing_summary_routed.rpt -rpx labkit_timing_summary_routed.rpx
  report_power -file labkit_power_routed.rpt -pb labkit_power_summary_routed.pb -rpx labkit_power_routed.rpx
  report_route_status -file labkit_route_status.rpt -pb labkit_route_status.pb
  report_clock_utilization -file labkit_clock_utilization_routed.rpt
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
  catch { write_mem_info -force labkit.mmi }
  write_bitstream -force labkit.bit 
  catch { write_sysdef -hwdef labkit.hwdef -bitfile labkit.bit -meminfo labkit.mmi -file labkit.sysdef }
  catch {write_debug_probes -quiet -force debug_nets}
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

