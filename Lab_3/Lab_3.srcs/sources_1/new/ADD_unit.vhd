library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ADD_unit is
    Port ( 
            mul_res  : in std_logic_vector (15 downto 0);
            acc      : in std_logic_vector (15 downto 0);
            clk      : in std_logic ;
            y_temp   : out std_logic_vector(15 downto 0)
            );
end ADD_unit;

architecture Behavioral of ADD_unit is

begin
            process(clk)
                begin
                    if (rising_edge(clk)) then
                        y_temp <= mul_res + acc ;
                    end if;    
            end process;

end Behavioral;
