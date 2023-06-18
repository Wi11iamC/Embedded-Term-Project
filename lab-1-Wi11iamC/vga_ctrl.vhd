library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga_ctrl is
    port (
        clk         : in  std_logic;
        en     : in  std_logic;
        hcount      : out std_logic_vector(63 downto 0);
        vcount      : out std_logic_vector(63 downto 0);
        vid         : out std_logic;
        hs          : out std_logic;
        vs          : out std_logic
    );
end entity;

architecture rtl of vga_ctrl is

    -- Constants
    constant H_MAX      : integer := 799;
    constant V_MAX      : integer := 524;
    constant H_ACTIVE   : integer := 639;
    constant V_ACTIVE   : integer := 479;
    constant H_BLANK    : integer := 752;
    constant V_BLANK    : integer := 493;

    -- Signals
    signal h_count_sig      : unsigned(63 downto 0) := (others => '0');
    signal v_count_sig      : unsigned(63 downto 0) := (others => '0');
    signal h_sync       : std_logic := '1';
    signal v_sync       : std_logic := '1';
    signal video_on     : std_logic := '1';

begin

    -- Synchronous Process for Counters
    count_process : process (clk)
    begin
        if rising_edge(clk) then
            if en = '1' then
                if h_count_sig = H_MAX then
                    h_count_sig <= (others => '0');
                    if v_count_sig = V_MAX then
                        v_count_sig <= (others => '0');
                    else
                        v_count_sig <= v_count_sig + 1;
                    end if;
                else
                    h_count_sig <= h_count_sig + 1;
                end if;
            end if;
        end if;
    end process;
    
    count_process1: process(h_count_sig, v_count_sig)
    begin
    
                if h_count_sig <= H_ACTIVE and v_count_sig <= V_ACTIVE then
                    video_on <= '1';
                else
                    video_on <= '0';
                end if;

                if h_count_sig >= 656 and h_count_sig <= 751 then
                    h_sync <= '0';
                else
                    h_sync <= '1';
                end if;

                if v_count_sig >= 490 and v_count_sig <= 491 then
                    v_sync <= '0';
                else
                    v_sync <= '1';
                end if;
    end process;

    -- Output assignments
    hcount <= std_logic_vector(h_count_sig);
    vcount <= std_logic_vector(v_count_sig);
    vid <= video_on;
    hs <= h_sync;
    vs <= v_sync;

end architecture;