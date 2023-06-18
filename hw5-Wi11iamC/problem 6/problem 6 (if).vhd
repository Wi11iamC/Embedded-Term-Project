library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux8t1 is
	port(
		inputs	:	in	std_logic_vector(7 downto 0);
		sel		:	in	std_logic_vector(2 downto 0);
		outt	:	out	std_logic);
end mux8t1;

architecture bmux8t1 of mux8t1 is
begin
	process(inputs,sel) is
	begin
		if ( sel = "111" ) then
			outt <=	inputs(7);
            
        elsif ( sel = "110" ) then
			outt <=	inputs(6);

        elsif ( sel = "101" ) then
			outt <=	inputs(5);

        elsif ( sel = "100" ) then
			outt <=	inputs(4);

        elsif ( sel = "011" ) then
			outt <=	inputs(3);

        elsif ( sel = "010" ) then
			outt <=	inputs(2);

		elsif ( sel = "001" ) then
			outt <=	inputs(1);

		elsif ( sel = "000" ) then
			outt <=	inputs(0);
		else
			outt	<=	'0';
		end if;
	end process;
end bmux8t1;