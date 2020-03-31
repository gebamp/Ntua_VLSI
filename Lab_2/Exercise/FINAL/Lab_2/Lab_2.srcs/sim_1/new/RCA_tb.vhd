library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity RCA_tb is
end RCA_tb;

architecture test_bench of RCA_tb is
component RCA
    port(
         x: in STD_LOGIC_VECTOR(3 downto 0);
         y: in STD_LOGIC_VECTOR(3 downto 0);
         RCA_Cin: in STD_LOGIC;
         s: out STD_LOGIC_VECTOR(3 downto 0);
         RCA_Cout: out STD_LOGIC
         );
end component;
-- Input Signals
signal x_tb: STD_LOGIC_VECTOR(3 downto 0);
signal y_tb: STD_LOGIC_VECTOR(3 downto 0);
signal RCA_cin_TB: STD_LOGIC;
-- Output Signals
signal s_tb: STD_LOGIC_VECTOR(3 downto 0);
signal rca_cout_tb : STD_LOGIC;

begin

UUT: RCA port
           map(
           x => x_tb,
           y => y_tb,
           RCA_Cin => RCA_Cin_tb,
           s => s_tb,
           RCA_Cout => RCA_Cout_tb
           );
tests: process
       begin
            
            wait for 10 ps;
            x_tb <="0101";
            y_tb <="0000";
            RCA_Cin_tb <='0';

            wait for 10 ps;
            x_tb <="0101";
            y_tb <="0110";
            RCA_Cin_tb <='0';

            
            wait for 10 ps;
            x_tb <="0101";
            y_tb <="0111";
            RCA_Cin_tb <='0';
            
            wait for 10 ps;
            x_tb <="0011";
            y_tb <="0010";
            RCA_Cin_tb <='0';            
            
            wait for 10 ps;
            x_tb <="1010";
            y_tb <="0110";
            RCA_Cin_tb <='0';
            
            wait for 10 ps;
            x_tb <="1111";
            y_tb <="0101";
            RCA_Cin_tb <='0';

            wait for 10 ps;
            x_tb <="1010";
            y_tb <="0111";
            RCA_Cin_tb <='0';
                
       end process;            
end test_bench;
