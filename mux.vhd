library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MUX is
    Port ( 
        Sel : in STD_LOGIC_VECTOR(1 downto 0);
        A, B : in STD_LOGIC_VECTOR(7 downto 0);  
        C : out STD_LOGIC_VECTOR(7 downto 0)
    );
end MUX;

architecture BEHAV of MUX is
    process (Sel, A, B)
    begin
        if Sel == '0' then
            C <= A;
        else Sel == '1' then
            C <= B;
        end if;
    end process;
end BEHAV;
