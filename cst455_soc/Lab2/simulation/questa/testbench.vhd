library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  -- To work with unsigned types

entity testbench is
    -- Testbench has no ports
end entity testbench;

architecture behavior of testbench is
    component adder
        port (
            num1      : in  unsigned(3 downto 0);
            num2      : in  unsigned(3 downto 0);
            display1  : out std_logic_vector(6 downto 0);
            display2  : out std_logic_vector(6 downto 0);
            sum1      : out std_logic_vector(6 downto 0);
				sum2		 : out std_logic_vector(6 downto 0)
        );
    end component;

    -- Signals for inputs and outputs
    signal num1      : unsigned(3 downto 0);
    signal num2      : unsigned(3 downto 0);
    signal display1  : std_logic_vector(6 downto 0);
    signal display2  : std_logic_vector(6 downto 0);
    signal sum1      : std_logic_vector(6 downto 0);
	 signal sum2      : std_logic_vector(6 downto 0);
	 
begin
    uut: adder
        port map (
            num1      => num1,
            num2      => num2,
            display1  => display1,
            display2  => display2,
            sum1      => sum1,
				sum2		 => sum2
        );

    -- Test process
    stimulus: process
    begin
        for i in 0 to 15 loop  		-- Loop for num1
            for j in 0 to 15 loop  	-- Loop for num2
                num1 <= to_unsigned(i, 4);
                num2 <= to_unsigned(j, 4);
                wait for 10 ns; 
            end loop;
        end loop;
        wait;
    end process stimulus;

end architecture behavior;
