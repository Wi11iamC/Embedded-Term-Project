library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity clock_div is
port (
    clk : in std_logic;
    clk_div : out std_logic);
end clock_div;

architecture behavior of clock_div is

signal count : std_logic_vector(25 downto 0) := (others => '0');
signal div : std_logic := '0';

begin

    clk_div <= div;

    process (clk)
    begin
        if rising_edge(clk) then
            if unsigned(count) < 4 then
                count <= std_logic_vector(unsigned(count) + 1);
                div <= '0';
            else
                div <= '1';
                count <= (others => '0');
            end if;
        end if;
    end process;

end behavior;