library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity problem_2 is 
	port(
		A,B		:	in	std_logic_vector(1 downto 0);
		D		:	in	std_logic;
		E_out	:	out	std_logic);
end problem_2;

architecture bproblem_2 of problem_2 is
begin
	process(A,B,D) is
	begin
		if ( A = "11") then
			E_out	<=	'1';
		elsif ( B = "01" or B = "10" or B = "11" ) then
			E_out	<=	'1';
		elsif ( B(1) = '1' and D = '0' ) then 
			E_out	<=	'1';
		else
			E_out	<=	'0';
		end if;
	end process;
end bproblem_2;