library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity FA is

Port ( 
    A,B,CIN : in  STD_LOGIC;
    SUM : out  STD_LOGIC;
    COUT : out  STD_LOGIC
);

end FA;


architecture structural of FA is
signal C1,C2,S1 : Std_Logic;

component HA is

Port( 
    A,B : in STD_LOGIC;
    SUM,CARRY : out STD_LOGIC
);
end component;

begin

U1:HA PORT MAP(A=>A,B=>B,SUM=>S1,CARRY=>C1);

U2:HA PORT MAP(A=>S1,B=>CIN,SUM=>SUM,CARRY=>C2);

COUT <= C2 OR C1;

end structural;