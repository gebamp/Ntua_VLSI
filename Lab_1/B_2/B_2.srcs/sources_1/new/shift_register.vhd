----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/08/2020 10:32:11 PM
-- Design Name: 
-- Module Name: shift_register - behavioural
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

entity shift_register is
    Port (
    shift_direction:in std_logic;
    si,pl,en,clk,rst: in std_logic;
    din: in std_logic_vector(3 downto 0);
    so : out std_logic);
end shift_register;

architecture my_shift_register of shift_register is
    signal dff: std_logic_vector(3 downto 0);
begin
    edge: process (clk,rst) 
        begin
            if(rst = '0') then 
                dff <= (others => '0');
            elsif(rising_edge(clk)) then
 -- or      elsif (clk'event and clk'='1') then
                if(pl = '1') then
                    dff <= din;
                elsif(en = '1') then
                    case shift_direction is
                        when '0' => dff <=   si & dff(3 downto 1)  ;
                        when '1' => dff <=   dff(2 downto 0) & si  ;
                        when others => null;
                    end case;
                end if;
            end if;
    end process edge;
    
    with shift_direction select 
    so <=  dff(0) when '0',
           dff(3) when '1';
     
end my_shift_register;
