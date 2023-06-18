library ieee;
use ieee.std_logic_1164.all;

entity problem1 is
    port(
        A,B : in std_logic_vector(7 downto 0);
        LDA, SEL, CLK : in std_logic;
        F: out std_logic_vector(7 downto 0));
end problem1;

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
            OUT_REG <= IN_REG;
        end if;

     end if;
     end process;
end breg8;


architecture bproblem1 of problem1 is

--- 8-bit Register ---
component reg8 is
    port(
        IN_REG : in std_logic_vector(7 downto 0);
        CLK, LD : in std_logic;
        OUT_REG : out std_logic_vector(7 downto 0));
end component reg8;

--- 2:1 Mux ---
component mux2t1 is
    port(
        in1,in2 : in std_logic_vector(7 downto 0); 
        sel : in std_logic;
        out1 : out std_logic_vector(7 downto 0));
end component mux2t1;

signal outmux : std_logic_vector(7 downto 0); 
begin
    mux: mux2t1 port map (
        in1     => A,
        in2     => B,
        sel     => SEL,
        out1    => outmux);

    reg: reg8 port map (
        IN_REG  =>  outmux,
        CLK     =>  CLK,
        LD      =>  LDA,
        OUT_REG =>  F);

end bproblem1;