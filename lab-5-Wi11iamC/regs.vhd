-- library declarations
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity regs is 
    port(
        clk, en, rst : in std_logic;
        id1, id2 : in std_logic_vector(4 downto 0);
        wr_en1, wr_en2 : in std_logic;
        din1, din2 : in std_logic_vector(15 downto 0);
        dout1, dout2 : out std_logic_vector(15 downto 0)
    );
end regs;

architecture regs of regs is
    type reg_array is array (31 downto 0) of std_logic_vector(15 downto 0);
    signal registers : reg_array := (others => (others => '0'));
begin

    dout1 <= registers(to_integer(unsigned(id1)));
    dout2 <= registers(to_integer(unsigned(id2)));

    process (clk)
    begin

        if rising_edge(clk) then
            -- zero reg
            registers(0) <= (others => '0');

            -- rst
            if      (rst = '1') then
                registers <= (others => (others => '0'));
            
            -- en
            elsif (en = '1')  then

                -- write register 1
                if wr_en1 = '1' then
                    registers(to_integer(unsigned(id1))) <= din1;
                end if;
                
                -- write register 2
                if wr_en2 = '1' then
                    registers(to_integer(unsigned(id2))) <= din2;
                end if;

            end if;

        end if;

    end process;

end regs;