library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MAC is
    Port (
        rom_out: in std_logic_vector(7 downto 0);
        ram_out: in std_logic_vector(7 downto 0);
        mac_init : in std_logic;
        L: out std_logic_vector(15  downto 0);
        clk : in std_logic
    );
end MAC;

architecture Behavioral of MAC is
        signal accumulator : std_logic_vector(15 downto 0):= (others => '0') ;               
begin
        process(clk)
            begin 
                 if (rising_edge(clk)) then
                        if mac_init = '1' then
                            accumulator <= (others => '0');
                            accumulator <= (ram_out * rom_out);
                        else 
                            accumulator <= accumulator + (ram_out * rom_out); 
                        end if;
                        L <= accumulator;
                 end if;
        end process;
end Behavioral;
