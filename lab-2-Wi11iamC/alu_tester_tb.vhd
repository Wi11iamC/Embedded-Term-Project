
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu_tester_tb is
--  Port ( );
end alu_tester_tb;

architecture testbench of alu_tester_tb is

    signal tb_clk : std_logic;
    signal tb_btn : std_logic_vector(3 downto 0) := "0000";
    signal tb_sw : std_logic_vector(3 downto 0) := "0000";
    signal tb_led : std_logic_vector(3 downto 0);
    
    component alu_tester is
        port(
        
            clk  : in std_logic;        -- 125 Mhz clock
            btn  : in std_logic_vector(3 downto 0);
            sw  : in std_logic_vector(3 downto 0);
            led  : out std_logic_vector(3 downto 0)
        
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
    
    -- flip the btn high after 1ms
    switch_proc: process
    begin
        wait for 1 ms; --addition
        tb_btn(2) <= '1';
        wait for 502 ms;
        tb_btn(2) <= '0';
        wait for 4 ms;
        tb_sw(0) <= '1';
        tb_btn(1) <= '1';
        wait for 502 ms;
        tb_btn(1) <= '0';
        wait for 4 ms;
        tb_btn(0) <= '1';
        wait for 502 ms;
        tb_btn(0) <= '0';
        wait for 22 ms; -- subtraction
        tb_sw(0) <= '1';
        tb_btn(2) <= '1';
        wait for 502 ms;
        tb_btn(2) <= '0';
        wait for 22 ms; -- increment A
        tb_sw(0) <= '0';
        tb_sw(1) <= '1';
        tb_btn(2) <= '1';
        wait for 502 ms;
        tb_btn(2) <= '0';
        wait for 22 ms; -- decrement A
        tb_sw(0) <= '1';
        tb_sw(1) <= '1';
        tb_btn(2) <= '1';
        wait for 502 ms;
        tb_btn(2) <= '0';
        wait for 500 ms;
    end process switch_proc;
    
--------------------------------------------------------------------------------
-- port mapping
--------------------------------------------------------------------------------

    dut : alu_tester
    port map (
    
        clk  => tb_clk,
        btn => tb_btn,
        sw => tb_sw,
        led => tb_led
    
    );

    
end testbench;
