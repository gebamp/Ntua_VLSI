library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity BCD_ADDER is
    Port ( A : in STD_LOGIC_VECTOR(3 downto 0); 
           B : in STD_LOGIC_VECTOR(3 downto 0);
           BCD_cin : in STD_LOGIC;
           BCD_SUM : out STD_LOGIC_VECTOR(3 downto 0);
           BCD_Cout : out STD_LOGIC
           );
end BCD_ADDER;

architecture Structural of BCD_ADDER is

component RCA is
    port( x: in STD_LOGIC_vector(3 downto 0);
          y: in STD_LOGIC_vector(3 downto 0);
          RCA_Cin: in STD_LOGIC;
          s: out STD_LOGIC_VECTOR(3 downto 0);
          RCA_Cout: out STD_LOGIC
        );
end component;
component AND_GATE is
    port ( A_and: in STD_LOGIC;
           B_and: in STD_LOGIC;
           O_and: out STD_LOGIC
          );
end component;
component three_way_or is
    port ( A_or: in STD_LOGIC;
           B_or: in STD_LOGIC;
           C_or: in STD_LOGIC;
           O_or: out STD_LOGIC
         );
end component;
signal first_addition: std_logic_vector(3 downto 0);
signal first_carry: std_logic;
signal first_and: std_logic;
signal second_and : std_logic;
signal temp_cout : std_logic;
signal zero: std_logic;
begin
zero <= '0';
RCA_1 :  RCA
           port map(
           X=>A,
           Y=>B,
           RCA_CIN => BCD_cin,
           s => first_addition,
           RCA_Cout => first_carry                
           );  
AND_1 :  AND_GATE
           port map (
           A_and =>first_addition(3),
           B_and => first_addition(2),
           O_and => first_and
           );           
AND_2 :  AND_GATE
           port map (
           A_and =>first_addition(3),
           B_and => first_addition(1),
           O_and => second_and
           ); 
OR_1 :   three_way_or
           port map (
           A_or => first_carry,
           B_or => first_and,
           C_or => second_and,
           O_or => temp_cout          
           );
RCA_2 :  RCA
           port map(
           X=> first_addition,
           Y=>(zero & temp_cout & temp_cout & zero),
           RCA_CIN =>zero ,
           s => BCD_SUM        
           );
BCD_COUT <= temp_cout;
end Structural;
