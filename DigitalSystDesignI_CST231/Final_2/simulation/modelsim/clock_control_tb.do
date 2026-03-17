onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label CLK /clock_control_tb/clk
add wave -noupdate -label RST /clock_control_tb/rst
add wave -noupdate -label SET /clock_control_tb/set
add wave -noupdate -label SET_HOURS /clock_control_tb/set_h
add wave -noupdate -label SET_MINS /clock_control_tb/set_m
add wave -noupdate -divider INTERNALS
add wave -noupdate -label STATE /clock_control_tb/T1/state
add wave -noupdate -divider OUTPUTS
add wave -noupdate -label SETTING /clock_control_tb/setting
add wave -noupdate -label SETTING_HOURS /clock_control_tb/setting_h
add wave -noupdate -label SETTING_MINS /clock_control_tb/setting_m


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
