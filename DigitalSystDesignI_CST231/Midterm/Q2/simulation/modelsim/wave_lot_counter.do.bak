onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label CLK /BCD_ones_tb/clk
add wave -noupdate -label RST /BCD_ones_tb/rst
add wave -noupdate -label INC /BCD_ones_tb/inc
add wave -noupdate -label DEC /BCD_ones_tb/dec
add wave -noupdate -divider OUTPUTS
add wave -nopudate -label count /BCD_ones_tb/count
add wave -noupdate -label UP /BCD_ones_tb/up
add wave -noupdate -label DOWN /BCD_ones_tb/down

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
