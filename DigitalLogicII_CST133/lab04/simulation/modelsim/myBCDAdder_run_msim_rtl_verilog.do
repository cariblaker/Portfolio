transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/carib/CST133/lab04 {C:/Users/carib/CST133/lab04/myBCDAdder.v}
vlog -vlog01compat -work work +incdir+C:/Users/carib/CST133/lab04 {C:/Users/carib/CST133/lab04/Lab4.v}
vlog -vlog01compat -work work +incdir+C:/Users/carib/CST133/lab04 {C:/Users/carib/CST133/lab04/myBCDto7Seg.v}

