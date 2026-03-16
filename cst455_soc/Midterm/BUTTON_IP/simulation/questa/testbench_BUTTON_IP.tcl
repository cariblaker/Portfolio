quit -sim

vlib work;

vlog ../../*.v

vlog *.v

vsim work.testbench_BUTTON_IP -L altera_ver -L lpm_ver -L sgate_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L work -voptargs="+acc"

do wave.do

run 700 ns