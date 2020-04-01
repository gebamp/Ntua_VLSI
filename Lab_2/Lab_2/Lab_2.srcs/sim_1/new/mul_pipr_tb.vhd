library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mul_pipe_tb is
end mul_pipe_tb;

architecture test_bench of mul_pipe_tb is

component mul_pipe

Port (
    a: in std_logic_vector(3 downto 0);
    b: in std_logic_vector(3 downto 0);
    s_in: in std_logic_vector(3 downto 0);
    clk: in std_logic;
    rst: in std_logic;
    c_in: in std_logic;
    p: out std_logic_vector(7 downto 0)
         );
end component;

--Input Signals
signal a: std_logic_vector(3 downto 0):= (others=>'0');
signal b: std_logic_vector(3 downto 0):= (others=>'0');
signal s_in: std_logic_vector(3 downto 0):= (others=>'0');
signal clk: std_logic:='0';
signal rst: std_logic:='0';
signal c_in: std_logic:='0';

--Output Signals
signal p: std_logic_vector(7 downto 0);

--Clock
constant CLKP : time := 100ns;

begin

UUT: mul_pipe port map(
    a=>a,
    b=>b,
    s_in=>s_in,
    clk=>clk,
    rst=>rst,
    c_in=>c_in,
    p=>p);

clk_proc: process
    begin
        clk <= '0';
        wait for CLKP/2;
        clk <= '1';
        wait for CLKP/2;
    end process;
    
tests: process
begin
rst<='0';

s_in<="0000";
c_in<='0';
a<="1111";
b<="1111";
wait for CLKP;
a<="1111";
b<="1010";
wait for CLKP;
a<="0101";
b<="0110";
wait for CLKP;
a<="0111";
b<="0110";
wait for CLKP;
a<="0111";
b<="1010";
wait for CLKP;
wait for CLKP;
wait for CLKP;
wait for CLKP;
wait for CLKP;
wait for CLKP;
wait for CLKP;
wait for CLKP;
wait for CLKP;
wait for CLKP;
wait for CLKP;

end process;






end test_bench;
