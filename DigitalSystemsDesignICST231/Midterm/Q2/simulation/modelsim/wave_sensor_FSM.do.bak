onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /test_ALU/clk
add wave -noupdate /test_ALU/reset
add wave -noupdate /test_ALU/Data
add wave -noupdate /test_ALU/Opcode
add wave -noupdate /test_ALU/GO
add wave -noupdate -divider OUTPUTS
add wave -noupdate /test_ALU/cout
add wave -noupdate /test_ALU/borrow
add wave -noupdate /test_ALU/Result
add wave -noupdate /test_ALU/led_idle
add wave -noupdate /test_ALU/led_wait
add wave -noupdate /test_ALU/led_rdy
add wave -noupdate /test_ALU/led_done
add wave -noupdate /test_ALU/state
add wave -noupdate /test_ALU/A
add wave -noupdate /test_ALU/B
add wave -noupdate /test_ALU/code

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
