quit -sim

vlib work;

vlog ../../*.v

vlog *.v

vsim work.sev_seg_decoder_tb -L altera_ver -L lpm_ver -L sgate_ver -L alera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work-ver -L work -voptargs="+acc"

do sev_seg_tb_wave.do

run 200 ns