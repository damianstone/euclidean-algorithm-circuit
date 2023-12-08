library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity COMPARATOR is
  port(A, B : in STD_LOGIC_VECTOR(7 downto 0);
       AequalB : out STD_LOGIC;
       AlessB : out STD_LOGIC);
end COMPARATOR;

architecture BEHAV of COMPARATOR is
begin
  AequalB <= '1' when A = B else '0';
  AlessB <= '1' when A < B else '0';
end BEHAV;