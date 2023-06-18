-- library declarations
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity vga_ctrl is 
    port(
        clk, en : in std_logic;
        hcount, vcount : out std_logic_vector(9 downto 0);
        vid, hs, vs : out std_logic
    );
end vga_ctrl;


architecture vga_ctrl of vga_ctrl is
    -- signals
    signal h_count, v_count : unsigned(9 downto 0) := (others => '0');
begin

    hcount <= std_logic_vector(h_count);
    vcount <= std_logic_vector(v_count);

    process(clk)
    begin
        if rising_edge(clk) then
            if en = '1' then
                
                -- horizontal counter
                if (h_count < 799) then
                    h_count <= h_count + 1;
                else
                    h_count <= (others => '0');
                    
                    -- vertical counter
                    if (v_count < 524) then
                        v_count <= v_count + 1;
                    else
                        v_count <= (others => '0');
                    end if;

                end if;

            end if;
        end if;
    end process;
    
    process(h_count, v_count) 
    begin
        -- vid
        if (h_count <= 639) and (v_count <= 479) then 
            vid <= '1';
        else
            vid <= '0';
        end if;

        -- hs 
        if (h_count >= 656) and (h_count <= 751) then
            hs <= '0';
        else
            hs <= '1';
        end if;

        -- vs
        if (v_count >= 490) and (v_count <= 491) then
            vs <= '0';
        else
            vs <= '1';
        end if;
    end process;

end vga_ctrl;