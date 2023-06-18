library ieee;
use ieee.STD_LOGIC_1164.all;

entity problem6 is
	port(
		CLK,X	:	in	std_logic;
		Y		:	out	std_logic_vector(1 downto 0);
		Z		:	out	std_logic_vector(1 to 2));
end problem6;

architecture bproblem6 of problem6 is
	type state_type is (S00,S01,S10,S11);
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
		Z	<=	"00";
		case (PS) is
			when S00 =>
				Z(1)	<=	'1';
				if ( X = '0' ) then
					Z(2)	<=	'0';
					NS		<=	S10;
				elsif ( X = '1' ) then
					Z(2)	<=	'0';
					NS		<=	S00;
				end if;
			when S01 =>
				Z(1)	<=	'0';
				if ( X = '0' ) then
					Z(2)	<=	'0';
					NS		<=	S11;
				elsif ( X = '1' ) then
					Z(2)	<=	'0';
					NS		<=	S01;
				end if;
			when S10 =>
				Z(1)	<=	'1';
				if ( X = '0' ) then
					Z(2)	<=	'0';
					NS		<=	S01;
				elsif ( X = '1' ) then
					Z(2)	<=	'0';
					NS		<=	S00;
				end if;
			when S11 =>
				Z(1)	<=	'0';
				IF ( X = '0' ) then
					Z(2)	<=	'1';
					NS		<=	S00;
				elsif ( x = '1' ) then
					Z(2)	<=	'0';
					NS		<=	S01;
				end if;
			when others =>
				Z	<=	"00";
				NS	<=	S00;
		end case;
	end process;

	with PS select
		Y	<=	"00" when S00,
				"01" when S01,
				"10" when S10,
				"11" when S11,
				"00" when others;
end bproblem6;