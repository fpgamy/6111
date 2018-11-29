# 
# Synthesis run script generated by Vivado
# 

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.cache/wt [current_project]
set_property parent.project_path /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
read_ip -quiet /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/two_image_48_48/two_image_48_48.xci
set_property is_locked true [get_files /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/two_image_48_48/two_image_48_48.xci]

foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

synth_design -top two_image_48_48 -part xc7a100tcsg324-1 -mode out_of_context

rename_ref -prefix_all two_image_48_48_

write_checkpoint -force -noxdef two_image_48_48.dcp

catch { report_utilization -file two_image_48_48_utilization_synth.rpt -pb two_image_48_48_utilization_synth.pb }

if { [catch {
  file copy -force /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/sudoku/sudoku.runs/two_image_48_48_synth_1/two_image_48_48.dcp /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/two_image_48_48/two_image_48_48.dcp
} _RESULT ] } { 
  send_msg_id runtcl-3 error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
  error "ERROR: Unable to successfully create or copy the sub-design checkpoint file."
}

if { [catch {
  write_verilog -force -mode synth_stub /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/two_image_48_48/two_image_48_48_stub.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a Verilog synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode synth_stub /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/two_image_48_48/two_image_48_48_stub.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create a VHDL synthesis stub for the sub-design. This may lead to errors in top level synthesis of the design. Error reported: $_RESULT"
}

if { [catch {
  write_verilog -force -mode funcsim /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/two_image_48_48/two_image_48_48_sim_netlist.v
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the Verilog functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if { [catch {
  write_vhdl -force -mode funcsim /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/two_image_48_48/two_image_48_48_sim_netlist.vhdl
} _RESULT ] } { 
  puts "CRITICAL WARNING: Unable to successfully create the VHDL functional simulation sub-design file. Post-Synthesis Functional Simulation with this file may not be possible or may give incorrect results. Error reported: $_RESULT"
}

if {[file isdir /afs/athena.mit.edu/user/s/h/shreeyam/Downloads/camera_simple_frame_buffer_2/camera_simple_frame_buffer.ip_user_files/ip/two_image_48_48]} {
  catch { 
    file copy -force /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/two_image_48_48/two_image_48_48_stub.v /afs/athena.mit.edu/user/s/h/shreeyam/Downloads/camera_simple_frame_buffer_2/camera_simple_frame_buffer.ip_user_files/ip/two_image_48_48
  }
}

if {[file isdir /afs/athena.mit.edu/user/s/h/shreeyam/Downloads/camera_simple_frame_buffer_2/camera_simple_frame_buffer.ip_user_files/ip/two_image_48_48]} {
  catch { 
    file copy -force /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/6111/6111work/Project/baseline_test/baseline_test/baseline_test.srcs/sources_1/ip/two_image_48_48/two_image_48_48_stub.vhdl /afs/athena.mit.edu/user/s/h/shreeyam/Downloads/camera_simple_frame_buffer_2/camera_simple_frame_buffer.ip_user_files/ip/two_image_48_48
  }
}
