library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DFF4 is
Port ( 
        clk, reset, CE : in std_logic;
        D3 : in std_logic;
        F4 : out std_logic
);
end DFF4;

architecture BDFF4 of DFF4 is

begin
process (clk)
begin
   if clk'event and clk='1' then
      if reset='0' then
         F4 <= '0';
      elsif CE ='1' then
         F4 <= D3;
      end if;
   end if;
end process;


end BDFF4;