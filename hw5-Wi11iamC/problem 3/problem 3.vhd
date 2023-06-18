library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity problem_3 is
	port(
		A,B		:	in	std_logic_vector(1 downto 0);
		D		:	in	std_logic;
		E_out	:	out	std_logic);
end problem_3;

architecture bproblem_3 of problem_3 is
	signal outA,outB,outC,outD	:	std_logic;
begin
	outA	<=	A(0) and A(1);
	outB	<=	B(0) or B(1);
	outC	<=	B(1) and outD;
	outD	<=	not D;
	E_out	<=	outA or outB or outC;
end bproblem_3;