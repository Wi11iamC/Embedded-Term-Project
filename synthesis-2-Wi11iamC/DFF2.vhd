library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DFF2 is
Port ( 
        clk, reset, CE : in std_logic;
        D1 : in std_logic;
        F2 : out std_logic
);
end DFF2;

architecture BDFF2 of DFF2 is

begin

process (clk)
begin
   if clk'event and clk='1' then
      if reset='1' then
         F2 <= '0';
      elsif CE ='1' then
         F2 <= D1;
      end if;
   end if;
end process;



end BDFF2;