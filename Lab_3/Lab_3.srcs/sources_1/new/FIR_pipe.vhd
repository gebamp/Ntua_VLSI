library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;

entity FIR_pipe is
generic(
    data_width :   integer    := 8;
    coeff_width:   integer    := 8;
    min_vector_size: integer  := 8
);

    Port ( 
          x : in std_logic_vector( data_width-1 downto 0);
          clk : in std_logic;
          rst : in std_logic;
          valid_in : in std_logic;
          valid_out : out std_logic;
          y : out std_logic_vector((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1  downto 0) 
          );
end FIR_pipe;

architecture Behavioral of FIR_pipe is
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
        generic(
            data_width :   integer    := 8;
            coeff_width:   integer    := 8;
            min_vector_size: integer  := 8
        );
        port(
        mul_res  : in std_logic_vector (data_width+coeff_width-1 downto 0);
        acc      : in std_logic_vector ((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1 downto 0);
        clk      : in std_logic ;
        y_temp   : out std_logic_vector((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1  downto 0)    
        );
    end component;
    
    type   x_register is array (6 downto 0) of std_logic_vector ( data_width-1 downto 0);
    signal x_reg : x_register := (others => (others => '0'));
   
    
    type   coeff_mem is array (7 downto 0) of std_logic_vector ( coeff_width-1 downto 0);
    signal coeff : coeff_mem :=( "00001000",
                                  "00000111",
                                  "00000110",
                                  "00000101",
                                  "00000100",
                                  "00000011",
                                  "00000010",
                                  "00000001");
    signal mul_out_1 : std_logic_vector (data_width+coeff_width-1 downto 0);
    signal mul_out_2 : std_logic_vector (data_width+coeff_width-1 downto 0);
    signal mul_out_3 : std_logic_vector (data_width+coeff_width-1 downto 0);
    signal mul_out_4 : std_logic_vector (data_width+coeff_width-1 downto 0);
    signal mul_out_5 : std_logic_vector (data_width+coeff_width-1 downto 0);
    signal mul_out_6 : std_logic_vector (data_width+coeff_width-1 downto 0);
    signal mul_out_7 : std_logic_vector (data_width+coeff_width-1 downto 0);
    signal mul_out_8 : std_logic_vector (data_width+coeff_width-1 downto 0);

    signal add_out_1 : std_logic_vector ((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1 downto 0);
    signal add_out_2 : std_logic_vector ((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1 downto 0);
    signal add_out_3 : std_logic_vector ((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1 downto 0);
    signal add_out_4 : std_logic_vector ((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1 downto 0);
    signal add_out_5 : std_logic_vector ((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1 downto 0);
    signal add_out_6 : std_logic_vector ((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1 downto 0);
    signal add_out_7 : std_logic_vector ((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1 downto 0);

    signal valid_out_1 : std_logic ;
    signal valid_out_2 : std_logic ;
    signal valid_out_3 : std_logic ;
    signal valid_out_4 : std_logic ;
    signal valid_out_5 : std_logic ;
    signal valid_out_6 : std_logic ;
    signal valid_out_7 : std_logic ;
    signal valid_out_8 : std_logic ;
    signal valid_out_9 : std_logic ;
    
    
    signal x_temp_1 : std_logic_vector(data_width-1 downto 0) := (others => '0');
    signal x_temp_2 : std_logic_vector(data_width-1 downto 0) := (others => '0');
    signal x_temp_3 : std_logic_vector(data_width-1 downto 0) := (others => '0');
    signal x_temp_4 : std_logic_vector(data_width-1 downto 0) := (others => '0');
    signal x_temp_5 : std_logic_vector(data_width-1 downto 0) := (others => '0');
    signal x_temp_6 : std_logic_vector(data_width-1 downto 0) := (others => '0');
    signal x_temp_7 : std_logic_vector(data_width-1 downto 0) := (others => '0');
    
    signal acc:  std_logic_vector((data_width + coeff_width + integer(ceil(log2(real(min_vector_size)))))-1 downto 0) :=   (others => '0');                               
    begin
    
    process(clk,rst)
    begin
        if(rst = '1') then
            x_reg    <= (others => (others => '0'));
            x_temp_1 <= (others => '0');
            x_temp_2 <= (others => '0');
            x_temp_3 <= (others => '0');
            x_temp_4 <= (others => '0');
            x_temp_5 <= (others => '0');
            x_temp_6 <= (others => '0');
            x_temp_7 <= (others => '0');
        else 
            if( rising_edge(clk) ) then
                if (valid_in = '1') or x=0 then
                    x_temp_1 <= x;
                    x_reg(0) <= x_temp_1;
                    x_temp_2 <= x_reg(0);
                    x_reg(1) <= x_temp_2;
                    x_temp_3 <= x_reg(1);
                    x_reg(2) <= x_temp_3;
                    x_temp_4 <= x_reg(2);
                    x_reg(3) <= x_temp_4;
                    x_temp_5 <= x_reg(3);
                    x_reg(4) <= x_temp_5;
                    x_temp_6 <= x_reg(4);
                    x_reg(5) <= x_temp_6;
                    x_temp_7 <= x_reg(5);
                    x_reg(6) <= x_temp_7;
                end if;
                valid_out <= valid_out_8;
            end if;
          end if;
    end process;    
    
MUL_1:
     MUL_unit port map(
     x => x        ,
     h => coeff(0) ,
     clk => clk    ,
     valid_in => valid_in ,
     valid_out => valid_out_1,
     mul_res => mul_out_1       
     );

ADD_1:
    ADD_unit port map (
    mul_res => mul_out_1,
    acc     => acc,
    clk     => clk,
    y_temp  => add_out_1     
    );

MUL_2:
     MUL_unit port map(
     x => x_reg(0)        ,
     h => coeff(1) ,
     clk => clk    ,
     valid_in => valid_out_1 ,
     valid_out => valid_out_2,
     mul_res => mul_out_2       
     );

ADD_2:
    ADD_unit port map (
    mul_res => mul_out_2,
    acc     => add_out_1,
    clk     => clk,
    y_temp  => add_out_2     
    );

MUL_3:
     MUL_unit port map(
     x => x_reg(1)        ,
     h => coeff(2) ,
     clk => clk    ,
     valid_in => valid_out_2 ,
     valid_out => valid_out_3,
     mul_res => mul_out_3       
     );

ADD_3:
    ADD_unit port map (
    mul_res => mul_out_3,
    acc     => add_out_2,
    clk     => clk,
    y_temp  => add_out_3     
    );

MUL_4:
     MUL_unit port map(
     x => x_reg(2)        ,
     h => coeff(3) ,
     clk => clk    ,
     valid_in => valid_out_3 ,
     valid_out => valid_out_4,
     mul_res => mul_out_4       
     );

ADD_4:
    ADD_unit port map (
    mul_res => mul_out_4,
    acc     => add_out_3,
    clk     => clk,
    y_temp  => add_out_4     
    );


MUL_5:
     MUL_unit port map(
     x => x_reg(3)        ,
     h => coeff(4) ,
     clk => clk    ,
     valid_in => valid_out_4 ,
     valid_out => valid_out_5,
     mul_res => mul_out_5       
     );

ADD_5:
    ADD_unit port map (
    mul_res => mul_out_5,
    acc     => add_out_4,
    clk     => clk,
    y_temp  => add_out_5     
    );

MUL_6:
     MUL_unit port map(
     x => x_reg(4)        ,
     h => coeff(5) ,
     clk => clk    ,
     valid_in => valid_out_5 ,
     valid_out => valid_out_6,
     mul_res => mul_out_6       
     );

ADD_6:
    ADD_unit port map (
    mul_res => mul_out_6,
    acc     => add_out_5,
    clk     => clk,
    y_temp  => add_out_6     
    );

MUL_7:
     MUL_unit port map(
     x => x_reg(5)        ,
     h => coeff(6) ,
     clk => clk    ,
     valid_in => valid_out_6 ,
     valid_out => valid_out_7,
     mul_res => mul_out_7       
     );

ADD_7:
    ADD_unit port map (
    mul_res => mul_out_7,
    acc     => add_out_6,
    clk     => clk,
    y_temp  => add_out_7     
    );

MUL_8:
     MUL_unit port map(
     x => x_reg(6) ,
     h => coeff(7) ,
     clk => clk    ,
     valid_in => valid_out_7 ,
     valid_out => valid_out_8,
     mul_res => mul_out_8       
     );

ADD_8:
    ADD_unit port map (
    mul_res => mul_out_8,
    acc     => add_out_7,
    clk     => clk,
    y_temp  => y     
    );

end Behavioral;
