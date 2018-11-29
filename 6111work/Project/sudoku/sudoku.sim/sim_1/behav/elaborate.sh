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
ExecStep $xv_path/bin/xelab -wto 7fe53f79ee1a487ea60aea4dce032fb8 -m64 --debug typical --relax --mt 8 -L xil_defaultlib -L xpm -L blk_mem_gen_v8_3_3 -L unisims_ver -L unimacro_ver -L secureip --snapshot char_rec_tb_behav xil_defaultlib.char_rec_tb xil_defaultlib.glbl -log elaborate.log
