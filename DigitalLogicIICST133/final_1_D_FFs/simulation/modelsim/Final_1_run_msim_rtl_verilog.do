transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/carib/CST133/final_1_D_FFs {C:/Users/carib/CST133/final_1_D_FFs/D_FF.v}
vlog -vlog01compat -work work +incdir+C:/Users/carib/CST133/final_1_D_FFs {C:/Users/carib/CST133/final_1_D_FFs/Final_1.v}

