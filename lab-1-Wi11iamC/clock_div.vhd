----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/23/2023 02:11:11 PM
-- Design Name: 
-- Module Name: clock_div - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clock_div is
    port(

        clk  : in std_logic;        -- 125 Mhz clock        
        div : out std_logic        -- led, '1' = on

    );
end clock_div;

architecture behavior of clock_div is

    signal counter : std_logic_vector(26 downto 0) := (others => '0');

begin

    process(clk)
    begin
        if rising_edge(clk) then
       
                -- count one full led period (2 Hz)
                
                if (unsigned(counter) < 62499999) then
                    counter <= std_logic_vector(unsigned(counter) + 1);
                    div <= '0';
                else
                    counter <= (others => '0');
                    div <= '1';
                end if;
            
            end if;
    
    end process;
    
end behavior;