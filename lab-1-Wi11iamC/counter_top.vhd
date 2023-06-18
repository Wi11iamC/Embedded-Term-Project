----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/23/2023 07:50:00 PM
-- Design Name: 
-- Module Name: counter_top - Behavioral
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

entity counter_top is
 Port (
 btn: in std_logic_vector(3 downto 0);
 clk : in std_logic;
 sw : in std_logic_vector(3 downto 0);
 led : out std_logic_vector(3 downto 0)
  );
end counter_top;

architecture Behavioral of counter_top is

component debounce is
port(
btn, clk : in std_logic;
dbnc : out std_logic
);
end component debounce;

component fancy_counter is
  Port (
  clk, clk_en, dir, en, ld, rst, updn : in std_logic; 
  val : in std_logic_vector(3 downto 0);
  cnt : out std_logic_vector(3 downto 0)
   );
end component fancy_counter;
component clock_div is
    port(
        clk: in std_logic;
        div : out std_logic
   );
end component clock_div;

signal clk_en : std_logic := '0';
signal dbnc1 : std_logic := '0';
signal dbnc2 : std_logic := '0';
signal dbnc3 : std_logic := '0';
signal dbnc4 : std_logic := '0';
signal fout : std_logic_vector(3 downto 0) := (others => '0');

begin

    U1 : debounce port map(
    clk => clk,
    btn => btn(0),
    dbnc => dbnc1
    );
    
    U2 : debounce port map(
    clk => clk,
    btn => btn(1),
    dbnc => dbnc2
    );
    
    U3 : debounce port map(
    clk => clk,
    btn => btn(2),
    dbnc => dbnc3
    );
    U4 : debounce port map(
    clk => clk,
    btn => btn(3),
    dbnc => dbnc4
    );
    
    U5: clock_div port map (
        clk     => clk,
        div    => clk_en);

    U6 : fancy_counter port map(
    
    clk => clk,
    clk_en => clk_en,
    dir => sw(0),
    en => dbnc2,
    ld => dbnc4,
    rst => dbnc1,
    updn => dbnc3,
    val => sw,
    cnt => fout    
    );

led <= fout;

end Behavioral;
