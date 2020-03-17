----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.03.2020 23:14:24
-- Design Name: 
-- Module Name: up_counter_with_upper_limit_tb - Behavioral
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

entity Up_Counter_With_Upper_Limit_tb is
end Up_Counter_With_Upper_Limit_tb;

architecture test_bench of Up_Counter_With_Upper_Limit_tb is
component Up_Counter_With_Upper_Limit
port (
    clk: in std_logic;
    count_en: in std_logic;
    resetn: in std_logic;
    upper_limit: in std_logic_vector(2 downto 0 );
    cout: out std_logic;
    sum: out std_logic_vector(2 downto 0)
    );
  end component;
  
  --Input Signals
    signal clk : std_logic := '0';
    signal count_en: std_logic := '0';
    signal resetn: std_logic := '0';
    signal upper_limit: std_logic_vector(2 downto 0) := (others => '0');
    
    --Output Signals
    signal cout: std_logic;
    signal sum: std_logic_vector(2 downto 0);
    
    --Clock
    constant CLKP : time := 10ps;


begin
UUT: up_counter_with_upper_limit port map(
        clk => clk,
        count_en => count_en,
        resetn => resetn,
        upper_limit => upper_limit,
        cout => cout,
        sum => sum
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
       -- Test count up with upper limit
       count_en <= '1';
       resetn <= '1';
       upper_limit <= "110";
       wait for CLKP;
       wait for CLKP;
       wait for CLKP;
       wait for CLKP;
       count_en <= '0';
       wait for CLKP;
       wait for CLKP;
       count_en<='1';
       wait for CLKP;
       wait for CLKP;
       wait for CLKP;
       wait for CLKP;
       wait for CLKP;
       resetn <= '0';
       wait for CLKP/2;
       resetn<='1';
       upper_limit <= "011";
       wait for CLKP/2;
       wait for CLKP;
       wait for CLKP;
       wait for CLKP;
       
       
       
       
    end process;

end test_bench;
