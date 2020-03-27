library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity FA_comb_beh is
        Port ( A: in STD_LOGIC;
               B: in STD_LOGIC;
               C_in: in STD_LOGIC;
               C_out: out STD_LOGIC;
               SUM: out STD_LOGIC );
end FA_comb_beh;

architecture Behavioral of FA_comb_beh is

begin
    process(A,B,C)
        begin
            SUM <= A+B;
            if((A and B ='1') or (A and C_in='1') or(C and B = '1')) then
                C_out <= '1';
            else
                C_out <='0';    
            end if;
    end process;

end Behavioral;
