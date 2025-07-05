onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label CLK /main_FSM_tb/clk
add wave -noupdate -label RST /main_FSM_tb/rst
add wave -noupdate -label B3 /main_FSM_tb/b3
add wave -noupdate -label B2 /main_FSM_tb/b2
add wave -noupdate -label B1 /main_FSM_tb/b1
add wave -noupdate -label B0 /main_FSM_tb/b0
add wave -noupdate -label LEFT_IN /main_FSM_tb/left_in
add wave -noupdate -label RIGHT_IN /main_FSM_tb/right_in
add wave -noupdate -label HAZ_IN /main_FSM_tb/haz_in
add wave -noupdate -divider Internal Signals
add wave -noupdate -label STATE /main_FSM_tb/T1/state
add wave -noupdate -divider OUTPUTS
add wave -noupdate -label L /main_FSM_tb/L
add wave -noupdate -label H /main_FSM_tb/H
add wave -noupdate -label R /main_FSM_tb/R
add wave -noupdate -label LEDS /main_FSM_tb/lights


TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {300 ns}
