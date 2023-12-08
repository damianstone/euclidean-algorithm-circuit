library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity REG is 
    port (clk, reset, load: in std_logic;
          I: in std_logic_vector(7 downto 0);
          O: out std_logic_vector(7 downto 0));
end REG;

architecture BEHAV of REG is
    process(clk, reset)
    begin
        if reset = '1' then
            O <= (others => '0');
        elsif rising_edge(clk) then
            if load = '1' then
                O <= I;
            else
                O <= (others => 'Z');
            end if;
        end if;
    end process;
end BEHAV;