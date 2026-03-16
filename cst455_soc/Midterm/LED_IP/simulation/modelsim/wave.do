onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label CLK /testbench_LED_IP/clk

add wave -noupdate -divider Control
add wave -noupdate -label Address -radix hexadecimal /testbench_LED_IP/address
add wave -noupdate -label "Chip Select" /testbench_LED_IP/chipselect
add wave -noupdate -label Reset /testbench_LED_IP/reset_n
add wave -noupdate -label Read /testbench_LED_IP/read
add wave -noupdate -label Write /testbench_LED_IP/write
add wave -nopudate -divider Data
add wave -noupdate -label "Write Data" -radix hexadecimal /testbench_LED_IP/writedata
add wave -noupdate -label "Read Data" -radix hexadecimal /testbench_LED_IP/readdata
add wave -nopudate -divider Output
add wave -noupdate -label LEDs /testbench/led_out
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
WaveRestoreZoom {0 ns} {350 ns}