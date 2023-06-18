library ieee;
use ieee.std_logic_1164.all;

entity problem5 is 
    port(
        A,B,C : in std_logic_vector(7 downto 0); 
        SL1,SL2,CLK : in std_logic;
        RAX,RBX : out std_logic_vector(7 downto 0));
end problem5;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity decoder1t2 is
    Port (
        in1 : in std_logic;
        
        out0, out1 : out std_logic
    );
end decoder1t2;

architecture BDecoder of decoder1t2 is
begin
process(in1)
begin

        if in1 = '0' then
            out1 <= '0';
            out0 <= '1';
        else
            out1 <= '1';
            out0 <= '0';
        end if;
end process;

end BDecoder;
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


architecture bproblem5 of problem5 is


    
--- 1:2 decoder ---
component decoder1t2 is

    port(
        in1 : in std_logic;
        out0, out1 : out std_logic);

end component decoder1t2;

--- 8 bit register ---
component reg8 is
    port(
        IN_REG : in std_logic_vector(7 downto 0); 
        CLK,LD : in std_logic;
        OUT_REG : out std_logic_vector(7 downto 0));
end component reg8;


--- 2:1 mux ---
component mux2t1 IS
    port(
        in1,in2 : in std_logic_vector(7 downto 0); 
        sel : in std_logic;
        out1 : out std_logic_vector(7 downto 0));
end component mux2t1;

signal DecOut0,DecOut1 : std_logic;
signal MuxOut : std_logic_vector(7 downto 0);

begin

    dec : decoder1t2 port map(
        in1     =>  SL1,
        out0    =>  decout0,
        out1    =>  decout1);

    mux : mux2t1 port map(
        in1     => B,
        in2     => C,
        sel     => SL2,
        out1    => MuxOut
    );

    regA : reg8 port map(
        IN_REG      => A,
        CLK         => CLK,
        LD          => DecOut1,
        OUT_REG     => RAX
    );

    regB : reg8 port map(
        IN_REG      => MuxOut,
        CLK         => CLK,
        LD          => DecOut0,
        OUT_REG     => RBX
    );


end bproblem5;