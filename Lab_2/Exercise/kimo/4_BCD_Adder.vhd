library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity BCD_Adder_4 is
    Port ( 
    A3,A2,A1,A0,B3,B2,B1,B0 : in STD_LOGIC_VECTOR(3 downto 0);
    CIN : in STD_LOGIC;
    DIGIT3: out STD_LOGIC_VECTOR(3 downto 0);
    DIGIT2: out STD_LOGIC_VECTOR(3 downto 0);
    DIGIT1: out STD_LOGIC_VECTOR(3 downto 0);
    DIGIT0: out STD_LOGIC_VECTOR(3 downto 0);
    COUT : out STD_LOGIC
);
end BCD_Adder_4;

architecture Structural of BCD_Adder_4 is

component BCD_Adder is
    Port(
    A,B : in STD_LOGIC_VECTOR(3 downto 0);
    CIN : in STD_LOGIC;
    SUM : out STD_LOGIC_VECTOR(3 downto 0);
    COUT : out STD_LOGIC
);
end component;

signal C1,C2,C3 : STD_LOGIC;
begin

    BCD1 : BCD_Adder port map( A0 , B0 , CIN , DIGIT0 , C1 );
    BCD2 : BCD_Adder port map( A1 , B1 , C1 , DIGIT1 , C2 );
    BCD3 : BCD_Adder port map( A2 , B2 , C2 , DIGIT2 , C3 );
    BCD4 : BCD_Adder port map( A3 , B3 , C3 , DIGIT3 , COUT => COUT );

end Structural;





