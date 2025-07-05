transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/carib/CST133/MidtermII_dig_clock {C:/Users/carib/CST133/MidtermII_dig_clock/dig_clock_counter.v}

