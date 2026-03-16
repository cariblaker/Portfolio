
module Midterm (
	clk_clk,
	hex0_segs,
	hex1_segs,
	hex2_segs,
	hex3_segs,
	hex4_segs,
	hex5_segs,
	leds_leds,
	sdram_clk_clk,
	sdram_wire_addr,
	sdram_wire_ba,
	sdram_wire_cas_n,
	sdram_wire_cke,
	sdram_wire_cs_n,
	sdram_wire_dq,
	sdram_wire_dqm,
	sdram_wire_ras_n,
	sdram_wire_we_n,
	switches_switches,
	buttons_buttons);	

	input		clk_clk;
	output	[6:0]	hex0_segs;
	output	[6:0]	hex1_segs;
	output	[6:0]	hex2_segs;
	output	[6:0]	hex3_segs;
	output	[6:0]	hex4_segs;
	output	[6:0]	hex5_segs;
	output	[9:0]	leds_leds;
	output		sdram_clk_clk;
	output	[12:0]	sdram_wire_addr;
	output	[1:0]	sdram_wire_ba;
	output		sdram_wire_cas_n;
	output		sdram_wire_cke;
	output		sdram_wire_cs_n;
	inout	[15:0]	sdram_wire_dq;
	output	[1:0]	sdram_wire_dqm;
	output		sdram_wire_ras_n;
	output		sdram_wire_we_n;
	input	[9:0]	switches_switches;
	input	[3:0]	buttons_buttons;
endmodule
