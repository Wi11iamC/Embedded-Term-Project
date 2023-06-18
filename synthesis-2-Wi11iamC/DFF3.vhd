library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DFF3 is
Port ( 
        clk, reset : in std_logic;
        D2 : in std_logic;
        F3 : out std_logic
);
end DFF3;

architecture BDFF3 of DFF3 is

begin
process (clk)
begin
   if clk'event and clk='1' then
      if reset='0' then
         F3 <= '0';
      else
         F3 <= D2;
      end if;
   end if;
end process;


end BDFF3;