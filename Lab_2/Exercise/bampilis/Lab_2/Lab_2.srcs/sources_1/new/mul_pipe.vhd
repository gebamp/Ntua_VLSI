library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--ta apotelesmata pou phgainoun sto s einai out
--ta apotelesmata pou den pane amesa sto s einai temp_out
--ama exei 1 tempout einai stdlogic
-- ama exei 2 tempout einai vector to 0 einai to pio panw
-- ama exoume enan kaktaxwrhth sto epipedo pipeline i exei kratoumeno ci
-- ama exoume 2 kataxwrhtes sto epipedo pipeline i exoun kratoumeno cij opou j to b epipedo tou kataxwrhth
--regi a: oi registers pipeline meta to epipedo pipeline i
-- outi kai tmp_outi: oi registers gia to apotelesma h tmp apotelesma meta to epipedo pipeline i
-- fasi: o full adder sto epipedo i
-- fasi_1: o full adder sto epipedo i pou vrisketai pio panw sto sxhma

entity mul_pipe is
    Port (
    a: in std_logic_vector(3 downto 0);
    b: in std_logic_vector(3 downto 0);
    s_in: in std_logic_vector(3 downto 0);
    clk: in std_logic;
    rst: in std_logic;
    c_in: in std_logic;
    p: out std_logic_vector(7 downto 0)
         );
end mul_pipe;

architecture Behavioral of mul_pipe is

component full_adder_star is
Port ( 
    a,b: in std_logic;
    c_in: in std_logic;
    s_in: in std_logic;
    clk: in std_logic;
    rst: in std_logic;
    c_out: out std_logic;
    s_out: out std_logic
    );
end component;

signal reg0a,reg0b: std_logic_vector(3 downto 0); --clk0
signal reg1a,reg1b: std_logic_vector(3 downto 0); --clk1
signal c1: std_logic;
signal out1: std_logic;
signal reg2a,reg2b: std_logic_vector(3 downto 0); --clk2
signal c2: std_logic;
signal tmp_out2: std_logic;
signal out2: std_logic;
signal reg3a,reg3b: std_logic_vector(3 downto 0); --clk3
signal c30,c31: std_logic;
signal out3: std_logic_vector(1 downto 0);
signal tmp_out3: std_logic;
signal reg4a: std_logic_vector(3 downto 0); --clk4
signal reg4b: std_logic_vector(2 downto 0);
signal c40,c41: std_logic;
signal tmp_out4: std_logic_vector(1 downto 0);
signal out4: std_logic_vector(1 downto 0);
signal reg5a: std_logic_vector(3 downto 0); --clk5
signal reg5b: std_logic_vector(2 downto 0);
signal c51,c52: std_logic;
signal tmp_out5: std_logic;
signal out5: std_logic_vector(2 downto 0);
signal reg6a: std_logic_vector(3 downto 0); --clk6
signal reg6b: std_logic_vector(1 downto 0);
signal c61,c62: std_logic;
signal tmp_out6: std_logic_vector(1 downto 0);
signal out6: std_logic_vector(2 downto 0);
signal reg7a: std_logic_vector(2 downto 0); --clk7
signal reg7b: std_logic_vector(1 downto 0);
signal c72,c73: std_logic;
signal tmp_out7: std_logic;
signal out7: std_logic_vector(3 downto 0);
signal reg8a: std_logic_vector(1 downto 0); --clk8
signal reg8b: std_logic;
signal c82,c83: std_logic;
signal tmp_out8: std_logic;
signal out8: std_logic_vector(4 downto 0);
signal reg9a: std_logic; --clk 9
signal reg9b: std_logic;
signal c9: std_logic;
signal out9: std_logic_vector(5 downto 0);
signal out10: std_logic_vector(7 downto 0); --clk10
signal c4to6, c6to8, c8to10: std_logic;

begin

move_reg_0: process(clk)
begin
    if (rising_edge(clk)) then
    
        reg0a<=a;
        reg0b<=b;
        
        reg1a<=reg0a;
        reg1b<=reg0b;

        reg2a<=reg1a;
        reg2b<=reg1b;
        out2<=out1;

        reg3a<=reg2a;
        reg3b<=reg2b;
        out3(0)<=out2;

        reg4a<=reg3a;
        reg4b<=reg3b(3 downto 1);
        out4<=out3;

        reg5a<=reg4a;
        reg5b<=reg4b;
        out5(1 downto 0)<=out4;
        
        reg6a<=reg5a;
        reg6b<=reg5b(2 downto 1);
        out6<=out5;
        
        reg7a<=reg6a(3 downto 1);
        reg7b<=reg6b;
        out7(2 downto 0)<=out6; 

        reg8a<=reg7a(2 downto 1);
        reg8b<=reg7b(1);
        out8(3 downto 0)<=out7;
        
        reg9a<=reg8a(1);
        reg9b<=reg8b;
        out9(4 downto 0)<=out8;
        
        out10(5 downto 0)<=out9;
         
    end if;
end process;

carry: process(clk)
begin
    if (rising_edge(clk)) then
        c4to6<=c40;
        c6to8<=c61;
        c8to10<=c82;
     end if;
end process;

p<=out10;

fas1: full_adder_star port map(
    a=>reg0a(0),
    b=>reg0b(0),
    c_in=>c_in,
    s_in=>s_in(0),
    clk=>clk,
    rst=>rst,
    c_out=>c1,
    s_out=>out1);
    
fas2: full_adder_star port map(
    a=>reg1a(1),
    b=>reg1b(0),
    c_in=>c1,
    s_in=>s_in(1),
    clk=>clk,
    rst=>rst,
    c_out=>c2,
    s_out=>tmp_out2);
    
fas3_1: full_adder_star port map(
    a=>reg2a(2),
    b=>reg2b(0),
    c_in=>c2,
    s_in=>s_in(2),
    clk=>clk,
    rst=>rst,
    c_out=>c30,
    s_out=>tmp_out3);
    
fas3_2: full_adder_star port map(
    a=>reg2a(0),
    b=>reg2b(1),
    c_in=>c_in,
    s_in=>tmp_out2,
    clk=>clk,
    rst=>rst,
    c_out=>c31,
    s_out=>out3(1));
    
fas4_1: full_adder_star port map(
    a=>reg3a(3),
    b=>reg3b(0),
    c_in=>c30,
    s_in=>s_in(3),
    clk=>clk,
    rst=>rst,
    c_out=>c40,
    s_out=>tmp_out4(0));
    
fas4_2: full_adder_star port map(
    a=>reg3a(1),
    b=>reg3b(1),
    c_in=>c31,
    s_in=>tmp_out3,
    clk=>clk,
    rst=>rst,
    c_out=>c41,
    s_out=>tmp_out4(1));
    
fas5_1: full_adder_star port map(
    a=>reg4a(2),
    b=>reg4b(0),
    c_in=>c41,
    s_in=>tmp_out4(0),
    clk=>clk,
    rst=>rst,
    c_out=>c51,
    s_out=>tmp_out5);

fas5_2: full_adder_star port map(
    a=>reg4a(0),
    b=>reg4b(1),
    c_in=>c_in,
    s_in=>tmp_out4(1),
    clk=>clk,
    rst=>rst,
    c_out=>c52,
    s_out=>out5(2));

fas6_1: full_adder_star port map(
    a=>reg5a(3),
    b=>reg5b(0),
    c_in=>c51,
    s_in=>c4to6,
    clk=>clk,
    rst=>rst,
    c_out=>c61,
    s_out=>tmp_out6(0));

fas6_2: full_adder_star port map(
    a=>reg5a(1),
    b=>reg5b(1),
    c_in=>c52,
    s_in=>tmp_out5,
    clk=>clk,
    rst=>rst,
    c_out=>c62,
    s_out=>tmp_out6(1));   
    
fas7_1: full_adder_star port map(
    a=>reg6a(2),
    b=>reg6b(0),
    c_in=>c62,
    s_in=>tmp_out6(0),
    clk=>clk,
    rst=>rst,
    c_out=>c72,
    s_out=>tmp_out7);       
    
fas7_2: full_adder_star port map(
    a=>reg6a(0),
    b=>reg6b(1),
    c_in=>c_in,
    s_in=>tmp_out6(1),
    clk=>clk,
    rst=>rst,
    c_out=>c73,
    s_out=>out7(3));        

fas8_1: full_adder_star port map(
    a=>reg7a(2),
    b=>reg7b(0),
    c_in=>c72,
    s_in=>c6to8,
    clk=>clk,
    rst=>rst,
    c_out=>c82, 
    s_out=>tmp_out8);

fas8_2: full_adder_star port map(
    a=>reg7a(0),
    b=>reg7b(1),
    c_in=>c73,
    s_in=>tmp_out7,
    clk=>clk,
    rst=>rst,
    c_out=>c83,
    s_out=>out8(4));

fas9: full_adder_star port map(
    a=>reg8a(0),
    b=>reg8b,
    c_in=>c83,
    s_in=>tmp_out8,
    clk=>clk,
    rst=>rst,
    c_out=>c9,
    s_out=>out9(5));

fas10: full_adder_star port map(
    a=>reg9a,
    b=>reg9b,
    c_in=>c9,
    s_in=>c8to10,
    clk=>clk,
    rst=>rst,
    c_out=>out10(7),
    s_out=>out10(6));
    
end Behavioral;
