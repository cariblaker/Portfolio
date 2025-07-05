
quit -sim

vlib work;

vlog ../../*.v

vlog *.v

vsim work.BCD_ones_tb -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivem_ver -L rtl_work -L work -voptargs="+acc"

do wave_BCD_ones.do

run 1000 ns 