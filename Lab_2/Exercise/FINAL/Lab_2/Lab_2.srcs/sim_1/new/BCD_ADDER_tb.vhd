library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity BCD_ADDER_tb is
end BCD_ADDER_tb;

architecture test_bench of BCD_ADDER_tb is
component BCD_ADDER
               port(
               A : in STD_LOGIC_VECTOR(3 downto 0); 
               B : in STD_LOGIC_VECTOR(3 downto 0);
               BCD_cin : in STD_LOGIC;
               BCD_SUM : out STD_LOGIC_VECTOR(3 downto 0);
               BCD_Cout : out STD_LOGIC
               );
end component;
signal A_tb: STD_LOGIC_VECTOR(3 downto 0);
signal B_tb: STD_LOGIC_VECTOR(3 downto 0);
signal BCD_cin_TB: STD_LOGIC;
               -- Output Signals
signal BCD_SUM_TB: STD_LOGIC_VECTOR(3 downto 0);
signal BCD_COUT_TB : STD_LOGIC;
begin
UUT: BCD_ADDER port
                map(
                A=>A_tb,
                B=>B_tb,
                BCD_cin => BCD_cin_tb,
                BCD_sum => BCD_SUM_TB,
                BCD_Cout => BCD_Cout_TB
                );
tests: process
        begin
            wait for 10 ps;
                A_tb <="0101";
                B_tb <="0000";
                BCD_cin_TB <='0';
    
                wait for 10 ps;
                B_tb <="0101";
                A_tb <="0110";
                BCD_cin_TB <='0';
    
                
                wait for 10 ps;
                B_tb <="0101";
                A_tb <="0111";
                BCD_cin_TB <='0';
                
                wait for 10 ps;
                A_tb <="0011";
                B_tb <="0010";
                BCD_cin_TB <='0';            
                
                wait for 10 ps;
                A_tb <="1000";
                B_tb <="0110";
                BCD_cin_TB <='0';
                
                wait for 10 ps;
                A_tb <="0001";
                B_tb <="0101";
                BCD_cin_TB <='0';
    
                wait for 10 ps;
                A_tb <="0110";
                B_tb <="0111";
                BCD_cin_TB <='0';                
        end process;
end test_bench;
