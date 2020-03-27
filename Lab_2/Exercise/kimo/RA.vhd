library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity RA is
Port ( 
    A,B : in STD_LOGIC_VECTOR (3 downto 0);
    Cin : in STD_LOGIC;
    S : out STD_LOGIC_VECTOR (3 downto 0);
    Cout : out STD_LOGIC
);
end RA;
 
architecture Behavioral of RA is

component FA
Port ( 
    A,B,CIN : in  STD_LOGIC;
    SUM,COUT : out  STD_LOGIC
);
end component;

signal c1,c2,c3: STD_LOGIC;
 
begin
 
FA1: FA port map( A(0), B(0), Cin, S(0), c1);
FA2: FA port map( A(1), B(1), c1, S(1), c2);
FA3: FA port map( A(2), B(2), c2, S(2), c3);
FA4: FA port map( A(3), B(3), c3, S(3), Cout);
 
end Behavioral;