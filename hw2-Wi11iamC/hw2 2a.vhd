-- library declaration
LIBRARY ieee;
USE ieee.std_logic_1164.all;

-- entity
entity ckt is
    port(
            A,B,C,D : in std_logic;
            F : out std_logic
        ); 
end ckt;

-- architecture
architecture ckt_conditional of ckt is
begin
    F <=
        '1' when( A = '0' and C = '1' and D = '0' ) else
        '1' when( B = '0' and C = '1') else
        '1' when( B = '1' and C = '1' and D = '0' ) else
        '0';
end ckt_conditional;

-- architecture
architecture ckt_selected of ckt is 
signal bundle : std_logic_vector(0 TO 3);
begin
    bundle <= A & B & C & D;
    with bundle select
    F <= '1' when "0010"|"0110", '1' when "0010"|"0011"|"1010"|"1011", '1' when "0110"|"1110", '0' when others;
end ckt_selected;