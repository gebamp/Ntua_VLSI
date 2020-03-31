
--library IEEE;
--use IEEE.STD_LOGIC_1164.ALL;

--entity RCA_pipe_tb is
--end RCA_pipe_tb;

--architecture Behavioral of RCA_pipe_tb is
--component RCA_pipe
--Port( x: in STD_LOGIC_VECTOR(3 downto 0);
--      y: in STD_LOGIC_VECTOR(3 downto 0);
--      RCA_Cin: in STD_LOGIC;
--      clk: in STD_LOGIC;
--      rst: in STD_LOGIC;
--      s: out STD_LOGIC_VECTOR(3 downto 0);
--      RCA_Cout: out STD_LOGIC
--      );
--end component;

----Input Signals
--signal a: std_logic_vector (3 downto 0):= (others=>'0');
--signal b: std_logic_vector (3 downto 0):= (others=>'0');
--signal c_in: std_logic:= '0';
--signal clk: std_logic:='0';
--signal rst: std_logic:='0';

----Output Signals
--signal s: std_logic_vector(3 downto 0);
--signal c_out: std_logic;

----Clock
--constant CLKP : time := 100ps;

--begin
--UUT: rca_pipe port map(
--    x=>a,
--    y=>b,
--    Rca_cin=>c_in,
--    clk=>clk,
--    rst=>rst,
--    s=>s,
--    RCA_cout=>c_out
--    );

--clk_proc: process
--    begin
--        clk <= '0';
--        wait for CLKP/2;
--        clk <= '1';
--        wait for CLKP/2;
--    end process;
--tests: process
--    begin
--    rst<='0';
--    a<="1000";
--    b<="1001";
--    c_in<='0';
--    wait for CLKP;
--    a<="0010";
--    b<="0001";
--    wait for CLKP;
--    a<="0100";
--    b<="0100";
--    wait for CLKP;
--    a<="1111";
--    b<="1111";
--    wait for CLKP;
--    a<="1010";
--    b<="1010";  
--    wait for CLKP; 
--   end process;


--end Behavioral;
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 29.03.2020 15:32:54
-- Design Name: 
-- Module Name: rca_pipe_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rca_pipe_tb is
end rca_pipe_tb;

architecture test_bench of rca_pipe_tb is

component rca_pipe
Port (
    a: in std_logic_vector (3 downto 0);
    b: in std_logic_vector (3 downto 0);
  c_in: in std_logic;
    clk: in std_logic;
    rst: in std_logic;
    s: out std_logic_vector (3 downto 0);
    c_out: out std_logic
     );
end component;

--Input Signals
signal a: std_logic_vector (3 downto 0):= (others=>'0');
signal b: std_logic_vector (3 downto 0):= (others=>'0');
signal c_in: std_logic:= '0';
signal clk: std_logic:='0';
signal rst: std_logic:='0';

--Output Signals
signal s: std_logic_vector(3 downto 0);
signal c_out: std_logic;

--Clock
constant CLKP : time := 1000ps;

begin
UUT: rca_pipe port map(
    a=>a,
    b=>b,
    c_in=>c_in,
    clk=>clk,
    rst=>rst,
    s=>s,
    c_out=>c_out
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

rst<='0';
a<="1000";
b<="1001";
c_in<='0';
wait for CLKP;
a<="0010";
b<="0001";
wait for CLKP;
a<="0100";
b<="0100";
wait for CLKP;
a<="1111";
b<="1111";
wait for CLKP;


end process;

end test_bench;
