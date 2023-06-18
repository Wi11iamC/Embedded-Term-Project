----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/23/2023 06:43:10 PM
-- Design Name: 
-- Module Name: fancy_counter - Behavioral
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

entity fancy_counter is
  Port (
  clk, clk_en, dir, en, ld, rst, updn : in std_logic; 
  val : in std_logic_vector(3 downto 0);
  cnt : out std_logic_vector(3 downto 0)
   );
end fancy_counter;

architecture Behavioral of fancy_counter is

    signal counter : std_logic_vector(3 downto 0) := (others => '0');
    signal dir_reg : std_logic := '0';
    signal zero_reg : std_logic := '0';
    signal val_reg : std_logic_vector(3 downto 0) := (others => '0');

begin

process(clk)
begin
    
      if clk'event and clk='1' then
      if rst='1' then
         cnt <= (others => '0');
         counter <= (others => '0');
      elsif en ='1' then
         if clk_en = '1' then
         
            if updn = '1' then
                dir_reg <= dir;
            end if;
            
            if ld = '1' then
                val_reg <= val;
                counter <= val_reg;
                cnt <= val_reg;
            end if;
            if dir_reg = '1' then
                if counter < val_reg then
                counter <= std_logic_vector(unsigned(counter) + 1);
                else
                counter <=  (others => '0');
                end if;
            end if;
            
            if dir_reg = '0' then
                if counter > (cnt'range => '0') then
                    counter <= std_logic_vector(unsigned(counter) - 1);
                else
                counter <=  val_reg;
                end if;
            end if;
            
            cnt <= counter;
         end if;
         end if;
      end if;
   

    
    end process;



end Behavioral;
