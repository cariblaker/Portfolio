onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -label CLK /UART_rx_tb/clk
add wave -noupdate -label RST /UART_rx_tb/rst
add wave -noupdate -label IN /UART_rx_tb/in
add wave -noupdate -divider Internal Signals
add wave -noupdate -label FLAG /UART_rx_tb/T1/flag
add wave -noupdate -label DATA_OUT /UART_rx_tb/T1/data_out
add wave -noupdate -label STATE /UART_rx_tb/T1/state
add wave -noupdate -label COUNT /UART_rx_tb/T1/count
add wave -noupdate -label CLK_CNT /UART_rx_tb/T1/clk_cnt
add wave -noupdate -divider OUTPUTS
add wave -noupdate -label OUT /UART_rx_tb/out
add wave -noupdate -label FLAG_OUT /UART_rx_tb/flag_out
add wave -noupdate -label ERROR /UART_rx_tb/error
add wave -noupdate -label READY /UART_rx_tb/ready


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
