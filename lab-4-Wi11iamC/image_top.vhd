library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity image_top is
  Port (
        clk : in std_logic;
        vga_hs, vga_vs : out std_logic;
        vga_r, vga_b : out std_logic_vector( 4 downto 0 );
        vga_g : out std_logic_vector( 5 downto 0 )
   );
end image_top;

architecture Behavioral of image_top is
    
    component clock_div
        port (
            clk : in std_logic;
            clk_div : out std_logic);
    end component;
    
    component vga_ctrl
        Port (
            clk, en : in std_logic;
            hcount, vcount : out std_logic_vector( 9 downto 0 );
            vid, hs, vs : out std_logic);
    end component;
    
    component pixel_pusher
        Port (
            clk, en, vs, vid : in std_logic;
            pixel : in std_logic_vector( 7 downto 0 );
            hcount : in std_logic_vector( 9 downto 0 );
            R, B : out std_logic_vector( 4 downto 0 );
            G : out std_logic_vector( 5 downto 0 );
            addr : out std_logic_vector( 17 downto 0 ));
    end component;
    
    component picture
        Port (
            clka : in std_logic;
            addra : in std_logic_vector( 17 downto 0 );
            douta : out std_logic_vector( 7 downto 0 )
        ); 
    end component;
    
    signal clk_en, vid, hs, vs : std_logic := '0';
    signal hcount, vcount : std_logic_vector( 9 downto 0 );
    signal addr : std_logic_vector( 17 downto 0 ) := (others => '0');
    signal pixel : std_logic_vector( 7 downto 0 ):= (others => '0');
    signal r_sig, b_sig : std_logic_vector(4 downto 0) := (others => '0');
    signal g_sig : std_logic_vector(5 downto 0) := (others => '0');
    
begin

    clk_div : clock_div
        port map (
            clk => clk,
            clk_div => clk_en
        );
        
    vga_control : vga_ctrl
        port map(
            clk => clk,
            en => clk_en,
            hcount => hcount,
            vcount => vcount,
            vid => vid,
            hs => hs,
            vs => vs
        );
        
    pixel_pushr : pixel_pusher
        port map(
            clk => clk,
            en => clk_en,
            vs => vs,
            vid => vid,
            pixel => pixel,
            hcount => hcount,
            addr => addr,
            R => r_sig,
            B => b_sig,
            G => g_sig
            
        );
        
        pictre : picture
            port map (
                clka => clk,
                addra => addr,
                douta => pixel 
            );
            
           vga_hs <= hs;
           vga_vs <= vs;
           vga_r <= r_sig;
           vga_b <= b_sig;
           vga_g <= g_sig;
end Behavioral;
