transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/carib/CST133/Lab01 {C:/Users/carib/CST133/Lab01/FullAdder.v}

