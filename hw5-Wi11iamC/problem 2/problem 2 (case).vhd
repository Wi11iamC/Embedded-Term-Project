library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity problem_2 is 
	port(
		A,B		:	in	std_logic_vector(1 downto 0);
		D		:	in	std_logic;
		E_out	:	out	std_logic);
end problem_2;

Architecture bproblem_2 of problem_2 is
	signal	outA,outB,outC,outD	:	std_logic;
	signal	inC					:	std_logic_vector(0 to 1);
	signal	inE					:	std_logic_vector(0 to 2);
begin
	inC	<=	B(1) & outD;
	inE	<=	outA & outB & outC;
	andA:	process(A)
	begin
		case (A) is
			when "00" | "01" | "10" =>
				outA	<=	'0';
			when "11" =>
				outA	<=	'1';
		end case;
	end process andA;
	orB:	process(B)
	begin
		case(B) is
			when "00" =>
				outB	<=	'0';
			when "01" | "10" | "11" =>
				outB	<=	'1';
		end case;
	end process orB;
	andC:	process(inC)
	begin
		case(inC) is
			when "00" | "01" | "10" =>
				outC	<=	'0';
			when "11" =>
				outC	<=	'1';
		end case;
	end process andC;
	notD:	process(D)
	begin
		case(D) is
			when '0' =>
				outD	<=	'1';
			when '1' =>
				outD	<=	'0';
		end case;
	end process notD;
	orE:	process(inE) is
	begin
		case (inE) is
			when "000" =>
				E_out	<=	'0';
			when others =>
				E_out	<=	'1';
		end case;
	end process orE;
end bproblem_2;