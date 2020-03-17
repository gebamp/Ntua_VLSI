----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/09/2020 12:46:21 AM
-- Design Name: 
-- Module Name: up_counter_with_upper_limit - Behavioral
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

entity Up_Counter_With_Upper_Limit is
       Port ( 
        clk,count_en,resetn: in std_logic;
        upper_limit: in std_logic_vector(2 downto 0);
        cout: out std_logic;
        sum:  out std_logic_vector(2 downto 0)
        
        );
end up_counter_with_upper_limit;

architecture Behavioral of Up_Counter_With_Upper_Limit is
signal count: std_logic_vector(2 downto 0);
begin
    counting:   process(clk,resetn)
                    begin
                        if (resetn = '0') then
                            count <= (others => '0');
                        elsif (rising_edge(clk)) then
                            if (count_en = '1') then
                                if(count /= upper_limit) then
                                    count <= count+1;
                                else 
                                    count <= (others => '0');
                                end if;
                            end if;
                       end if;
                end process counting;     
                
                sum <= count;
                cout <= '1' when (count = upper_limit and count_en = '1') 
                             else '0';
end Behavioral;
