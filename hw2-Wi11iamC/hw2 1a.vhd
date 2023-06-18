-- library declaration
library IEEE;
use IEEE.std_logic_1164.all; 

-- entity
entity f_out is
port ( 
A,B : in std_logic; 
F : out std_logic);
 end f_out;
 
 -- architecture
architecture f_out_arc of f_out is 
begin
     F <= (not A and B) or A or (A and not B)
end f_out_arc;
