library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity debounce is
    port(
        clk: in STD_LOGIC;
        btn: in STD_LOGIC;
        dbnc: out STD_LOGIC := '0');
end debounce;

architecture Behavioral of debounce is

    signal previous : std_logic := '0';
    signal count : std_logic_vector(21 downto 0)  := (others => '0');
    signal out_dbnc : std_logic := '0';

    begin
    
    dbnc <= out_dbnc;

    process (clk) begin
        if rising_edge(clk) then
            if btn='1' then
                if unsigned(count) < 2499999 then
                    count <= std_logic_vector(unsigned(count) + 1);
                else
                    out_dbnc <= '1';
                end if;
            else
                previous <= btn;
                count <= (others => '0');
                out_dbnc <= '0';
            end if;
        end if;
    end process;
    
 end Behavioral;