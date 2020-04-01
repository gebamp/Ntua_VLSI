library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity FA_seq_tb is
end FA_seq_tb;

architecture test_bench of FA_seq_tb is

component FA_seq
port(
    A: in STD_LOGIC;
    B: in STD_LOGIC;
    C_in: in STD_LOGIC;
    Clk: in STD_LOGIC;
    reset: in STD_LOGIC;
    C_out: out STD_LOGIC;
    SUM: out STD_LOGIC
    );
end component;

--Input Signals
signal A_B_Cin : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
signal Clk: STD_LOGIC:='0';
signal reset: STD_LOGIC:='0';

--Output Signals
signal C_out: STD_LOGIC;
signal SUM: STD_LOGIC;

--Clock
    constant CLKP : time := 10ps;
    
begin

UUT: FA_seq port map(
    A=>A_B_Cin(2),
    B=>A_B_Cin(1),
    C_in=>A_B_Cin(0),
    Clk=>Clk,
    reset=>reset,
    C_out=>C_out,
    SUM=>SUM
    );

clk_proc: process
    begin
        clk <= '0';
        wait for CLKP/2;
        clk <= '1';
        wait for CLKP/2;
    end process;
    
tests: process
    begin
        
        for i in 0 to 7 loop
            reset<='0';
            A_B_Cin <= std_logic_vector(to_unsigned(i,3));
            wait for CLKP;      
        end loop;
        -- Checking if reset works
        reset<='1';
        A_B_Cin <= "111";
        wait for CLKP;
        reset<='0';
        A_B_Cin <= "111";
        wait for CLKP;        
    
    end process;


end test_bench;
