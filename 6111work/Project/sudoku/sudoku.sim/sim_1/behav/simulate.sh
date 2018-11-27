#!/bin/bash -f
xv_path="/var/local/xilinx-local/Vivado/2016.2"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xsim frame_parser_tb_behav -key {Behavioral:sim_1:Functional:frame_parser_tb} -tclbatch frame_parser_tb.tcl -view /afs/athena.mit.edu/user/s/h/shreeyam/Documents/6.111/sudoku/reset_tb_behav.wcfg -log simulate.log
