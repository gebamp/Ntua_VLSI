----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/09/2020 11:09:04 AM
-- Design Name: 
-- Module Name: decoder_dec_behav_tb - Behavioral
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
use IEEE.numeric_std.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decoder_dec_behav_tb is
end decoder_dec_behav_tb;

architecture bench of decoder_dec_behav_tb is
    component decoder is
        port(
            encode: in std_logic_vector(2 downto 0);
            decode: out std_logic_vector(7 downto 0)
            );
    end component;
    
    signal encode : std_logic_vector(2 downto 0) := (others => '0');
    signal decode : std_logic_vector(7 downto 0);
    constant TIME_DELAY: time := 10 ps; 
begin
    uut: decoder
        port map (
            encode => encode,
            decode => decode
        );

    stimulus : process
            
            begin
                for i in 0 to 7 loop
                    encode <= std_logic_vector(to_unsigned(i,3));
                    wait for TIME_DELAY;
                end loop;
                
             end process stimulus;
                
end bench;
