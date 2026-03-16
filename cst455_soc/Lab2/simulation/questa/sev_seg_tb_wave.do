onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label clk
add wave -noupdate -divider Input
add wave -noupdate -label input_bin /sev_seg_decoder_tb/input_bin
add wave -noupdate -divider Output
add wave -noupdate -label display /sev_seg_decoder_tb/display
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {200 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 106
configure wave -valuecolwidth 50
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
WaveRestoreZoom {0 ns} {200 ns}
