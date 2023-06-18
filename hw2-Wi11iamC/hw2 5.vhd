-- library declaration
library ieee;
use ieee.std_logic_1164.all;

entity mux8t1 is
    PORT(
        D7, D6, D5, D4, D3, D2, D1, D0 : std_logic;
        sel : in std_logic_vector(2 DOWNTO 0); 
        mux_out : out std_logic);
END mux8t1;

-- architecture 
architecture conditional_mux8t1 of mux8t1_ is
    begin
        mux_out <= D7 when (sel = "111") else
                   D6 when (sel = "110") else 
                   D5 when (sel = "101") else
                   D4 when (sel = "100") else
                   D3 when (sel = "011") else
                   D2 when (sel = "010") else
                   D1 when (sel = "001") else
                   D0 when (sel = "000") else
                   '0';
end conditional_mux8t1;

-- architecture 
architecture select_mux8t1 of mux8t1_ is
    begin
        with sel select
        mux_out <= D7 when  "111",
                   D6 when "110",
                   D5 when "101",
                   D4 when "100",
                   D3 when "011",
                   D2 when "010",
                   D1 when "001",
                   D0 when "000",
                   '0' when others;
end select_mux8t1;

