library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity FA_comb is
Port ( 
    A,B,C : in STD_LOGIC;
    SUM,CARRY : out STD_LOGIC_VECTOR(1 downto 0)
);

end FA_comb;


architecture dataflow of FA_comb is
begin

SUM(1) <= A xor B;
CARRY(1) <= A and B;
SUM(0) <= A xor B xor C;
CARRY(0) <= (A and B) or (B and C) or (A and C);


end dataflow;