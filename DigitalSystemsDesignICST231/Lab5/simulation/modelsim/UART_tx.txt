onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label CLK /UART_tx_tb/clk
add wave -noupdate -label RST /UART_tx_tb/rst
add wave -noupdate -label CNTRL /UART_tx_tb/cntrl
add wave -noupdate -label DATA_OUT /UART_tx_tb/T1/data
add wave -noupdate -divider InternalSignals
add wave -noupdate -label STATE /UART_tx_tb/T1/state
add wave -noupdate -label COUNT /UART_tx_tb/T1/count
add wave -noupdate -label DATA_IN /UART_tx_tb/T1/data_in
add wave -noupdate -divider OUTPUTS
add wave -noupdate -label OUT /UART_tx_tb/out
add wave -noupdate -label READY /UART_tx_tb/ready


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
