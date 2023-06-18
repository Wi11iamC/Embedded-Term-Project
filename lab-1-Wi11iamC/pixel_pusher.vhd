library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity pixel_pusher is
    port (
        clk      : in  std_logic;
        en       : in  std_logic;
        vs       : in  std_logic;
        pixel    : in  std_logic_vector(15 downto 0);
        hcount   : in  std_logic_vector(63 downto 0);
        vid      : in  std_logic;
        r    : out std_logic_vector(4 downto 0);
        g    : out std_logic_vector(5 downto 0);
        b    : out std_logic_vector(4 downto 0);
        addr : out std_logic_vector(11 downto 0)
    );
end entity;

architecture rtl of pixel_pusher is

    -- signals and constants
    signal addr_sig       : unsigned(11 downto 0) := (others => '0');
    signal r_sig, b_sig    : std_logic_vector(4 downto 0) := (others => '0');
    signal g_sig : std_logic_vector(5 downto 0) := (others => '0');
    constant MAX_HCNT : integer := 480;

begin

    -- update address counter
    addr_process : process (clk)
    begin
        if rising_edge(clk) then
            if vs = '0' then  -- reset when vs is 0
                addr_sig <= (others => '0');
            elsif en = '1' and vid = '1' and to_integer(unsigned(hcount)) < MAX_HCNT then
                addr_sig <= addr_sig + 1;
            end if;
        end if;
    end process;

    -- update R, G, B outputs
    rgb_process : process (clk)
    begin
        if rising_edge(clk) then
            if en = '1' and vid = '1' and to_integer(unsigned(hcount)) < MAX_HCNT then
                r_sig <= pixel(15 downto 11);
                g_sig <= pixel(10 downto 5);
                b_sig <= pixel(4 downto 0);
            else
                r_sig <= (others => '0');
                g_sig <= (others => '0');
                b_sig <= (others => '0');
            end if;
        end if;
    end process;

    -- assignment outputs
    r    <= r_sig;
    g    <= g_sig;
    b    <= b_sig;
    addr <= std_logic_vector(addr_sig);

end architecture;