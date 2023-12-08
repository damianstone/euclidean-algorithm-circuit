library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SUBSTRACT is
    Port ( A, B : in  STD_LOGIC_VECTOR (7 downto 0);
           Y : out  STD_LOGIC_VECTOR (7 downto 0));
end SUBSTRACT;

architecture BEHAV of SUBSTRACT is
  begin
    Y <= A - B;
end BEHAV;