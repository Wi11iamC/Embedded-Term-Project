library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;


entity top_level is
  Port (
        btn : in std_logic_vector(1 downto 0);
        clk, TXD : in std_logic;
        RXD, CTS, RTS : out std_logic);
end top_level;

architecture Behavioral of top_level is

component clock_div
    port(
        clk : in std_logic;
        div : out std_logic);
end component;

component debounce
    port(
        clk: in std_logic;
        btn: in std_logic;
        dbnc: out std_logic);
end component;

component sender
  Port ( 
         btn, ready, rst, clk, en : in std_logic;
         send : out std_logic;
         char : out std_logic_vector( 7 downto 0 ));
end component;

component uart
    port (
    clk, en, send, rx, rst      : in std_logic;
    charSend                    : in std_logic_vector (7 downto 0);
    ready, tx, newChar          : out std_logic;
    charRec                     : out std_logic_vector (7 downto 0)
);
end component;

--intermediate signals
signal u1_out, u2_out, clk_div_out : std_logic := '0';
signal ready_ready, send_send : std_logic := '0';
signal char_char : std_logic_vector(7 downto 0);

begin
    RTS <= '0';
    CTS <= '0';
    
    U1 : debounce
        port map (
            btn => btn(0),
            clk => clk,
            dbnc => u1_out
        );

    U2 : debounce
        port map(
            btn => btn(1),
            clk => clk,
            dbnc => u2_out
        );
        
    U3 : clock_div
        port map (
            clk => clk,
            div => clk_div_out
        );

    U4 : sender
        port map (
            btn => u2_out,
            ready => ready_ready,
            rst => u1_out,
            clk => clk,
            en => clk_div_out,
            send => send_send,
            char => char_char 
        );

    U5 : uart
        port map(
            clk => clk,
            en => clk_div_out,
            send => send_send,
            rx => TXD,
            rst => u1_out,
            charSend => char_char,
            ready => ready_ready,
            tx => RXD
        );
end Behavioral;