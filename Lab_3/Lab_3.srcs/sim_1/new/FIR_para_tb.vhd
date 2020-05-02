library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;

entity FIR_para_tb is
end FIR_para_tb;

architecture Behavioral of FIR_para_tb is
constant data_width, coeff_width,min_vector_size : integer := 8;
component FIR_paral is
      generic(
            data_width :   integer    := 8;
            coeff_width:   integer    := 8;
            min_vector_size: integer  := 8
      );
      Port ( 
            x_0 : in std_logic_vector( data_width-1 downto 0);
            x_1 : in std_logic_vector( data_width-1 downto 0);
            clk : in std_logic;
            rst : in std_logic;
            valid_in : in std_logic;
            valid_out : out std_logic;
            y_0 : out std_logic_vector((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1 downto 0);
            y_1 : out std_logic_vector((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1 downto 0) 
      );
end component;
--Input Signals
signal clk: std_logic:='0';
signal rst: std_logic:='0';
signal valid_in: std_logic:='0';
signal x_0 : std_logic_vector(data_width-1 downto 0):=(others=>'0');
signal x_1 : std_logic_vector(data_width-1 downto 0):=(others=>'0');
signal valid_out: std_logic:='0';

--output signals
signal y_0 : std_logic_vector((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1 downto 0):=(others=>'0');
signal y_1 : std_logic_vector((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1 downto 0):=(others=>'0');

--Clock
constant CLKP : time := 100ps;

begin

clk_proc: 
    process
        begin
            clk <= '0';
            wait for CLKP/2;
            clk <= '1';
            wait for CLKP/2;
    end process;
UUT: FIR_paral port map(
         x_0 => x_0,
         x_1 => x_1,
         clk => clk,
         rst => rst,
         valid_in => valid_in,
         valid_out => valid_out,
         y_0 => y_0,
         y_1 => y_1
         );
    
TEST: 
             process
             begin
             valid_in <= '1';
             x_0 <="00000001";
             x_1 <="00000010";
             wait for CLKP;
             x_0 <="00000011";
             x_1 <="00000100";
             wait for CLKP;
             x_0 <="00000101";
             x_1 <="00000110";
             wait for CLKP;
             x_0 <="00000111";
             x_1 <="00001000";
             wait for CLKP;
             x_0 <="00000000";
             x_1 <="00000000";
             wait for 4*CLKP;
             valid_in <= '0';
             wait for 100*CLKP;   
             end process;


end Behavioral;
