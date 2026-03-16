------------------------------------------------------------------------
-- File Name: adder.vhd
-- CST455, Lab2
-- Cari Blaker
-- Created: 10/10/24
-- This file contains the top level adder entity and its architecture.
-- The adder takes in two four-bit binary inputs, decodes them for
-- seven-segment display (and outputs those two decoded numbers),
-- adds those two numbers (after concatenating zeroes for compatibility
-- and to account for "carry"), and decodes their sum for display on
-- two seven segment displays
-------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  -- To work with unsigned types

entity adder is
    port (
        num1      : in  unsigned(3 downto 0);  			 -- 4-bit binary input from switches
        num2      : in  unsigned(3 downto 0);  			 -- 4-bit binary input from switches
        display1  : out std_logic_vector(6 downto 0);  -- 7-segment display output for num2
        display2  : out std_logic_vector(6 downto 0);  -- 7-segment display output for num1
        sum1      : out std_logic_vector(6 downto 0);  -- 7-segment display output for MSD of sum
		  sum2		: out std_logic_vector(6 downto 0)	 -- 7-segment display output for LSD of sum
    );
end entity adder;

architecture behavioral of adder is
    -- Signal for the 5-bit sum (to accommodate the carry)
    signal temp_sum : unsigned(4 downto 0);
    
    component sev_seg_decoder
        port (
            input_bin : in  unsigned(3 downto 0);    		 -- 4-bit binary input
            display   : out std_logic_vector(6 downto 0)  -- 7-segment display output
        );
    end component;

    signal sum_low  : unsigned(3 downto 0);
    signal sum_high : unsigned(3 downto 0);

begin
    -- add the two 4-bit numbers, concatenate them to be 5 bits for addition and store the 5-bit sum in temp_sum
    temp_sum <= ('0' & num1) + ('0' & num2);

    -- Break the sum into high and low nibbles for separate 7-segment display
    sum_low  <= temp_sum(3 downto 0);  							-- Lower 4 bits of the sum
    sum_high <= "0000" when temp_sum(4) = '0' else "0001";  -- handle the carry as the high nibble (0 or 1)

	 -- decode num1
    sev_seg_decoder_num1 : sev_seg_decoder
        port map (
            input_bin => num1,
            display   => display1
        );
    
    -- decode num2
    sev_seg_decoder_num2 : sev_seg_decoder
        port map (
            input_bin => num2,
            display   => display2
        );
    
    -- decode LSD of sum
    sev_seg_decoder_sum_low : sev_seg_decoder
        port map (
            input_bin => sum_low,
            display   => sum2(6 downto 0)  -- Lower 7-segment display
        );
    
    -- decode MSD digit of sum
    sev_seg_decoder_sum_high : sev_seg_decoder
        port map (
            input_bin => sum_high,
            display   => sum1(6 downto 0)  -- Higher 7-segment display
        );

end architecture behavioral;
