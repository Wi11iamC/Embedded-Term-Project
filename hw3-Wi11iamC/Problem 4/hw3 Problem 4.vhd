library ieee;
use ieee.std_logic_1164.all;

entity problem4 is
    port (
        LDA,LDB,S0,S1,RD,CLK : in std_logic;
        x, y : in std_logic_vector(7 downto 0);
        RA, RB : out std_logic_vector(7 downto 0));
end problem4;
library ieee;
use ieee.std_logic_1164.all;
entity mux2t1 is
    port(
        in1,in2 : in std_logic_vector(7 downto 0); 
        sel : in std_logic;
        out1 : out std_logic_vector(7 downto 0));
end mux2t1;

architecture bmux2t1 of mux2t1 is 
begin
     out1 <= in1 WHEN sel ='1' ELSE in2;

end bmux2t1;
library ieee;
use ieee.std_logic_1164.all;
entity reg8 is
    port(
        IN_REG : in std_logic_vector(7 downto 0);
        CLK, LD : in std_logic;
        OUT_REG : out std_logic_vector(7 downto 0));
end reg8;

architecture breg8 of reg8 is 
begin
     process(clk)
     begin
     if ( clk'event and clk ='1') then
        if LD = '1' then
            OUT_REG <= not IN_REG;
        end if;

     end if;
     end process;
end breg8;

architecture bproblem4 of problem4 is

--- 8 bit register ---
component reg8 is
    port(
        IN_REG : in std_logic_vector(7 downto 0); 
        CLK,LD : in std_logic;
        OUT_REG : out std_logic_vector(7 downto 0));
end component reg8;

--- mux ---

component mux2t1 IS
    port(
        in1,in2 : in std_logic_vector(7 downto 0); 
        sel : in std_logic;
        out1 : out std_logic_vector(7 downto 0));
end component mux2t1;

signal OutMux1,OutMux2 : std_logic_vector(7 downto 0);
signal OutRegA,OutRegB : std_logic_vector(7 downto 0);
signal And1Out,And2Out : std_logic;

begin

    And1Out <=  LDB AND NOT RD;
    AND2Out <=  LDA AND RD;

    mux1 : mux2t1 port map(
        in1         => x,
        in2         => y,
        sel         => S1,
        out1        => OutMux1);

    regA : reg8 port map(
        IN_REG      =>  OutMux1,
        CLK         =>  CLK,
        LD          =>  AND2Out,
        OUT_REG     =>  OutRegA);
    
    mux2: mux2t1 port map(
        in1     => OutRegA,
        in2     => y,
        sel     => S0,
        out1    =>  OutMux2);

    regB : reg8 port map(
        IN_REG      =>  OutMux2,
        CLK         =>  CLK,
        LD          =>  And1Out,
        OUT_REG     =>  OutRegB);
    RA <= OutRegA;
    RB <= OutRegB;
    
end bproblem4;