transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/carib/CST\ 231/Lab5 {C:/Users/carib/CST 231/Lab5/UART_tx.v}

