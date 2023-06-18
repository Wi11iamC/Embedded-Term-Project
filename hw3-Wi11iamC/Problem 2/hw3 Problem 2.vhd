library ieee;
use ieee.std_logic_1164.all;

entity problem2 is
    port(
      X,Y,Z : in std_logic_vector(7 downto 0); 
      MS : in std_logic_vector(1 downto 0); 
      DS, CLK : in std_logic;
      RB,RA : out std_logic_vector(7 downto 0));
end problem2;

library ieee;
use ieee.std_logic_1164.all;
entity mux4t1 is
    port(
        in0, in1, in2, in3 : in std_logic_vector(7 downto 0); 
        sel : in std_logic_vector(1 downto 0);
        out1 : out std_logic_vector(7 downto 0));
end mux4t1;

architecture bmux4t1 of mux4t1 is 
begin
    process(in3, in2, in1, in0, sel)
    begin
     if sel(0) = '1' and sel(1) = '1' then
        out1 <= in3;
    elsif sel(0) = '1' and sel(1) = '0' then
        out1 <= in2;
    elsif sel(0) = '0' and sel(1) = '1' then
        out1 <= in1;
    else
        out1 <= in0;
    end if;
    end process;

end bmux4t1;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity decoder1to2 is
    Port (
        in1 : in std_logic;
        
        out0, out1 : out std_logic
    );
end decoder1to2;

architecture BDecoder of decoder1to2 is
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



architecture bproblem2 of problem2 is

--- 4:1 Mux ---

component mux4t1 is
    port(
        in0,in1,in2,in3 : in std_logic_vector(7 downto 0);
        sel : in std_logic_vector(1 downto 0);
        out1 : out std_logic_vector(7 downto 0));
end component mux4t1;


--- 1:2 Decoder ---

component decoder1to2 is

    port(
        in1: std_logic; 
        out0,out1 : out std_logic);
end component decoder1to2;


--- 8-bit register ---

component reg8 is
    PORT(
        IN_REG : in std_logic_vector(7 downto 0); 
        CLK, LD : in std_logic;
        OUT_REG : out std_logic_vector(7 downto 0));
end component reg8;

signal outmux,outregA,outregB   : std_logic_vector(7 downto 0);
signal decout0,decout1 : std_logic;

begin

mux:    mux4t1 port map (
           in0     =>  outregB,
           in1     => Z,
           in2     => Y,
           in3     => X,
           sel     =>  MS,
           out1    => outmux);

dec:    decoder1to2 port map (
           in1     =>  DS,
           out0    =>  decout0,
           out1    =>  decout1);

regA:   reg8 port map (
           IN_REG  =>  outmux,
           CLK     =>  CLK,
           LD      =>  decout0,
           OUT_REG =>  outregA);
regB:   reg8 port map (
           IN_REG  =>  outregA,
           CLK     =>  CLK,
           LD      =>  decout1,
           OUT_REG =>  outregB);

    RA <= outregA;
    RB <= outregB;
end bproblem2;

