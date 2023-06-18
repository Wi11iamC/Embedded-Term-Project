----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/01/2023 01:26:28 AM
-- Design Name: 
-- Module Name: ripple_adder_tb - Behavioral
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ripple_adder_tb is
--  Port ( );
end ripple_adder_tb;

architecture test_bench of ripple_adder_tb is

    signal A_tb, B_tb, S_tb : std_logic_vector(3 downto 0) := (others => '0');
    signal C4_tb : std_logic;

component ripple_adder is
    Port (
    A, B : in std_logic_vector(3 downto 0);
    S : out std_logic_vector(3 downto 0);
    C4 : out std_logic
    
     );
end component ripple_adder;

begin

    -- simulate a counting every 1 ms
    count_gen_proc: process
    begin
        wait for 500 ms;
        A_tb <= "0001";
        B_tb <= "0001";
        wait for 500 ms; --1 s
        A_tb <= "0010";
        B_tb <= "0010";
        wait for 500 ms;
        A_tb <= "0011";
        B_tb <= "0011";
        wait for 500 ms; -- 2s
        A_tb <= "0100";
        B_tb <= "0100";
        wait for 500 ms;
        A_tb <= "0101";
        B_tb <= "0101";
        wait for 500 ms; -- 3s
        A_tb <= "0110";
        B_tb <= "0110";
        wait for 500 ms;
        A_tb <= "0111";
        B_tb <= "0111";
        wait for 500 ms; -- 4s
        A_tb <= "1000";
        B_tb <= "1000";
        wait for 500 ms;           
        A_tb <= "0000";
        B_tb <= "0000";
        wait for 500 ms;   -- 5s        
        A_tb <= "0010";
        B_tb <= "1000";
        wait for 500 ms;
        A_tb <= "0001";
        B_tb <= "1111";
        wait for 500 ms; -- 6s
    end process count_gen_proc;
    
--------------------------------------------------------------------------------
-- port mapping
--------------------------------------------------------------------------------

    dut : ripple_adder
    port map (
    
        a  => A_tb,
        b => B_tb,
        S => S_tb,
        C4 => C4_tb
    
    );



end test_bench;
