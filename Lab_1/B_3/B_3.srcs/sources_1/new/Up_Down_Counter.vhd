----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/08/2020 11:20:32 PM
-- Design Name: 
-- Module Name: Up_Down_Counter - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Up_Down_Counter is
    Port ( 
          clk,count_en,resetn: in std_logic;
          c_direction: in std_logic;
          cout: out std_logic;
          sum:  out std_logic_vector(2 downto 0)
    );
end Up_Down_Counter;

architecture Behavioral of Up_Down_Counter is
signal count: std_logic_vector(2 downto 0);
begin
    counting:   process(clk,resetn)
                    begin 
                        if(resetn='0') then
                            case c_direction is
                            when '0' => count <= (others => '0');
                            when others => count <= (others => '1');
                            end case;
                        elsif (rising_edge(clk)) then
                            if(count_en = '1') then
                                case c_direction is
                                    when '0' => count <= count + 1;
                                    when others => count <= count - 1;
                                end case;
                            end if;
                        end if;
                end process counting;
                
                sum <= count ;
                
                cout <= '1' when ((count = 7 and count_en = '1' and c_direction = '0') or (count = 0 and count_en = '1' and c_direction = '1'))
                            else '0';
end Behavioral;
