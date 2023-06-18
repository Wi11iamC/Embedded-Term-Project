library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Decoderentity is
    Port (
        clk, reset : in std_logic;
        D4 : in std_logic_vector(1 downto 0);
        
        F2 : out std_logic_vector(3 downto 0)
    );
end Decoderentity;

architecture BDecoder of Decoderentity is
begin
process(clk)
begin
   if ( clk'event and clk ='1') then
      if ( reset = '1') then
         F2 <= "0000";
      else
         case D4 is
            when "00" => F2 <= "0001";
            when "01" => F2 <= "0010";
            when "10" => F2 <= "0100";
            when "11" => F2 <= "1000";
            when others => F2 <= "0000";
         end case;
      end if;
   end if;
end process;

end BDecoder;