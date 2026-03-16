------------------------------------------------------------------------
-- File Name: sev_seg_decoder.vhd
-- CST455, Lab2
-- Cari Blaker
-- Created: 10/10/24
-- This file contains the seven segment decoder entity and its architecture.
-- This decoder entity is designed for reusability. Its input is a four-
-- bit unsigned binary number. The entity decodes this number into its corr-
-- esponding hex value for a seven segment display, which is its 7-bit
-- std_logic_vector output: display
-------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  -- to work with unsigned types

entity sev_seg_decoder is
    port (
        input_bin : in  unsigned(3 downto 0);    		-- 4-bit binary input
        display   : out std_logic_vector(6 downto 0)  -- 7-segment display output
    );
end entity sev_seg_decoder;

architecture behavioral of sev_seg_decoder is
begin
    process(input_bin)
    begin
        case input_bin is
            when "0000" => display <= "1000000";  -- 0
            when "0001" => display <= "1111001";  -- 1
            when "0010" => display <= "0100100";  -- 2
            when "0011" => display <= "0110000";  -- 3
            when "0100" => display <= "0011001";  -- 4
            when "0101" => display <= "0010010";  -- 5
            when "0110" => display <= "0000010";  -- 6
            when "0111" => display <= "1111000";  -- 7
            when "1000" => display <= "0000000";  -- 8
            when "1001" => display <= "0010000";  -- 9
            when "1010" => display <= "0001000";  -- A
            when "1011" => display <= "0000011";  -- B
            when "1100" => display <= "1000110";  -- C
            when "1101" => display <= "0100001";  -- D
            when "1110" => display <= "0000110";  -- E
            when "1111" => display <= "0001110";  -- F
            when others => display <= "1111111";  -- All off (default)
        end case;
    end process;
end architecture behavioral;
