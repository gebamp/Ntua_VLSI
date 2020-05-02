library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;


entity FIR_paral is
      generic(
        data_width :   integer    := 8;
        coeff_width:   integer    := 8;
        min_vector_size: integer  := 8
        );
      Port ( 
      x_0 : in std_logic_vector( data_width-1 downto 0);
      x_1 : in std_logic_vector( data_width-1 downto 0);
      clk : in std_logic;
      rst : in std_logic;
      valid_in : in std_logic;
      valid_out : out std_logic;
      y_0 : out std_logic_vector((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1 downto 0);
      y_1 : out std_logic_vector((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1 downto 0) 
      );

end FIR_paral;

architecture Behavioral of FIR_paral is
    component MUL_unit is
    generic(
        data_width :   integer    := 8;
        coeff_width:   integer    := 8;
        min_vector_size: integer  := 8
    );
    port(
    x         : in  std_logic_vector (data_width-1 downto 0);
    h         : in  std_logic_vector (coeff_width-1 downto 0);
    clk       : in  std_logic ;
    valid_in  : in  std_logic ;
    valid_out : out std_logic;
    mul_res   : out std_logic_vector(data_width+coeff_width-1 downto 0)        
    );
end component;
component ADD_unit is
    port(
    mul_res  : in std_logic_vector (data_width+coeff_width-1 downto 0);
    acc      : in std_logic_vector ((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1 downto 0);
    clk      : in std_logic ;
    y_temp   : out std_logic_vector((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1 downto 0)    
    );
end component;

type   x_register is array (6 downto 0) of std_logic_vector ( data_width-1 downto 0);
signal x_reg_up : x_register := (others => (others => '0'));
signal x_reg_dw : x_register := (others => (others => '0'));

type   coeff_mem is array (7 downto 0) of std_logic_vector ( coeff_width-1 downto 0);
signal coeff : coeff_mem :=( "00001000",
                              "00000111",
                              "00000110",
                              "00000101",
                              "00000100",
                              "00000011",
                              "00000010",
                              "00000001");
signal up_mul_out_1 : std_logic_vector (data_width+coeff_width-1 downto 0);
signal up_mul_out_2 : std_logic_vector (data_width+coeff_width-1 downto 0);
signal up_mul_out_3 : std_logic_vector (data_width+coeff_width-1 downto 0);
signal up_mul_out_4 : std_logic_vector (data_width+coeff_width-1 downto 0);
signal up_mul_out_5 : std_logic_vector (data_width+coeff_width-1 downto 0);
signal up_mul_out_6 : std_logic_vector (data_width+coeff_width-1 downto 0);
signal up_mul_out_7 : std_logic_vector (data_width+coeff_width-1 downto 0);
signal up_mul_out_8 : std_logic_vector (data_width+coeff_width-1 downto 0);

signal up_add_out_1 : std_logic_vector ((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1 downto 0);
signal up_add_out_2 : std_logic_vector ((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1 downto 0);
signal up_add_out_3 : std_logic_vector ((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1 downto 0);
signal up_add_out_4 : std_logic_vector ((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1 downto 0);
signal up_add_out_5 : std_logic_vector ((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1 downto 0);
signal up_add_out_6 : std_logic_vector ((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1 downto 0);
signal up_add_out_7 : std_logic_vector ((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1 downto 0);

signal dw_mul_out_1 : std_logic_vector (data_width+coeff_width-1 downto 0);
signal dw_mul_out_2 : std_logic_vector (data_width+coeff_width-1 downto 0);
signal dw_mul_out_3 : std_logic_vector (data_width+coeff_width-1 downto 0);
signal dw_mul_out_4 : std_logic_vector (data_width+coeff_width-1 downto 0);
signal dw_mul_out_5 : std_logic_vector (data_width+coeff_width-1 downto 0);
signal dw_mul_out_6 : std_logic_vector (data_width+coeff_width-1 downto 0);
signal dw_mul_out_7 : std_logic_vector (data_width+coeff_width-1 downto 0);
signal dw_mul_out_8 : std_logic_vector (data_width+coeff_width-1 downto 0);

signal dw_add_out_1 : std_logic_vector ((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1 downto 0);
signal dw_add_out_2 : std_logic_vector ((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1 downto 0);
signal dw_add_out_3 : std_logic_vector ((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1 downto 0);
signal dw_add_out_4 : std_logic_vector ((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1 downto 0);
signal dw_add_out_5 : std_logic_vector ((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1 downto 0);
signal dw_add_out_6 : std_logic_vector ((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1 downto 0);
signal dw_add_out_7 : std_logic_vector ((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1 downto 0);

signal up_valid_out_1 : std_logic ;
signal up_valid_out_2 : std_logic ;
signal up_valid_out_3 : std_logic ;
signal up_valid_out_4 : std_logic ;
signal up_valid_out_5 : std_logic ;
signal up_valid_out_6 : std_logic ;
signal up_valid_out_7 : std_logic ;
signal up_valid_out_8 : std_logic ;
signal up_valid_out_9 : std_logic ;

signal dw_valid_out_1 : std_logic ;
signal dw_valid_out_2 : std_logic ;
signal dw_valid_out_3 : std_logic ;
signal dw_valid_out_4 : std_logic ;
signal dw_valid_out_5 : std_logic ;
signal dw_valid_out_6 : std_logic ;
signal dw_valid_out_7 : std_logic ;
signal dw_valid_out_8 : std_logic ;
signal dw_valid_out_9 : std_logic ;

signal x_reg_up_12 : std_logic_vector ( data_width-1 downto 0) := (others => '0');
signal x_reg_up_23 : std_logic_vector ( data_width-1 downto 0) := (others => '0');
signal x_reg_dw_23 : std_logic_vector ( data_width-1 downto 0) := (others => '0');
signal x_reg_dw_34 : std_logic_vector ( data_width-1 downto 0) := (others => '0');

type   register_array_2 is array (1 downto 0) of std_logic_vector ( data_width-1 downto 0);
signal x_reg_up_34 : register_array_2 := (others => (others => '0'));
signal x_reg_up_45 : register_array_2 := (others => (others => '0'));
signal x_reg_dw_45 : register_array_2 := (others => (others => '0'));
signal x_reg_dw_56 : register_array_2 := (others => (others => '0'));

type   register_array_3 is array (2 downto 0) of std_logic_vector ( data_width-1 downto 0);
signal x_reg_up_56 : register_array_3 := (others => (others => '0'));
signal x_reg_up_67 : register_array_3 := (others => (others => '0'));
signal x_reg_dw_67 : register_array_3 := (others => (others => '0'));
signal x_reg_dw_78 : register_array_3 := (others => (others => '0'));

type   register_array_4 is array (3 downto 0) of std_logic_vector ( data_width-1 downto 0);
signal x_reg_up_78 : register_array_4 := (others => (others => '0'));

signal sherlock : std_logic_vector (data_width-1 downto 0);
signal acc:  std_logic_vector((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1 downto 0) :=   (others => '0');
begin
    process(clk,rst)
    begin
        if(rst = '1') then
            -- Mhdenizoume olous tous register
            x_reg_up_12   <=  (others => '0');
            x_reg_up_23   <=  (others => '0');
            x_reg_dw_23   <=  (others => '0');
            x_reg_dw_34   <=  (others => '0');
            x_reg_up_34   <=  (others => (others => '0')); 
            x_reg_up_45   <=  (others => (others => '0'));
            x_reg_dw_45   <=  (others => (others => '0'));
            x_reg_dw_56   <=  (others => (others => '0'));
            x_reg_up_56   <=  (others => (others => '0'));
            x_reg_up_67   <=  (others => (others => '0'));
            x_reg_dw_67   <=  (others => (others => '0'));
            x_reg_dw_78   <=  (others => (others => '0'));
            x_reg_up_78   <=  (others => (others => '0'));
        else 
            if( rising_edge(clk) ) then
                if (valid_in = '1') or (x_0=0 and x_1=0) then
                    x_reg_up(0) <= x_1;
                    x_reg_dw(0) <= x_0;
                    x_reg_up_12 <= x_reg_up(0);

                    
                    x_reg_up(1) <= x_reg_dw(0);
                    x_reg_dw(1) <= x_reg_up(0);
                    x_reg_up_23 <= x_reg_up(1);
                    x_reg_dw_23 <= x_reg_dw(1);


                    x_reg_up(2) <= x_reg_dw(1);
                    x_reg_dw(2) <= x_reg_up(1);
                    x_reg_up_34(0) <= x_reg_up(2);
                    x_reg_up_34(1) <= x_reg_up_34(0);
                    x_reg_dw_34 <= x_reg_dw(2);

                    x_reg_up(3) <= x_reg_dw(2);
                    x_reg_dw(3) <= x_reg_up(2);
                    x_reg_up_45(0) <= x_reg_up(3);
                    x_reg_up_45(1) <= x_reg_up_45(0);
                    x_reg_dw_45(0) <= x_reg_dw(3);
                    x_reg_dw_45(1) <= x_reg_dw_45(0);


                    x_reg_up(4) <= x_reg_dw(3);
                    x_reg_dw(4) <= x_reg_up(3);
                    x_reg_up_56(0) <= x_reg_up(4);
                    x_reg_up_56(1) <= x_reg_up_56(0);
                    x_reg_up_56(2) <= x_reg_up_56(1);
                    x_reg_dw_56(0) <= x_reg_dw(4);
                    x_reg_dw_56(1) <= x_reg_dw_56(0);

                    x_reg_up(5) <= x_reg_dw(4);
                    x_reg_dw(5) <= x_reg_up(4);
                    x_reg_up_67(0) <= x_reg_up(5);
                    x_reg_up_67(1) <= x_reg_up_67(0);
                    x_reg_up_67(2) <= x_reg_up_67(1);
                    x_reg_dw_67(0) <= x_reg_dw(5);
                    x_reg_dw_67(1) <= x_reg_dw_67(0);
                    x_reg_dw_67(2) <= x_reg_dw_67(1);

                    x_reg_up(6) <= x_reg_dw(5);
                    x_reg_dw(6) <= x_reg_up(5);
                    x_reg_up_78(0) <= x_reg_up(6);
                    x_reg_up_78(1) <= x_reg_up_78(0);
                    x_reg_up_78(2) <= x_reg_up_78(1);
                    x_reg_up_78(3) <= x_reg_up_78(2);
                    x_reg_dw_78(0) <= x_reg_dw(6);
                    x_reg_dw_78(1) <= x_reg_dw_78(0);
                    x_reg_dw_78(2) <= x_reg_dw_78(1);
                

                end if;
                valid_out <= up_valid_out_8;
            end if;
          end if;
    end process;    
MUL_1_up:
    
    MUL_unit port map(
    x => x_0        ,
    h => coeff(0) ,
    clk => clk    ,
    valid_in => valid_in ,
    valid_out => up_valid_out_1,
    mul_res => up_mul_out_1       
    );

ADD_1_up:
   ADD_unit port map (
   mul_res => up_mul_out_1,
   acc     => acc,
   clk     => clk,
   y_temp  => up_add_out_1     
   );

MUL_1_dw:    
   MUL_unit port map(
   x => x_1        ,
   h => coeff(0) ,
   clk => clk    ,
   valid_in =>  valid_in ,
   valid_out => dw_valid_out_1,
   mul_res => dw_mul_out_1       
   );

ADD_1_dw:
  ADD_unit port map (
  mul_res => dw_mul_out_1,
  acc     => acc,
  clk     => clk,
  y_temp  => dw_add_out_1     
  );

MUL_2_up:
    
    MUL_unit port map(
    x => x_reg_up_12,
    h => coeff(1) ,
    clk => clk    ,
    valid_in => up_valid_out_1 ,
    valid_out => up_valid_out_2,
    mul_res => up_mul_out_2       
    );

ADD_2_up:
   ADD_unit port map (
   mul_res => up_mul_out_2,
   acc     => up_add_out_1,
   clk     => clk,
   y_temp  => up_add_out_2     
   );

MUL_2_dw:  
   MUL_unit port map(
   x => x_reg_dw(0),
   h => coeff(1) ,
   clk => clk    ,
   valid_in => dw_valid_out_1 ,
   valid_out => dw_valid_out_2,
   mul_res => dw_mul_out_2       
   );

ADD_2_dw:
  ADD_unit port map (
  mul_res => dw_mul_out_2,
  acc     => dw_add_out_1,
  clk     => clk,
  y_temp  => dw_add_out_2     
  );
  
MUL_3_up:  
  MUL_unit port map(
  x => x_reg_up_23,
  h => coeff(2) ,
  clk => clk    ,
  valid_in => up_valid_out_2 ,
  valid_out => up_valid_out_3,
  mul_res => up_mul_out_3       
  );

ADD_3_up:
 ADD_unit port map (
 mul_res => up_mul_out_3,
 acc     => up_add_out_2,
 clk     => clk,
 y_temp  => up_add_out_3     
 );

MUL_3_dw:  
 MUL_unit port map(
 x => x_reg_dw_23,
 h => coeff(2) ,
 clk => clk    ,
 valid_in => dw_valid_out_2 ,
 valid_out => dw_valid_out_3,
 mul_res => dw_mul_out_3       
 );

ADD_3_dw:
ADD_unit port map (
mul_res => dw_mul_out_3,
acc     => dw_add_out_2,
clk     => clk,
y_temp  => dw_add_out_3     
);

MUL_4_up:  
 MUL_unit port map(
 x => x_reg_up_34(1),
 h => coeff(3) ,
 clk => clk    ,
 valid_in => up_valid_out_3 ,
 valid_out => up_valid_out_4,
 mul_res => up_mul_out_4       
 );

ADD_4_up:
ADD_unit port map (
mul_res => up_mul_out_4,
acc     => up_add_out_3,
clk     => clk,
y_temp  => up_add_out_4     
);

MUL_4_dw:  
 MUL_unit port map(
 x => x_reg_dw_34,
 h => coeff(3) ,
 clk => clk    ,
 valid_in => dw_valid_out_3 ,
 valid_out => dw_valid_out_4,
 mul_res => dw_mul_out_4       
 );

ADD_4_dw:
ADD_unit port map (
mul_res => dw_mul_out_4,
acc     => dw_add_out_3,
clk     => clk,
y_temp  => dw_add_out_4     
);

MUL_5_up:  
 MUL_unit port map(
 x => x_reg_up_45(1),
 h => coeff(4) ,
 clk => clk    ,
 valid_in => up_valid_out_4 ,
 valid_out => up_valid_out_5,
 mul_res => up_mul_out_5       
 );

ADD_5_up:
ADD_unit port map (
mul_res => up_mul_out_5,
acc     => up_add_out_4,
clk     => clk,
y_temp  => up_add_out_5     
);

MUL_5_dw:  
 MUL_unit port map(
 x => x_reg_dw_45(1),
 h => coeff(4) ,
 clk => clk    ,
 valid_in => dw_valid_out_4 ,
 valid_out => dw_valid_out_5,
 mul_res => dw_mul_out_5       
 );

ADD_5_dw:
ADD_unit port map (
mul_res => dw_mul_out_5,
acc     => dw_add_out_4,
clk     => clk,
y_temp  => dw_add_out_5     
);

MUL_6_up:  
 MUL_unit port map(
 x => x_reg_up_56(2),
 h => coeff(5) ,
 clk => clk    ,
 valid_in => up_valid_out_5 ,
 valid_out => up_valid_out_6,
 mul_res => up_mul_out_6       
 );

ADD_6_up:
ADD_unit port map (
mul_res => up_mul_out_6,
acc     => up_add_out_5,
clk     => clk,
y_temp  => up_add_out_6     
);

MUL_6_dw:  
 MUL_unit port map(
 x => x_reg_dw_56(1),
 h => coeff(5) ,
 clk => clk    ,
 valid_in => dw_valid_out_5 ,
 valid_out => dw_valid_out_6,
 mul_res => dw_mul_out_6       
 );

ADD_6_dw:
ADD_unit port map (
mul_res => dw_mul_out_6,
acc     => dw_add_out_5,
clk     => clk,
y_temp  => dw_add_out_6     
);

MUL_7_up:  
 MUL_unit port map(
 x => x_reg_up_67(2),
 h => coeff(6) ,
 clk => clk    ,
 valid_in => up_valid_out_6 ,
 valid_out => up_valid_out_7,
 mul_res => up_mul_out_7       
 );

ADD_7_up:
ADD_unit port map (
mul_res => up_mul_out_7,
acc     => up_add_out_6,
clk     => clk,
y_temp  => up_add_out_7     
);

MUL_7_dw:  
 MUL_unit port map(
 x => x_reg_dw_67(2),
 h => coeff(6) ,
 clk => clk    ,
 valid_in => dw_valid_out_6 ,
 valid_out => dw_valid_out_7,
 mul_res => dw_mul_out_7       
 );

ADD_7_dw:
ADD_unit port map (
mul_res => dw_mul_out_7,
acc     => dw_add_out_6,
clk     => clk,
y_temp  => dw_add_out_7     
);

MUL_8_up:  
 MUL_unit port map(
 x => x_reg_up_78(3),
 h => coeff(7) ,
 clk => clk    ,
 valid_in => up_valid_out_7 ,
 valid_out => up_valid_out_8,
 mul_res => up_mul_out_8       
 );

ADD_8_up:
ADD_unit port map (
mul_res => up_mul_out_8,
acc     => up_add_out_7,
clk     => clk,
y_temp  => y_0     
);


MUL_8_dw:  
 MUL_unit port map(
 x => x_reg_dw_78(2),
 h => coeff(7) ,
 clk => clk    ,
 valid_in => dw_valid_out_7 ,
 valid_out => dw_valid_out_8,
 mul_res => dw_mul_out_8       
 );

ADD_8_dw:
ADD_unit port map (
mul_res => dw_mul_out_8,
acc     => dw_add_out_7,
clk     => clk,
y_temp  => y_1     
);

end Behavioral;
