----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/23/2023 02:19:18 PM
-- Design Name: 
-- Module Name: clock_div_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

entity clock_div_tb is
end clock_div_tb;

architecture testbench of clock_div_tb is

    signal tb_clk : std_logic := '0';
    signal tb_led0 : std_logic;
    
    component clock_div is
        port(
        
            clk  : in std_logic;        -- 125 Mhz
            led0 : out std_logic        -- led, '1' = on
        
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

    dut : clock_div
    port map (
    
        clk  => tb_clk,
        led0 => tb_led0
    
    );

    
end testbench; 