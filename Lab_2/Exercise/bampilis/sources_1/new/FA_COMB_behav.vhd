library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity FA_comb_beh is
        Port ( A: in STD_LOGIC;
               B: in STD_LOGIC;
               C_in: in STD_LOGIC;
               C_out: out STD_LOGIC;
               SUM: out STD_LOGIC );
end FA_comb_beh;

architecture Behavioral of FA_comb_beh is
signal addition_vector: std_logic_vector(1 downto 0);
signal a_temp : std_logic_vector(1 downto 0);
signal b_temp : std_logic_vector(1 downto 0);
signal c_in_temp : std_logic_vector(1 downto 0);

begin
    process(A,B,C_in)
        begin
        a_temp<= '0'& a;
        b_temp<= '0'& b;
        c_in_temp<= '0'& c_in;
        addition_vector<= a_temp + b_temp + c_in_temp;
        SUM <= addition_vector(0);
        C_out <= addition_vector(1);
    end process;

end Behavioral;
