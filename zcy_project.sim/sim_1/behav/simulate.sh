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
ExecStep $xv_path/bin/xsim top_test_behav -key {Behavioral:sim_1:Functional:top_test} -tclbatch top_test.tcl -log simulate.log
