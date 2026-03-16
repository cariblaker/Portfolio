onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label CLK /testbench_BUTTON_IP/clk
add wave -divider Control
add wave -noupdate -label Address -radix hexadecimal /testbench_BUTTON_IP/address
add wave -noupdate -label "Chip Select" testbench_BUTTON_IP/chipselect
add wave -noupdate -label Reset /testbench_BUTTON_IP/reset_n
add wave -noupdate -label Write /testbench_BUTTON_IP/write
add wave -divider Data
add wave -noupdate -label "Write Data" -radix hexadecimal /testbench_BUTTON_IP/writedata
add wave -noupdate -label "Button IN" -radix hexadecimal /testbench_BUTTON_IP/button_in
add wave -divider Output
add wave -noupdate -label "Read Data" -radix hexadecimal /testbench_BUTTON_IP/readdata
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {20000 ps} 0}
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
WaveRestoreZoom {0 ns} {700 ns}