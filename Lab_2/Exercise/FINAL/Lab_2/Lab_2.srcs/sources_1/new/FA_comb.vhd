library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity FA_comb is
    Port ( A,B,C_in: in STD_LOGIC;
           C_out,SUM: out STD_LOGIC );
end FA_comb;

architecture Structural of FA_comb is
signal HA1_S: STD_LOGIC;
signal HA1_C: STD_LOGIC;
signal HA2_C: STD_LOGIC;

component HA is
    port(
        a_ha: in STD_LOGIC;
        b_ha: in STD_LOGIC;
        c_ha: out STD_LOGIC;
        s_ha: out STD_LOGIC
        );
end component;
component OR_GATE is
    port(
        a_or: in STD_LOGIC;
        b_or: in STD_LOGIC;
        o_or: out STD_LOGIC
        )
        ;
end component;
        
begin
    ha_1: HA
         port map(
             a_ha => A,
             b_ha => B,
             c_ha => HA1_C,
             s_ha => HA1_S
         );
    ha_2: HA
         port map(
             a_ha => HA1_S,
             b_ha => C_in,
             s_ha => SUM,
             c_ha => HA2_C
            );
   c_or: OR_GATE
         port map(
            a_or => HA1_C,
            b_or => HA2_C,
            o_or => C_out
            );
end Structural;
