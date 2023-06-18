----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/10/2023 06:43:16 PM
-- Design Name: 
-- Module Name: main - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DFF1 is
Port ( 
        clk, reset : in std_logic;
        D0 : in std_logic;
        F1 : out std_logic
);
end DFF1;

architecture BDFF1 of DFF1 is

begin
process (clk)
begin
   if clk'event and clk='1' then
      if reset='1' then
         F1 <= '0';
      else
         F1 <= D0;
      end if;
   end if;
end process;



end BDFF1;


