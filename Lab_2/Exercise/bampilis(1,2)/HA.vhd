library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

entity HA is
    Port ( a: in STD_LOGIC;
           b: in STD_LOGIC;
           s: in STD_LOGIC;
           c: out STD_LOGIC
          );
end HA;

architecture Dataflow of HA is
begin
    s<= a xor b;
    c<= a and b;
end Dataflow;
