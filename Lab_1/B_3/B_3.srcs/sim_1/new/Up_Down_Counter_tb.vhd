----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.03.2020 20:06:55
-- Design Name: 
-- Module Name: Up_Down_Counter_tb - Behavioral
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

entity Up_Down_Counter_tb is
end Up_Down_Counter_tb;

architecture test_bench of Up_Down_Counter_tb is
 --Component Declaration
 component Up_Down_Counter
 port (
    clk: in std_logic;
    count_en: in std_logic;
    resetn: in std_logic;
    c_direction: in std_logic;
    cout: out std_logic;
    sum: out std_logic_vector(2 downto 0)
    );
  end component;
  
  --Input Signals
  signal clk : std_logic := '0';
  signal count_en: std_logic := '0';
  signal resetn: std_logic := '0';
  signal c_direction: std_logic := '0';
  
  --Output Signals
  signal cout: std_logic;
  signal sum: std_logic_vector(2 downto 0);
  
  --Clock
  constant CLKP : time := 10ps;

begin
    UUT:Up_Down_Counter port map(
        clk => clk,
        count_en => count_en,
        resetn => resetn,
        c_direction => c_direction,
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
    
    -- Test resetn and c_direction, c_direction =0 (up counter)
    c_direction <= '0';
    resetn <= '0';
    wait for CLKP;
    count_en <= '1';         -- full count up to 7
    resetn <= '1';   
    wait for CLKP;
    wait for CLKP;
    wait for CLKP;
    wait for CLKP;
    wait for CLKP;
    wait for CLKP;
    wait for CLKP;
    
    resetn <= '0';
    wait for CLKP/2;
    resetn <= '1';
    count_en <='0';          -- reset in te middle of count up
    wait for CLKP/2;
    count_en <='1'; 
    wait for CLKP;
    wait for CLKP;
    resetn <= '0';
    wait for CLKP/4;
    resetn <= '1';
    wait for CLKP /4;
    wait for CLKP /2;
    wait for CLKP;
    wait for CLKP;
    
    -- Test resetn and c_direction = 1 (down counter)
    c_direction <= '1';
    resetn <= '0';
    wait for CLKP/2;
    resetn<='1';
    wait for CLKP/2;
    wait for CLKP;
    wait for CLKP;
    wait for CLKP;
    wait for CLKP;
    wait for CLKP;
    wait for CLKP;
    resetn<= '0';
    wait for CLKP/2;
    resetn<= '1';               -- reset in the middle of count down
    wait for CLKP/2;
    wait for CLKP;
    wait for CLKP;
    
    -- Test enable when counting up
    c_direction <= '0'; 
    resetn <= '0';
    wait for CLKP/2;
    resetn <= '1';    
    wait for CLKP/2;
    wait for CLKP;
    wait for CLKP;
    count_en <= '0';
    wait for CLKP;
    wait for CLKP;
    count_en <= '1';
    wait for CLKP;
    c_direction <= '1';
    resetn<='0';
    wait for CLKP/2;
    
    -- Test enable when counting down
    resetn<='1';
    wait for CLKP/2;
    wait for CLKP;
    wait for CLKP;
    wait for CLKP;
    count_en <= '0';
    wait for CLKP;
    wait for CLKP;
    count_en <= '1';
    wait for CLKP;
    wait for CLKP;
       
    end process;
        


end test_bench;
