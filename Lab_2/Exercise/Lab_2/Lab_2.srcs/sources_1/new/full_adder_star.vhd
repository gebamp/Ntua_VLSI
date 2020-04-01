library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity full_adder_star is
    Port ( 
    a,b: in std_logic;
    c_in: in std_logic;
    s_in: in std_logic;
    clk: in std_logic;
    rst: in std_logic;
    c_out: out std_logic;
    s_out: out std_logic
    );
end full_adder_star;

architecture Behavioral of full_adder_star is

component fa_seq is
Port (     A     : in STD_LOGIC;
           B     : in STD_LOGIC; 
           C_in  : in STD_LOGIC;
           Clk   : in STD_LOGIC;
           reset : in STD_LOGIC;
           C_out  : out STD_LOGIC;
           SUM    : out STD_LOGIC );
end component;

signal a_and_b: std_logic;

begin
a_and_b<=a and b;

fa1: fa_seq port map(
    a=>s_in,
    b=>a_and_b,
    c_in=>c_in,
    clk=>clk,
    reset=>rst,
    c_out=>c_out,
    sum=>s_out
    );

end Behavioral;
