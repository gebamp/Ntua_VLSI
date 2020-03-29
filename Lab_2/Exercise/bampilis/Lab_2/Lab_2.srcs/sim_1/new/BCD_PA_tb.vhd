library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity BCD_PA_tb is
end BCD_PA_tb;

architecture test_bench of BCD_PA_tb is
component BCD_PA
              Port ( BCD_PA_in_1 : in std_logic_vector(15 downto 0);
                     BCD_PA_in_2 : in std_logic_vector(15 downto 0);
                     BCD_PA_cin  : in std_logic;
                     BCD_PA_SUM  : out std_logic_vector(15 downto 0);
                     BCD_PA_Cout : out std_logic
                    );
end component;
signal BCD_PA_in_1_tb: STD_LOGIC_VECTOR(15 downto 0);
signal BCD_PA_in_2_tb: STD_LOGIC_VECTOR(15 downto 0);
signal BCD_PA_cin_TB:  STD_LOGIC;
               -- Output Signals
signal BCD_PA_SUM_TB  : STD_LOGIC_VECTOR(15 downto 0);
signal BCD_PA_Cout_TB : STD_LOGIC;
                    
begin
UUT: BCD_PA port
              map(  BCD_PA_in_1 => BCD_PA_in_1_tb,
                    BCD_PA_in_2 => BCD_PA_in_2_tb,
                    BCD_PA_cin  => BCD_PA_cin_tb,
                    BCD_PA_SUM  => BCD_PA_SUM_tb,
                    BCD_PA_Cout => BCD_PA_Cout_tb
                 );
tests: process
     begin
               wait for 10 ps;
               BCD_PA_in_1_tb<="0001100100010000";
               BCD_PA_in_2_tb<="0001100100010000";
               BCD_PA_cin_tb<='0';      

               wait for 10 ps;
               BCD_PA_in_1_tb<="1001100110011001";
               BCD_PA_in_2_tb<="0000000000000001";
               BCD_PA_cin_tb<='0';     
                                                     
               wait for 10 ps;
               BCD_PA_in_1_tb<="0000000000000000";
               BCD_PA_in_2_tb<="0001100100010000";
               BCD_PA_cin_tb<='0';      

               wait for 10 ps;
               BCD_PA_in_1_tb<="1001100110011001";
               BCD_PA_in_2_tb<="0011100000100000";
               BCD_PA_cin_tb<='0';     
 
     end process;
end test_bench;
