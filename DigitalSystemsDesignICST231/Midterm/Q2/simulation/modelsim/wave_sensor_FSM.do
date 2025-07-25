onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label CLK /sensor_FSM_tb/clk
add wave -noupdate -label RST /sensor_FSM_tb/rst
add wave -noupdate -label SENS1 /sensor_FSM_tb/sens1
add wave -noupdate -label SENS2 /sensor_FSM_tb/sens2
add wave -noupdate -divider OUTPUTS
add wave -noupdate -label INC /sensor_FSM_tb/increment
add wave -noupdate -label DEC /sensor_FSM_tb/decrement

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
