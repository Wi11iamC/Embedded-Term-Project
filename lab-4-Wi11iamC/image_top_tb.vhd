library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity image_top_tb is
end image_top_tb;

architecture testbench of image_top_tb is

    signal tb_clk : std_logic := '0';
    signal tb_vga_hs, tb_vga_vs : std_logic := '0';
    signal tb_vga_r, tb_vga_b : std_logic_vector( 4 downto 0 ) := (others => '0');
    signal tb_vga_g : std_logic_vector( 5 downto 0 ) := (others => '0');
    
    component image_top is
        port(
            clk : in std_logic;
            vga_hs, vga_vs : out std_logic;
            vga_r, vga_b : out std_logic_vector( 4 downto 0 );
            vga_g : out std_logic_vector( 5 downto 0 )
        );
    end component;
    
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

begin

--------------------------------------------------------------------------------
-- procs
--------------------------------------------------------------------------------

    -- simulate a 125 Mhz clock
    clk_gen_proc: process
    begin
    
        wait for 4 ns;
        tb_clk <= '1';
        
        wait for 4 ns;
        tb_clk <= '0';
    
    end process clk_gen_proc;
    
--------------------------------------------------------------------------------
-- port mapping
--------------------------------------------------------------------------------

    dut : image_top
    port map (
    
        clk => tb_clk,
        vga_hs => tb_vga_hs,
        vga_vs => tb_vga_vs,
        vga_r => tb_vga_r,
        vga_b => tb_vga_b,
        vga_g => tb_vga_g
    
    );

    
end testbench; 