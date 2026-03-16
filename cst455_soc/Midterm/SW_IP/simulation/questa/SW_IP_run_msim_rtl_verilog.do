transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+/home/cari/cst455_soc/Midterm/SW_IP {/home/cari/cst455_soc/Midterm/SW_IP/SW_IP.v}

