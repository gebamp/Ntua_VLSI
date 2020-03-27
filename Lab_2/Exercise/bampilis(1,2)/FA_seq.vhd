library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FA_seq is
    Port ( A     : in STD_LOGIC;
           B     : in STD_LOGIC; 
           C_in  : in STD_LOGIC;
           Clk   : in STD_LOGIC;
           reset : in STD_LOGIC;
           C_out  : out STD_LOGIC;
           SUM    : out STD_LOGIC );
end FA_seq;

architecture Structural of FA_seq is

signal HA1_S: STD_LOGIC;
signal HA1_C: STD_LOGIC;
signal HA2_C: STD_LOGIC;
signal temp_sum: STD_LOGIC;
signal temp_Cout: STD_LOGIC; 


component HA_seq is
    port(
        a: in STD_LOGIC;
        b: in STD_LOGIC;
        c: out STD_LOGIC;
        s: out STD_LOGIC;
        ha_clk: in STD_LOGIC;
        ha_reset: in STD_LOGIC
        );
end component;
component OR_GATE_seq is
    port(
        a: in STD_LOGIC;
        b: in STD_LOGIC;
        o: out STD_LOGIC;
        or_gate_clk: in STD_LOGIC;
        or_gate_reset: in STD_LOGIC
        )
        ;
end component;
    
begin
    ha_1: HA_seq
         port map(
             a_ha => A,
             b_ha => B,
             c_ha => HA1_C,
             s_ha => HA1_S,
             ha_clk => Clk,
             ha_reset => reset
         );
    ha_2: HA_seq
         port map(
             a_ha => HA1_S,
             b_ha => C_in,
             s_ha => SUM,
             c_ha => HA2_C,
             ha_clk => Clk,
             ha_reset => reset
            );
   c_or: OR_GATE_seq
         port map(
            a_or => HA1_C,
            b_or => HA2_C,
            o_or => C_out,
            or_clk => Clk,
            or_reset => reset
            );
end Structural;
