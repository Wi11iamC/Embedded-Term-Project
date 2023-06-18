------------------------------------
-- Lab Intro Sample
-- Prepared for Rutgers University
-- Initial: Gregory Leonberg
-- Rev 1: Milton Diaz
------------------------------------

-------------------------------------------------------------
-- required library include and use statement in order to use std_logic_vector type
-------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

-------------------------------------------------------------
-- entity "black-box declaration"
-------------------------------------------------------------
entity lab_intro is
	port (
		swt : in std_logic_vector (7 downto 0);
		led : out std_logic_vector (7 downto 0)
	);
end lab_intro;

-------------------------------------------------------------
-- architecture "internal implementation"
-------------------------------------------------------------
architecture simple of lab_intro is
	signal val : std_logic_vector(7 downto 0) := (others => '0');
begin
	val(0) <= not swt(0);
	val(1) <= swt(1) and not swt(2);
	val(3) <= swt(2) and swt(3);
	val(2) <= val(1) or val(3);
	val(7 downto 4) <= swt(7 downto 4);
	led <= val;
end simple;