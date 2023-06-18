-- library declaration
library ieee;
use ieee.std_logic_1164.all; 

-- entity
entity decoder3t8 is
port ( 
    data_in : in std_logic_vector(3 downto 0); 
    out8 : out std_logic_vector(7 downto 0));
 end decoder3t8;

 -- architecture
 architecture conditional_decoder of decoder3t8 is
 begin
        out8 <=
               "10000000" when (data_in = "000") else
               "01000000" when (data_in = "001") else
               "00100000" when (data_in = "010") else
               "00010000" when (data_in = "011") else
               "00001000" when (data_in = "100") else
               "00000100" when (data_in = "101") else
               "00000010" when (data_in = "110") else
               "00000001" when (data_in = "111") else
               "00000000";
 end conditional_decoder;

 -- architecture
 architecture select_decoder of decoder3t8 is
    begin
        with data_in select
           out8 <=
                  "10000000" when "000",
                  "01000000" when "001",
                  "00100000" when "010",
                  "00010000" when "011",
                  "00001000" when "100",
                  "00000100" when "101",
                  "00000010" when "110",
                  "00000001" when "111",
                  "00000000" when others;
end select_decoder;