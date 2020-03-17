----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/09/2020 08:05:24 PM
-- Design Name: 
-- Module Name: shift_register_tb - Behavioral
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


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity shift_register_tb is
end shift_register_tb;

architecture bench of shift_register_tb is
    component shift_register is
            Port (
            shift_direction: in std_logic;
            si,pl,en,clk,rst: in std_logic;
            din: in std_logic_vector(3 downto 0);
            so : out std_logic
            );
    end component; 
        
    signal    shift_direction : std_logic := '0';
    signal    si,pl,en,clk,rst: std_logic := '0';
    signal    din:  std_logic_vector(3 downto 0) := (others => '0');
    signal    so :  std_logic := '0';
    
    constant CLOCK_SPEED: time := 10ps;

begin
-- User shift register component
    uut: shift_register
        port map(
        shift_direction => shift_direction,
        si=> si,
        pl=> pl,
        en => en,
        clk => clk,
        rst =>rst,
        din => din,
        so => so                    
        );
-- Clock generating proc:
    generate_clk:
            process
                begin
                    clk <= '0';
                    wait for CLOCK_SPEED / 2;
                    clk <= '1';
                    wait for CLOCK_SPEED/2 ; 
            end process;
   stimulus:
            process
                begin
            
                -- Parallel load testing for both directions 
                    shift_direction <= '0';
                    si  <= '0';                    
                    rst <= '1';
                    pl  <= '1';
                    en  <= '0';
                    din <= "1010";
                    wait for CLOCK_SPEED;
                -- Loaded 1010
                -- Expected so  = 0    
                    shift_direction <= '1';
                -- Loaded 1010
                    wait for CLOCK_SPEED;
                -- Expected so = 1    
                -- Testing right shifts with direction 0
                
                    pl <= '0';
                    en <= '1';
                    si <= '1';
                    shift_direction <= '0';
                    wait for CLOCK_SPEED;
                 -- Expected output is so = 0
                    si <= '0';
                    wait for CLOCK_SPEED;
                 -- Expected output is so = 1;
                    si <= '1';
                    wait for Clock_SPEED;
                 -- Expected output is s0 = 0
                    si <= '0';
                    wait for Clock_SPEED;
                 -- Expected output is s0 = 1
                 -- Testing Left Shifts                 
                    shift_direction <= '1';
                    for i in  0 to 3 loop
                        wait for Clock_SPEED;
                        -- Expected output is 0101
                    end loop; 
                 -- Testing Reset (shift right)
                    rst <= '0';
                    wait for CLOCK_SPEED;
                 -- Expected output is s0 =0
                 -- Testing Enable
                    rst <= '1';
                    pl <= '1';
                    si <= '0';
                    en <= '0';
                    shift_direction <= '1';
                    din <= "0100";
                    wait for CLOCK_SPEED;
                 -- Expected output so = 0
                    pl<='0';
                    en <='1';
                    wait for CLOCK_SPEED;
                 -- Expected output so = 0
                    wait for CLOCK_SPEED;
                 -- Expected output so= 1;           
   end process stimulus;   
   
end bench;
