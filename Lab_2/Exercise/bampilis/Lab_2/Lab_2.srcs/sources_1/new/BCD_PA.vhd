library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity BCD_PA is
    Port ( BCD_PA_in_1 : in std_logic_vector(15 downto 0);
           BCD_PA_in_2 : in std_logic_vector(15 downto 0);
           BCD_PA_cin  : in std_logic;
           BCD_PA_SUM  : out std_logic_vector(15 downto 0);
           BCD_PA_Cout : out std_logic
            );
end BCD_PA;

architecture Structural of BCD_PA is
component BCD_ADDER is
    port ( A: in STD_LOGIC_VECTOR(3 downto 0);
           B: in STD_LOGIC_VECTOR(3 downto 0);
           BCD_cin : in STD_LOGIC;
           BCD_SUM : out STD_LOGIC_VECTOR(3 downto 0);
           BCD_Cout : out STD_LOGIC 
          );
end component;
signal carry_vector : std_logic_vector(2 downto 0);
signal temp_bcd_pa_sum_1 : std_logic_vector(3 downto 0);
signal temp_bcd_pa_sum_2 : std_logic_vector(3 downto 0);
signal temp_bcd_pa_sum_3 : std_logic_vector(3 downto 0);
signal temp_bcd_pa_sum_4 : std_logic_vector(3 downto 0);
begin
BCD_ADDER_1 : BCD_ADDER
                 port map (
                 A => BCD_PA_in_1(3) & BCD_PA_in_1(2) & BCD_PA_in_1(1) & BCD_PA_in_1(0),
                 B => BCD_PA_in_2(3) & BCD_PA_in_2(2) & BCD_PA_in_2(1) & BCD_PA_in_2(0),
                 BCD_cin => BCD_PA_cin,
                 BCD_SUM => temp_BCD_PA_SUM_1, 
                 BCD_cout => carry_vector(0)
                 );
BCD_ADDER_2 : BCD_ADDER
                 port map (
                 A => BCD_PA_in_1(7) & BCD_PA_in_1(6) & BCD_PA_in_1(5) & BCD_PA_in_1(4),
                 B => BCD_PA_in_2(7) & BCD_PA_in_2(6) & BCD_PA_in_2(5) & BCD_PA_in_2(4),
                 BCD_cin => carry_vector(0),
                 BCD_SUM => temp_BCD_PA_SUM_2,
                 BCD_cout => carry_vector(1)
                 );
BCD_ADDER_3 : BCD_ADDER
                 port map (
                 A => BCD_PA_in_1(11) & BCD_PA_in_1(10) & BCD_PA_in_1(9) & BCD_PA_in_1(8),
                 B => BCD_PA_in_2(11) & BCD_PA_in_2(10) & BCD_PA_in_2(9) & BCD_PA_in_2(8),
                 BCD_cin => carry_vector(1),
                 BCD_SUM => temp_BCD_PA_SUM_3,
                 BCD_cout => carry_vector(2)
                 );

BCD_ADDER_4 : BCD_ADDER
                 port map (
                 A => BCD_PA_in_1(15) & BCD_PA_in_1(14) & BCD_PA_in_1(13) & BCD_PA_in_1(12),
                 B => BCD_PA_in_2(15) & BCD_PA_in_2(14) & BCD_PA_in_2(13) & BCD_PA_in_2(12),
                 BCD_cin => carry_vector(2),
                 BCD_SUM => temp_BCD_PA_SUM_4,
                 BCD_cout =>BCD_PA_Cout 
                 );
BCD_PA_SUM <= temp_BCD_PA_SUM_4& temp_BCD_PA_SUM_3 & temp_BCD_PA_SUM_2 & temp_BCD_PA_SUM_1;
end Structural;
