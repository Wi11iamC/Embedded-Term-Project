library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux8t1 is
	port(
		inputs	:	in	std_logic_vector(7 downto 0);
		sel		:	in	std_logic_vector(2 downto 0);
		outt	:	out	std_logic);
end mux8t1;

architecture bmux8to1 of mux8t1 is
begin
    process(inputs,sel) is
    begin
        case (sel) is
            when "000" =>
                outt    <= inputs(0);
            when "001" =>
                outt    <= inputs(1);
            when "010" =>
                outt    <= inputs(2);
            when "011" =>
                outt    <= inputs(3);
            when "100" =>
                outt    <= inputs(4);
            when "101" =>
                outt    <= inputs(5);
            when "110" =>
                outt    <= inputs(6);
            when "111" =>
                outt    <= inputs(7);
            when others =>
                outt    <=  '0';
        end case;
    end process;
end bmux8to1;