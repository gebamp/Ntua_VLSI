library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity OR_GATE_seq is
      Port (A: in STD_LOGIC;
            B: in STD_LOGIC;
            CLK: in STD_LOGIC;
            RESET: in STD_LOGIC;
            O: out STD_LOGIC);
end OR_GATE_seq;

architecture my_arch of OR_GATE_seq is
begin  
  process(clock)
        begin
            if(rising_edge(clock)) then
                if(RESET = '1') then
                    O <= '0';
                else  
                    O <= A or B;
                end if;
            end if;
  end process;
end my_arch;
