transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/carib/CST\ 231/Midterm/Q2 {C:/Users/carib/CST 231/Midterm/Q2/sensor_FSM.v}
vlog -vlog01compat -work work +incdir+C:/Users/carib/CST\ 231/Midterm/Q2 {C:/Users/carib/CST 231/Midterm/Q2/BCD_ones.v}
vlog -vlog01compat -work work +incdir+C:/Users/carib/CST\ 231/Midterm/Q2 {C:/Users/carib/CST 231/Midterm/Q2/BCD_tens.v}
vlog -vlog01compat -work work +incdir+C:/Users/carib/CST\ 231/Midterm/Q2 {C:/Users/carib/CST 231/Midterm/Q2/lot_counter.v}
vlog -vlog01compat -work work +incdir+C:/Users/carib/CST\ 231/Midterm/Q2 {C:/Users/carib/CST 231/Midterm/Q2/seg_7.v}

