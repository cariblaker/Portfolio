	component Midterm is
		port (
			clk_clk           : in    std_logic                     := 'X';             -- clk
			hex0_segs         : out   std_logic_vector(6 downto 0);                     -- segs
			hex1_segs         : out   std_logic_vector(6 downto 0);                     -- segs
			hex2_segs         : out   std_logic_vector(6 downto 0);                     -- segs
			hex3_segs         : out   std_logic_vector(6 downto 0);                     -- segs
			hex4_segs         : out   std_logic_vector(6 downto 0);                     -- segs
			hex5_segs         : out   std_logic_vector(6 downto 0);                     -- segs
			leds_leds         : out   std_logic_vector(9 downto 0);                     -- leds
			sdram_clk_clk     : out   std_logic;                                        -- clk
			sdram_wire_addr   : out   std_logic_vector(12 downto 0);                    -- addr
			sdram_wire_ba     : out   std_logic_vector(1 downto 0);                     -- ba
			sdram_wire_cas_n  : out   std_logic;                                        -- cas_n
			sdram_wire_cke    : out   std_logic;                                        -- cke
			sdram_wire_cs_n   : out   std_logic;                                        -- cs_n
			sdram_wire_dq     : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			sdram_wire_dqm    : out   std_logic_vector(1 downto 0);                     -- dqm
			sdram_wire_ras_n  : out   std_logic;                                        -- ras_n
			sdram_wire_we_n   : out   std_logic;                                        -- we_n
			switches_switches : in    std_logic_vector(9 downto 0)  := (others => 'X'); -- switches
			buttons_buttons   : in    std_logic_vector(3 downto 0)  := (others => 'X')  -- buttons
		);
	end component Midterm;

	u0 : component Midterm
		port map (
			clk_clk           => CONNECTED_TO_clk_clk,           --        clk.clk
			hex0_segs         => CONNECTED_TO_hex0_segs,         --       hex0.segs
			hex1_segs         => CONNECTED_TO_hex1_segs,         --       hex1.segs
			hex2_segs         => CONNECTED_TO_hex2_segs,         --       hex2.segs
			hex3_segs         => CONNECTED_TO_hex3_segs,         --       hex3.segs
			hex4_segs         => CONNECTED_TO_hex4_segs,         --       hex4.segs
			hex5_segs         => CONNECTED_TO_hex5_segs,         --       hex5.segs
			leds_leds         => CONNECTED_TO_leds_leds,         --       leds.leds
			sdram_clk_clk     => CONNECTED_TO_sdram_clk_clk,     --  sdram_clk.clk
			sdram_wire_addr   => CONNECTED_TO_sdram_wire_addr,   -- sdram_wire.addr
			sdram_wire_ba     => CONNECTED_TO_sdram_wire_ba,     --           .ba
			sdram_wire_cas_n  => CONNECTED_TO_sdram_wire_cas_n,  --           .cas_n
			sdram_wire_cke    => CONNECTED_TO_sdram_wire_cke,    --           .cke
			sdram_wire_cs_n   => CONNECTED_TO_sdram_wire_cs_n,   --           .cs_n
			sdram_wire_dq     => CONNECTED_TO_sdram_wire_dq,     --           .dq
			sdram_wire_dqm    => CONNECTED_TO_sdram_wire_dqm,    --           .dqm
			sdram_wire_ras_n  => CONNECTED_TO_sdram_wire_ras_n,  --           .ras_n
			sdram_wire_we_n   => CONNECTED_TO_sdram_wire_we_n,   --           .we_n
			switches_switches => CONNECTED_TO_switches_switches, --   switches.switches
			buttons_buttons   => CONNECTED_TO_buttons_buttons    --    buttons.buttons
		);

