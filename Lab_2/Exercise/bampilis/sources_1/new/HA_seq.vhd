library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity HA_seq is
        Port ( a_ha: in STD_LOGIC;
               b_ha: in STD_LOGIC;
               ha_clk: in STD_LOGIC;
               ha_reset: in STD_LOGIC;
               s_ha,c_ha: out STD_LOGIC);
end HA_seq;

architecture my_arch of HA_seq is
begin
  process(ha_clk)
        begin
            if(rising_edge(ha_clk)) then
                if(ha_reset = '1') then
                    s_ha<='0';
                    c_ha<='0';
                else  
                    s_ha<= a_ha xor b_ha;
                    c_ha<= a_ha and b_ha;
                end if;
            end if;
  end process;
end my_arch;
