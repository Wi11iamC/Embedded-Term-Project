library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Encoderentity is
    Port (
        clk, reset : in std_logic;
        D5 : in std_logic_vector(3 downto 0);
        
        F3 : out std_logic_vector(1 downto 0)
    );
end Encoderentity;

architecture BEncoder of Encoderentity is
begin
process(clk)
begin
   if ( clk'event and clk ='1') then
      if (reset = '1') then
         F3 <= "00";
      else
         case D5 is
            when "0001" => F3 <= "00";
            when "0010" => F3 <= "01";
            when "0100" => F3 <= "10";
            when "1000" => F3 <= "11";
            when others => F3 <= "00";
         end case;
      end if;
   end if;
end process;

end BEncoder;