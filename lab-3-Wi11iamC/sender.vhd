library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;


entity sender is
  Port ( 
         btn, ready, rst, clk, en : in std_logic;
         send : out std_logic;
         char : out std_logic_vector( 7 downto 0 ));
end sender;

architecture bsender of sender is

    type str is array(0 to 4) of std_logic_vector(7 downto 0); -- n = 5 characters
    signal NETID : str := (b"01110111", b"01100011", b"00110101", b"00110101", b"00110011"); -- "wc553" in ASCII
    signal i : std_logic_vector(2 downto 0) := (others=>'0');
    constant n : std_logic_vector(2 downto 0) := "101";

    type state is (idle, busyA, busyB, busyC);
    signal cur : state := idle;
    
begin

    process(clk, rst)
    begin
        if rst = '1' then
            send <= '0';
            i <= (others => '0');
            char <= (others => '0');
            cur <= idle;
        elsif rising_edge(clk) and en = '1' then
            case cur is
                when idle =>
                    if ready = '1' and btn = '1' and unsigned(i) < unsigned(n) then
                        send <= '1';
                        char <= NETID(to_integer(unsigned(i)));
                        i <= std_logic_vector(unsigned(i) + 1);
                        cur <= busyA;
                    elsif ready = '1' and btn = '1' and i=n then
                        i <= (others => '0');
                        cur <= idle;                        
                    end if;
                when busyA =>
                    cur <= busyB;
                when busyB =>
                    send <= '0';
                    cur <= busyC;
                when busyC =>
                    if ready = '1' and btn = '0' then
                        cur <= idle;
                    else
                        cur <= busyC;
                    end if;
                when others =>
                    cur <= idle;
                    char <= (others => '0');
                    i <= (others => '0');
                    send <= '0';            
            end case;
        end if;
        
    end process;

end bsender;