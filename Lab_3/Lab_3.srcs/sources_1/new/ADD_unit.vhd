library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;

entity ADD_unit is
        generic(
            data_width :   integer    := 8;
            coeff_width:   integer    := 8;
            min_vector_size: integer  := 8
        );
    Port ( 
            mul_res  : in std_logic_vector (data_width+coeff_width-1 downto 0);
            acc      : in std_logic_vector ((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1 downto 0);
            clk      : in std_logic ;
            y_temp   : out std_logic_vector((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1  downto 0)
            );
end ADD_unit;

architecture Behavioral of ADD_unit is

begin
            process(clk)
                begin
                    if (rising_edge(clk)) then
                        y_temp <=  (mul_res + acc) ;
                    end if;    
            end process;

end Behavioral;
