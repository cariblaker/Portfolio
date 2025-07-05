transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/carib/CST133/lab5 {C:/Users/carib/CST133/lab5/dlatch_BH.v}
vlog -vlog01compat -work work +incdir+C:/Users/carib/CST133/lab5 {C:/Users/carib/CST133/lab5/dff_pos_BH.v}
vlog -vlog01compat -work work +incdir+C:/Users/carib/CST133/lab5 {C:/Users/carib/CST133/lab5/dff_neg_BH.v}
vlog -vlog01compat -work work +incdir+C:/Users/carib/CST133/lab5 {C:/Users/carib/CST133/lab5/dstorage.v}

