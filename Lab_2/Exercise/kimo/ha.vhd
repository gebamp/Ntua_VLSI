library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity HA is

Port ( 
    A,B : in  STD_LOGIC;
    SUM : out  STD_LOGIC;
    CARRY : out  STD_LOGIC
);

end HA;


architecture dataflow of HA is
begin

SUM <= A xor B;

CARRY <= A and B;

end dataflow;