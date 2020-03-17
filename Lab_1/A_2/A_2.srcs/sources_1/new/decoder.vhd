----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/07/2020 06:37:44 PM
-- Design Name: 
-- Module Name: decoder - Behavioral
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

entity decoder is
    Port ( 
    encode:in std_logic_vector(2 downto 0);
    decode:out std_logic_vector(7 downto 0)
    );
end decoder;

architecture dec_data of decoder is

begin
    with encode select 
    decode <=   "00000001" when "000",
                "00000010" when "001",
                "00000100" when "010",
                "00001000" when "011",
                "00010000" when "100",
                "00100000" when "101",
                "01000000" when "110",
                "10000000" when "111",
                "00000000" when others;
   
end dec_data;

architecture dec_behav of decoder is
begin

 decoder_3x8: process(encode)
begin
    case encode is
        when "000"  => decode <= "00000001";
        when "001"  => decode <= "00000010";
        when "010"  => decode <= "00000100";
        when "011"  => decode <= "00001000";
        when "100"  => decode <= "00010000";
        when "101"  => decode <= "00100000";
        when "110"  => decode <= "01000000";
        when "111"  => decode <= "10000000";
        when others => decode <= "00000000";
    end case;
end process decoder_3x8;                                                           
end dec_behav;
