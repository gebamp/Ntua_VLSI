library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity OR_GATE_seq is
      Port (A_or: in STD_LOGIC;
            B_or: in STD_LOGIC;
            or_reset: in STD_LOGIC;
            or_clk: in STD_LOGIC;
            O_or: out STD_LOGIC);
end OR_GATE_seq;

architecture my_arch of OR_GATE_seq is
begin  
  process(or_clk)
        begin
            if(rising_edge(or_clk)) then
                if(or_reset = '1') then
                    O_or <= '0';
                else  
                    O_or <= A_or or B_or;
                end if;
            end if;
  end process;
end my_arch;
