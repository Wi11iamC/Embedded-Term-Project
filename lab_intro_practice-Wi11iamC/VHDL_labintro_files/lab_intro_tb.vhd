------------------------------------
-- Lab 1 Sample Testbench
-- Prepared for Rutgers University
-- Initial: Gregory Leonberg
-- Rev 1: Milton Diaz
------------------------------------

-- required library include and use statement in order to use std_logic_vector type
-- need numeric_std to use integer to std_logic_vector type conversion
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------
-- empty entity for testbench
-------------------------------------------------------------
entity lab_intro_tb is
end lab_intro_tb;

-------------------------------------------------------------
-- logic for testing lab intro entity
-------------------------------------------------------------
architecture tb of lab_intro_tb is

	-- component declaration to use lab intro design in our testbench
	component lab_intro
		port (
		swt : in std_logic_vector (7 downto 0);
		led : out std_logic_vector (7 downto 0)
	);
	end component;
	
	-- internal signals to interface with lab1 component
	signal swt : std_logic_vector(7 downto 0) := (others => '0');
	signal led : std_logic_vector(7 downto 0) := (others => '0');
	
	-- signal for expected output
	signal e_led : std_logic_vector(7 downto 0) := (others => '0');
    
begin

	-------------------------------------------------------------
	-- instiate component to be tested
	-------------------------------------------------------------
	dut: lab_intro port map (
		swt => swt,
		led => led
	);
	
	-------------------------------------------------------------
	-- calculate expected outputs
	-------------------------------------------------------------
	e_led(0) <= not swt(0);
	e_led(1) <= swt(1) and not swt(2);
	e_led(3) <= swt(2) and swt(3);
	e_led(2) <= e_led(1) or e_led(3);
	e_led(7 downto 4) <= swt(7 downto 4);

	-------------------------------------------------------------
	-- need to be inside process to use for loop
	-------------------------------------------------------------
	process begin
	
		-------------------------------------------------------------
		-- loop over all possible 8 bit inputs from switches
		-------------------------------------------------------------
		for counter in 0 to 255 loop
			
			-------------------------------------------------------------
			-- apply stimulus to inputs and wait for outputs to resolve
			-------------------------------------------------------------
			swt <= std_logic_vector(to_unsigned(counter, 8));
			wait for 1 ns;
			
			-------------------------------------------------------------
			-- check outputs
			-------------------------------------------------------------
			
			if 	(led = e_led) then
				report "LED output matched at " & time'image(now);
			else
				report "LED output mis-matched at " & time'image(now) & 
				": expected: " & integer'image(to_integer(unsigned(e_led))) &
				", actual: " & integer'image(to_integer(unsigned(led))) severity error;
			end if;
			
			-------------------------------------------------------------
			-- pass some time
			-------------------------------------------------------------
			wait for 1 ns; -- need to have time pass for legible waveforms
			
		end loop;
		
	end process;
	
	
end tb;