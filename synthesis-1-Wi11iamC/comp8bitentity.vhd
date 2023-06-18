library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity comp8bitentity is
    Port (
        clk : in std_logic;
        D2, D3 : in std_logic_vector(7 downto 0);
        F1 : out std_logic
    );
end comp8bitentity;

architecture comp8bit of comp8bitentity is
begin

    process(clk)
    begin
        if (clk'event and clk ='1') then
            if ( D2 = D3 ) then
                F1 <= '1';
            else
                F1 <= '0';
            end if;
        end if;
    end process;

end comp8bit;