library ieee;
use ieee.STD_LOGIC_1164.all;

entity problem2 is
	port(
		CLK	:	in	std_logic;
		X	:	in	std_logic_vector(1 to 2);
		Y	:	out	std_logic_vector(1 downto 0);
		Z	:	out	std_logic);
end problem2;

architecture bproblem2 of problem2 is
	type state_type is (S10,S01,S11);
	signal PS,NS	:	state_type;
begin
	process(CLK) is
	begin
		if(rising_edge(CLK)) then
			PS	<=	NS;
		end if;
	end process;

	process(X,PS) is
	begin
		Z	<=	'0';
		case (PS) is
			when S10 =>
				if ( X(1) = '0' ) then
					NS	<=	S10;
					Z	<=	'0';
				else
					NS	<=	S01;
					Z	<=	'0';
				end if;
			when S01 =>
				if ( X(2) = '0' ) then
					NS	<=	S10;
					Z	<=	'1';
				else
					NS	<=	S11;
					Z	<=	'0';
				end if;
			when S11 =>
				if ( X(2) = '0' ) then
					NS	<=	S10;
					Z	<=	'1';
				else
					NS	<=	S11;
					Z	<=	'0';
				end if;
			when others =>
				NS	<=	S10;
				Z	<=	'0';
		end case;
	end process;

		with PS select
	Y	<=	"01" when S01,
			"10" when S10,
			"11" when S11,
			"00" when others;
end bproblem2;