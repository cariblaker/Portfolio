transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Ismael/Documents/school/CST\ 231/lab4 {C:/Users/Ismael/Documents/school/CST 231/lab4/code.v}

