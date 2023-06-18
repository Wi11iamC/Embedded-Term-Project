library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity debounce_tb is
end debounce_tb;

architecture testbench of debounce_tb is

    signal tb_clk : std_logic := '0';
    signal tb_btn : std_logic := '0';
    signal tb_dbnc : std_logic := '0';
    
    component debounce is
        port(
        
            clk  : in std_logic;        -- 125 Mhz clock
            btn0  : in std_logic;        -- switch, '1' = on
            
            dbnc : out std_logic        -- led, '1' = on
        
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
    
        wait for 1 ms;
        tb_btn <= '1';
        wait for 30 ms;
        tb_btn <= '0';
        
        
        wait for 10 ms;
        tb_btn <= '1';
        wait for 15 ms;
        tb_btn <= '1';
    
    end process switch_proc;
    
--------------------------------------------------------------------------------
-- port mapping
--------------------------------------------------------------------------------

    dut : debounce
    port map (
    
        clk  => tb_clk,
        btn0 => tb_btn,
        dbnc => tb_dbnc
    
    );

    
end testbench; 