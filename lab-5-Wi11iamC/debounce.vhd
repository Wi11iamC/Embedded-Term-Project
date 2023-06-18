-- library declarations
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity debounce is 
    port(
        btn : in std_logic;
        clk : in std_logic;
        dbnc : out std_logic
    );
end debounce;

architecture debounce of debounce is

    constant MAX_COUNT : integer := 2500000; 
    
    -- signals
    signal SHIFT_REGISTER : std_logic_vector(2 downto 0) := (others => '0');
    signal COUNTER : std_logic_vector(21 downto 0) := (others => '0');

begin
    process(clk)
    begin
        if rising_edge(clk) then

            SHIFT_REGISTER(1) <= SHIFT_REGISTER(0);
            SHIFT_REGISTER(0) <= btn;

            if SHIFT_REGISTER(1) = '1' then
                if unsigned(COUNTER) = MAX_COUNT-1 then
                    dbnc <= '1';
                else
                    COUNTER <= std_logic_vector(unsigned(COUNTER) + 1);
                    dbnc <= '0';
                end if;
            else
                COUNTER <= (others => '0');
                dbnc <= '0';
            end if;
                
        end if;
    end process;
end debounce;