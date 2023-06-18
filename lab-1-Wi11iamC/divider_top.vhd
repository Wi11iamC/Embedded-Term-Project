----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/23/2023 04:00:44 PM
-- Design Name: 
-- Module Name: divider_top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity divider_top is
  Port (
  clk : in std_logic;
  led0 : out std_logic
   );
end divider_top;

architecture Behavioral of divider_top is

component clock_div is
    port(
        clk: in std_logic;
        div : out std_logic
   );
end component clock_div;
signal out_clock_div_ce : std_logic;
signal out1 : std_logic := '0';

begin

process (clk)
begin
   if clk'event and clk='1' then
         if out_clock_div_ce = '1' then
         out1 <= not out1;
         end if;
   end if;
end process;

    U1: clock_div port map (
        clk     => clk,
        div    => out_clock_div_ce);

         led0 <= out1;

end Behavioral;
