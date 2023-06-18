library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;

entity full_adder is
    port (
        a, b, cin : in std_logic;
        sum, cout : out std_logic
    );
end entity full_adder;

architecture behavioral of full_adder is
begin
    sum <= a xor b xor cin;     -- sum
    cout <= (a and b) or (cin and (a xor b));     -- carry-
end architecture behavioral;
