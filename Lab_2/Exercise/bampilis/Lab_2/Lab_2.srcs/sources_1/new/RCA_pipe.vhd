library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RCA_pipe is
         Port( x: in STD_LOGIC_VECTOR(3 downto 0);
               y: in STD_LOGIC_VECTOR(3 downto 0);
               RCA_Cin: in STD_LOGIC;
               clk: in STD_LOGIC;
               rst: in STD_LOGIC;
               s: out STD_LOGIC_VECTOR(3 downto 0);
               RCA_Cout: out STD_LOGIC
      );
end RCA_pipe;

architecture Behavioral of RCA_pipe is
component fa_seq is
Port ( A     : in STD_LOGIC;
       B     : in STD_LOGIC; 
       C_in  : in STD_LOGIC;
       Clk   : in STD_LOGIC;
       reset : in STD_LOGIC;
       C_out  : out STD_LOGIC;
       SUM    : out STD_LOGIC );
end component;

signal x1_reg: STD_LOGIC_VECTOR(3 downto 0);
signal y1_reg: STD_LOGIC_VECTOR(3 downto 0);
signal x2_reg: STD_LOGIC_VECTOR(2 downto 0);
signal y2_reg: STD_LOGIC_VECTOR(2 downto 0);
signal x3_reg: STD_LOGIC_VECTOR(1 downto 0);
signal y3_reg: STD_LOGIC_VECTOR(1 downto 0);
signal x4_reg: STD_LOGIC;
signal y4_reg: STD_LOGIC;
signal sum_4: STD_LOGIC_Vector(3 downto 0);
signal sum_3: STD_LOGIC_Vector(2 downto 0);
signal sum_2: STD_LOGIC_Vector(1 downto 0);
signal sum_1: STD_LOGIC;
signal c0_reg,c1_reg,c2_reg,c3_reg,c4_reg: STD_LOGIC;

begin
fa1: fa_seq port
              map(
                      A=>x1_reg(0),
                      B=>y1_reg(0),
                      C_in => c0_reg,
                      clk=>clk,
                      reset=>'0',
                      C_out => c1_reg,
                      SUM   => sum_1);
fa2: fa_seq port
              map(
                      A=>x2_reg(0),
                      B=>y2_reg(0),
                      C_in => c1_reg,
                      clk=>clk,
                      reset=>'0',
                      C_out => c2_reg,
                      SUM => sum_2(1));
fa3: fa_seq port
              map(
                      A=>x3_reg(0),
                      B=>y3_reg(0),
                      C_in => c2_reg,
                      clk=>clk,
                      reset=>'0',
                      C_out => c3_reg,
                      SUM => sum_3(2));
fa4: fa_seq port
              map(
                      A=>x4_reg,
                      B=>y4_reg,
                      C_in => c3_reg,
                      clk=>clk,
                      reset=>'0',
                      C_out => c4_reg,
                      SUM=> sum_4(3));
 
     process(clk)
              begin
                    if(rising_edge(clk)) then
                        x1_reg <= x;
                        y1_reg <= y;
                        c0_REG<= RCA_Cin;
                        x2_reg <= x1_reg( 3 downto 1);
                        y2_reg <= y1_reg( 3 downto 1);
                        x3_reg <= x2_reg( 2 downto 1);
                        y3_reg <= y2_reg( 2 downto 1);
                        x4_reg <= x3_reg(1);
                        y4_reg <= y3_reg(1);
                    end if;
              end process;
     process(clk)
              begin
                   if(rising_edge(clk)) then
                        sum_2(0)<=sum_1;
                        sum_3( 1 downto 0) <= sum_2;
                        sum_4( 2 downto 0) <= sum_3;
                        if (rst = '1') then
                        s<="0000";
                        RCA_Cout<='0';
                        else
                        s <= sum_4;
                        RCA_Cout <= c4_reg;
                        end if;
                   end if;
              end process;

end Behavioral;
