library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

entity ripple_adder is
    Port (
    A, B : in std_logic_vector(3 downto 0);
    S : out std_logic_vector(3 downto 0);
    C4 : out std_logic
    
     );
end ripple_adder;

architecture bripple_adder of ripple_adder is

signal c0, c1, c2, c3 : std_logic := '0';
signal s0, s1, s2, s3 : std_logic := '0';

component full_adder is
    port (
        a, b, cin : in std_logic;
        sum, cout : out std_logic
    );
end component full_adder;

begin

    U0 : full_adder port map (
    a => A(0),
    b => B(0),
    cin => c0,
    cout => c1,
    sum => S(0)
    ); 
    U1 : full_adder port map (
    a => A(1),
    b => B(1),
    cin => c1,
    cout => c2,
    sum => S(1)
    );
    U2 : full_adder port map (
    a => A(2),
    b => B(2),
    cin => c2,
    cout => c3,
    sum => S(2)
    );
    U3 : full_adder port map (
    a => A(3),
    b => B(3),
    cin => c3,
    cout => C4,
    sum => S(3)
    );    

end bripple_adder;
