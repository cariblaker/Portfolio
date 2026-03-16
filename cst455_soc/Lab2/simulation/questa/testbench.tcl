quit -sim

vlib work;

vlog ../../*.vhd

vlog *.vhd

vsim work.testbench -L altera_ver -L lpm_ver -L sgate_ver -L alera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work-ver -L work -voptargs="+acc"

do wave.do

run 2750 ns