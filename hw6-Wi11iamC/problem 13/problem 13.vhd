library ieee;
use ieee.STD_LOGIC_1164.all;

entity problem13 is
	port(
		X			:	in	std_logic_vector(1 to 2);
		CLK			:	in	std_logic;
		Y			:	out	std_logic_vector(3 downto 1);
		CS,RD		:	out	std_logic);
end problem13;

architecture bproblem13 OF problem13 is
	type state_type is (S001,S010,S100);
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
		CS	<=	'0';
		RD	<=	'0';
		case (PS) is
			when S001 =>
				if ( X(1) = '0' ) then
					CS	<=	'0';
					RD	<=	'1';
					NS	<=	S010;
				else
					CS	<=	'1';
					RD	<=	'0';
					NS	<=	S100;
				end if;
			when S010 =>
				CS	<=	'1';
				RD	<=	'1';
				NS	<=	S100;
			when S100 =>
				if ( X(2) = '0' ) then
					CS	<=	'0';
					RD	<=	'0';
					NS	<=	S001;
				else
					CS	<=	'0';
					RD	<=	'1';
					NS	<=	S100;
				end if;
			when others =>
				CS	<=	'0';
				RD	<=	'0';
				NS	<=	S100;
		end case;
	end process;

	with PS select
		Y	<=	"100" when S100,
				"010" when S010,
				"001" when S001,
				"100" when others;
end bproblem13;