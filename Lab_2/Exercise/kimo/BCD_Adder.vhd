library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BCD_Adder is
    Port(
    A,B : in STD_LOGIC_VECTOR(3 downto 0);
    CIN : in STD_LOGIC;
    SUM : out STD_LOGIC_VECTOR(3 downto 0);
    COUT : out STD_LOGIC
);
end BCD_Adder;

architecture Structural of BCD_Adder is

component RA is
Port ( 
    A,B : in STD_LOGIC_VECTOR (3 downto 0);
    Cin : in STD_LOGIC;
    S : out STD_LOGIC_VECTOR (3 downto 0);
    Cout : out STD_LOGIC
);
end component;

signal C : STD_LOGIC;
signal S1 : STD_LOGIC_VECTOR(3 downto 0);
signal S2 : STD_LOGIC_VECTOR(3 downto 0);

begin
    RA1: RA port map( A,B,CIN,S1,C );
    S2(0) <= '0';
    S2(1) <= C or (S1(3) and S1(2)) or (S1(3) and S1(1));
    S2(2) <= C or (S1(3) and S1(2)) or (S1(3) and S1(1));
    S2(3) <= '0';
    
    RA2: RA port map( S1,S2,'0',SUM,open);
    COUT <= C or (S1(3) and S1(2)) or (S1(3) and S1(1));
    

end Structural;
