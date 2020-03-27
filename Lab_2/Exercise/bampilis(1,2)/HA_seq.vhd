library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity HA_seq is
        Port ( a: in STD_LOGIC;
               b: in STD_LOGIC;
               CLK: in STD_LOGIC;
               RESET: in STD_LOGIC;
               s,c: out STD_LOGIC);
end HA_seq;

architecture my_arch of HA_seq is
begin
  process(clock)
        begin
            if(rising_edge(clock)) then
                if(reset = '1') then
                    s<='0';
                    c<='0';
                else  
                    s<= a xor b;
                    c<= a and b;
                end if;
            end if;
  end process;
end my_arch;
