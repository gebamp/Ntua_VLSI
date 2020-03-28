library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity three_way_or is
      Port (A_or: in STD_LOGIC;
            B_or: in STD_LOGIC;
            C_or: in STD_LOGIC;
            O_or: out STD_LOGIC
            );
end three_way_or;

architecture Dataflow of three_way_or is

begin

        O_or<= A_or or B_or or C_or;
end Dataflow;
