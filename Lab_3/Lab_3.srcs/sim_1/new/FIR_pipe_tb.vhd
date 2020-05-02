library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;

entity FIR_pipe_tb is
end FIR_pipe_tb;

architecture Behavioral of FIR_pipe_tb is
constant data_width, coeff_width,min_vector_size : integer := 8;
component FIR_PIPE is
      generic(
        data_width :   integer    := 8;
        coeff_width:   integer    := 8;
        min_vector_size: integer  := 8
    );
      Port ( 
      x : in std_logic_vector(data_width-1 downto 0);
      clk : in std_logic;
      rst : in std_logic;
      valid_in : in std_logic;
      valid_out : out std_logic;
      y : out std_logic_vector((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1  downto 0) 
      );
end component;

--Input Signals
signal clk: std_logic:='0';
signal rst: std_logic:='0';
signal valid_in: std_logic:='0';
signal x : std_logic_vector(data_width-1 downto 0):=(others=>'0');
signal valid_out: std_logic:='0';

--output signals
signal y : std_logic_vector((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1  downto 0):=(others=>'0');

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
UUT: FIR_pipe port map(
         x => x,
         clk => clk,
         rst => rst,
         valid_in => valid_in,
         valid_out => valid_out,
         y => y
         );
    
TEST: 
             process
             begin
             valid_in <= '1';
             x <="00000001";
             wait for CLKP;
             x <="00000010";
             wait for CLKP;
             x <="00000011";
             wait for CLKP;
             x <="00000100";
             wait for CLKP;
             x <="00000101";
             wait for CLKP;
             x <="00000110";
             wait for CLKP;
             x <="00000111";
             wait for CLKP;
             x <="00001000";
             wait for CLKP;
              x <="00000000";
             wait for 7*CLKP; 
             valid_in <= '0';
             wait for 92*CLKP;   
             end process;


end Behavioral;
