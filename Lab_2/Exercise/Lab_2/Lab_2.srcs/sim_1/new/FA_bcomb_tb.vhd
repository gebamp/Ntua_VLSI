library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity FA_bcomb_tb is
end FA_bcomb_tb;

architecture test_bench of FA_bcomb_tb is
component FA_comb_beh 
port(
    A: in STD_LOGIC;
    B: in STD_LOGIC;
    C_in: in STD_LOGIC;
    C_out: out STD_LOGIC;
    SUM: out STD_LOGIC
    );
end component;

--Input Signals
signal  counter: STD_LOGIC_VECTOR(2 downto 0):= (others=>'0');
--Output Signals
signal SUM: STD_LOGIC;
signal C_out: STD_LOGIC;
begin

UUT: FA_comb_beh port map(
    A=>counter(2),
    B=>counter(1),
    C_in=>counter(0),
    C_out=>C_out,
    SUM=>SUM
    );
    
tests: process
begin
    for i in 0 to 7 loop
        wait for 10 ps;
        counter <= std_logic_vector(to_unsigned(i,3));      
    end loop;
    end process;

end test_bench;
