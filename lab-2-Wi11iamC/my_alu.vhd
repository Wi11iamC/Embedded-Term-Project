library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity my_alu is
    Port ( A : in  std_logic_vector(3 downto 0);
           B : in  std_logic_vector(3 downto 0);
           opcode : in  std_logic_vector(3 downto 0);
           result : out  std_logic_vector(3 downto 0));
end my_alu;

architecture Behavioral of my_alu is
begin
    process(A, B, opcode)
    begin
        case opcode is
            when "0000" =>
                result <= std_logic_vector(unsigned(A) + unsigned(B));
                
            when "0001" =>
                result <= std_logic_vector(unsigned(A) - unsigned(B));
                
            when "0010" =>
                result <= std_logic_vector(unsigned(A) + 1);
                
            when "0011" =>
                result <= std_logic_vector(unsigned(A) - 1);
                
            when "0100" =>
                result <= std_logic_vector(0 - unsigned(A));
                
            when "0101" =>
            if unsigned(A) > unsigned(B) then
                result <= "0001";
            else
                result <= "0000";
            end if;
                
            when "0110" =>
                result <= std_logic_vector(unsigned(A) sll 1);
                
            when "0111" =>
                result <= std_logic_vector(unsigned(A) srl 1);
                
            when "1000" =>
                result <= std_logic_vector(shift_right(signed(A), 1));
                
            when "1001" =>
                result <= not A;
                
            when "1010" =>
                result <= A and B;
                
            when "1011" =>
                result <= A or B;
                
            when "1100" =>
                result <= A xor B;
                
            when "1101" =>
                result <= (A xnor B);
                
            when "1110" =>
                result <= (A nand B);
                
            when "1111" =>
                result <= (A nor B);
                
            when others =>
                result <= "0000";
        end case;
    end process;
end Behavioral;