#!/bin/bash -f
xv_path="/home/wbx/Vivado/Vivado/2016.4"
ExecStep()
{
"$@"
RETVAL=$?
if [ $RETVAL -ne 0 ]
then
exit $RETVAL
fi
}
ExecStep $xv_path/bin/xelab -wto 998d3f3deb4043a8a7c81379036c6b10 -m64 --debug typical --relax --mt 8 -L blk_mem_gen_v8_3_5 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot top_test_behav xil_defaultlib.top_test xil_defaultlib.glbl -log elaborate.log
