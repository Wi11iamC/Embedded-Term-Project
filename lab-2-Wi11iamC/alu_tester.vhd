library IEEE;
use IEEE.STD_LOGIC_1164.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu_tester is
  Port ( btn : in std_logic_vector( 3 downto 0);
         clk : in std_logic;
         sw : in std_logic_vector( 3 downto 0);
         led : out std_logic_vector( 3 downto 0));
end alu_tester;

architecture Behavioral of alu_tester is

    signal a, b, opcodee : std_logic_vector( 3 downto 0) := "0000";
    signal out_dbnc : std_logic_vector( 3 downto 0) := "0000";
    signal alu_output : std_logic_vector( 3 downto 0);
    signal div_out : std_logic := '0';

    component debounce
    Port ( clk : in std_logic;
           btn : in std_logic;
           dbnc : out std_logic);
    end component;
    
    component my_alu
    Port ( A, B, opcode : in std_logic_vector( 3 downto 0);
           result : out std_logic_vector( 3 downto 0));
    end component;
    component clock_div is
        port (
            clk : in std_logic;
            div : out std_logic
        );
    end component;

begin

    process(div_out)
    begin
        if( rising_edge(div_out) ) then
            led <= alu_output;
            if(out_dbnc(0) = '1') then
                b <= sw;
            elsif( out_dbnc(1) = '1' ) then
                a <= sw; 
            elsif( out_dbnc(2) = '1' ) then
                opcodee <= sw;
            elsif( out_dbnc(3) = '1' ) then
                a <= (others => '0');
                b <= (others => '0');
                opcodee <= (others => '0');
            end if;
        end if;
    end process;
-- Instantiate clock divider
    clk_div_inst : clock_div port map(clk => clk, div => div_out);

    ALU : my_alu
    port map( A => a,
              B => b,
              opcode => opcodee,
              result => alu_output);
    
    dbnc0 : debounce -- B enable button
    port map( clk => clk,
              btn => btn(0),
              dbnc => out_dbnc(0));
              
    dbnc1 : debounce -- A enable button
    port map( clk => clk,
              btn => btn(1),
              dbnc => out_dbnc(1));
              
    dbnc2 : debounce -- opcode enable button
    port map( clk => clk,
              btn => btn(2),
              dbnc => out_dbnc(2));
              
    dbnc3 : debounce -- clear button
    port map( clk => clk,
              btn => btn(3),
              dbnc => out_dbnc(3));
    

end Behavioral;