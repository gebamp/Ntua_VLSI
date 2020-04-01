library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity rca_pipe is
    Port (
    a: in std_logic_vector (3 downto 0);
    b: in std_logic_vector (3 downto 0);
    c_in: in std_logic;
    clk: in std_logic;
    rst: in std_logic;
    s: out std_logic_vector (3 downto 0);
    c_out: out std_logic
     );
end rca_pipe;

architecture Behavioral of rca_pipe is

component fa_seq is
Port ( A     : in STD_LOGIC;
       B     : in STD_LOGIC; 
       C_in  : in STD_LOGIC;
       Clk   : in STD_LOGIC;
       reset : in STD_LOGIC;
       C_out  : out STD_LOGIC;
       SUM    : out STD_LOGIC );
end component;
       
signal reg1a,reg1b: std_logic_vector(3 downto 0);
signal reg2a,reg2b: std_logic_vector(2 downto 0);
signal reg3a,reg3b: std_logic_vector(1 downto 0);
signal reg4a,reg4b: std_logic;
signal tmp_sum1: std_logic;
signal tmp_sum2: std_logic_vector(1 downto 0);
signal tmp_sum3: std_logic_vector(2 downto 0);
signal tmp_sum4: std_logic_vector(3 downto 0);
signal c0,c1,c2,c3,c4: std_logic;

begin

move_to_next_reg: process(clk)
begin
    if (rising_edge(clk)) then
        reg1a<=a;
        reg1b<=b;
        reg2a(0)<=reg1a(1); reg2a(1)<=reg1a(2); reg2a(2)<=reg1a(3);
        reg2b(0)<=reg1b(1); reg2b(1)<=reg1b(2); reg2b(2)<=reg1b(3);
        reg3a(0)<=reg2a(1); reg3a(1)<=reg2a(2);
        reg3b(0)<=reg2b(1); reg3b(1)<=reg2b(2);
        reg4a<=reg3a(1);
        reg4b<=reg3b(1);
        c0<=c_in;
     end if;
end process;

move_to_next_sum: process (clk)
begin
    if (rising_edge(clk)) then
        tmp_sum2(0)<=tmp_sum1;
        tmp_sum3(1 downto 0)<=tmp_sum2;
        tmp_sum4(2 downto 0)<=tmp_sum3;
     end if;
end process;
s<=tmp_sum4;
c_out<=c4;
fa1: fa_seq port map(
    a=>reg1a(0),
    b=>reg1b(0),
    c_in=>c0,
    clk=>clk,
    reset=>rst,
    c_out=>c1,
    sum=>tmp_sum1
    );
    
fa2: fa_seq port map(
     a=>reg2a(0),
     b=>reg2b(0),
     c_in=>c1,
     clk=>clk,
     reset=>rst,
     c_out=>c2,
     sum=>tmp_sum2(1)
     );
        
fa3: fa_seq port map(
     a=>reg3a(0),
     b=>reg3b(0),
     c_in=>c2,
     clk=>clk,
     reset=>rst,
     c_out=>c3,
     sum=>tmp_sum3(2)
     );
     
fa4: fa_seq port map(
     a=>reg4a,
     b=>reg4b,
     c_in=>c3,
     clk=>clk,
     reset=>rst,
     c_out=>c4,
     sum=>tmp_sum4(3)
     );

end Behavioral;

