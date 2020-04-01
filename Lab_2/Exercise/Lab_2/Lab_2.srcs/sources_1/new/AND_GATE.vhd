library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity AND_GATE is
        Port ( A_and: in STD_LOGIC;
               B_and: in STD_LOGIC;
               O_and: out STD_LOGIC);
end AND_GATE;

architecture Dataflow of AND_GATE is

begin
    O_and<= A_and and B_and;
end Dataflow;
