-- library declaration
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- entity
entity vga_ctrl_tb is
end vga_ctrl_tb;

architecture testbench of vga_ctrl_tb is 
    -- components
    component vga_ctrl
        port(
            clk, en : in std_logic;
            hcount, vcount : out std_logic_vector(9 downto 0);
            vid, hs, vs : out std_logic
        );
    end component;

    -- intermedite signals
    signal tb_clk, tb_en : std_logic;
    signal tb_hcnt, tb_vcnt : std_logic_vector(9 downto 0);
    signal tb_vid, tb_hs, tb_vs : std_logic;

begin
    -- port mapping
    u1 : vga_ctrl
    port map(
        clk => tb_clk,
        en => tb_en,
        hcount => tb_hcnt,
        vcount => tb_vcnt, 
        vid => tb_vid,
        hs => tb_hs,
        vs => tb_vs
    );

    -- 125 MHz clock
    process begin
        tb_clk <= '0';
        wait for 4 ns;
        tb_clk <= '1';
        wait for 4 ns;
    end process;
    
    -- 25 MHz enable
    process begin
        tb_en <= '0';
        wait for 36 ns;
        tb_en <= '1';
        wait for 4 ns;
    end process;

    -- main
    process begin
        wait for 100000 ns;
        report "End" severity FAILURE;
    end process;

end testbench;