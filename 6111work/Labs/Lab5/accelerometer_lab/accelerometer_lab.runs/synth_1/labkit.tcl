# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a100tcsg324-3

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir /afs/athena.mit.edu/user/m/a/magson/Documents/6111/6111work/Labs/Lab5/accelerometer_lab/accelerometer_lab.cache/wt [current_project]
set_property parent.project_path /afs/athena.mit.edu/user/m/a/magson/Documents/6111/6111work/Labs/Lab5/accelerometer_lab/accelerometer_lab.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
read_verilog -library xil_defaultlib /afs/athena.mit.edu/user/m/a/magson/Documents/6111/6111work/Labs/Lab5/accelerometer_lab/accelerometer_lab.srcs/sources_1/new/labkit.v
read_vhdl -library xil_defaultlib {
  /afs/athena.mit.edu/user/m/a/magson/Documents/6111/6111work/Labs/Lab5/accelerometer_lab/accelerometer_lab.srcs/sources_1/imports/sources/SPI_If.vhd
  /afs/athena.mit.edu/user/m/a/magson/Documents/6111/6111work/Labs/Lab5/accelerometer_lab/accelerometer_lab.srcs/sources_1/imports/sources/ADXL362Ctrl.vhd
}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc /afs/athena.mit.edu/user/m/a/magson/Documents/6111/6111work/Labs/Lab5/accelerometer_lab/accelerometer_lab.srcs/constrs_1/imports/sources/Nexys4DDR_Master_lab4.xdc
set_property used_in_implementation false [get_files /afs/athena.mit.edu/user/m/a/magson/Documents/6111/6111work/Labs/Lab5/accelerometer_lab/accelerometer_lab.srcs/constrs_1/imports/sources/Nexys4DDR_Master_lab4.xdc]


synth_design -top labkit -part xc7a100tcsg324-3


write_checkpoint -force -noxdef labkit.dcp

catch { report_utilization -file labkit_utilization_synth.rpt -pb labkit_utilization_synth.pb }
