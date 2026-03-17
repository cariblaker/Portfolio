onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label CLK /button_lock_tb/clk
add wave -noupdate -label RST /button_lock_tb/rst
add wave -noupdate -label BUTTON /button_lock_tb/button
add wave -noupdate -divider Internal Signals
add wave -noupdate -label STATE /button_lock_tb/T1/state
add wave -noupdate -divider OUTPUTS
add wave -noupdate -label SIGNAL /button_lock_tb/signal


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
