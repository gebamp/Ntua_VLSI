library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;

entity MUL_unit is
        generic(
        data_width :   integer    := 8;
        coeff_width:   integer    := 8;
        min_vector_size: integer  := 8
        );
    Port ( 
        x         : in  std_logic_vector (data_width-1 downto 0);
        h         : in  std_logic_vector (coeff_width-1 downto 0);
        clk       : in  std_logic ;
        valid_in  : in  std_logic ;
        valid_out : out std_logic;
        mul_res   : out std_logic_vector(data_width+coeff_width-1 downto 0)
        );
end MUL_unit;

architecture Behavioral of MUL_unit is

begin
    process(clk)
        begin
            if(rising_edge(clk)) then
                if (valid_in = '1') then
                    mul_res <=  x * h ;
                 end if;
                 valid_out <= valid_in;
            end if;
    end process;
end Behavioral;
